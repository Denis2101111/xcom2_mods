
class X2EventListener_WOTC_APA_Reaper extends X2EventListener config(WOTC_APA_ReaperSkills);

var config int			REAPER_AGENT_PER_UPGRADE;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateOverrideUnitFocusUIListenerTemplate());
	Templates.AddItem(CreateRetainConcealmentOnActivationListenerTemplate());
	Templates.AddItem(CreateValidateGTSClassTrainingListenerTemplate());

	return Templates;
}

// 'OverrideUnitFocusUI' event listeners
static function X2EventListenerTemplate CreateOverrideUnitFocusUIListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_ReaperUnitFocusUI');

	Template.RegisterInTactical = true;
	Template.AddCHEvent('OverrideUnitFocusUI', ReaperOnOverrideFocus, ELD_Immediate);

	return Template;
}

		// Handle UI for Reaper's Focus Mechanic
		static function EventListenerReturn ReaperOnOverrideFocus(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComGameState_Unit UnitState;
			local XComLWTuple Tuple;
			local int CurrentStacks, MaxStacks;
			local string TooltipLong, TooltipShort, Icon;
			local UnitValue ShadowStacksValue;
			local string BarColor;


			Tuple = XComLWTuple(EventData);
			UnitState = XComGameState_Unit(EventSource);

			// Unit must be concealed for Shadow Stacks to be in-play
			if (!UnitState.IsConcealed())
			{
				return ELR_NoInterrupt;
			}

			// Unit must have the appropriate ability for Shadow Stacks to be in-play
			if (UnitState.HasSoldierAbility('WOTC_APA_Shadow'))
			{
				//BarColor = "a28752"; // Tan from Reaper's Faction Logo
				BarColor = "796338"; // Tan similar to Reaper's Faction Logo
				TooltipLong = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.strShadowStackDesc;
				TooltipShort = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.strShadowStackName;
				Icon = "img:///UILibrary_WOTC_APA_Reaper.FocusIcon_Reaper";

				UnitState.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_MAX_NAME, ShadowStacksValue);
				MaxStacks = ShadowStacksValue.fValue;

				UnitState.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue);
				CurrentStacks = ShadowStacksValue.fValue;
								
				Tuple.Data[0].b = true;
				Tuple.Data[1].i = CurrentStacks;
				Tuple.Data[2].i = MaxStacks;
				Tuple.Data[3].s = BarColor;
				Tuple.Data[4].s = Icon;
				Tuple.Data[5].s = TooltipLong;
				Tuple.Data[6].s = TooltipShort;
			}

			return ELR_NoInterrupt;
		}



// 'RetainConcealmentOnActivation' event listeners
static function CHEventListenerTemplate CreateRetainConcealmentOnActivationListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_Reaper_OverrideRetainConcealmentOnActivation');

	Template.RegisterInTactical = true;

	Template.AddCHEvent('RetainConcealmentOnActivation', SilentKillerRetainConcealmentOnActivation, ELD_Immediate);
	return Template;
}

		// Retain individual concealment when the unit has the Silent Killer ability and kills a target with a Primary or Secondary weapon attack
		static function EventListenerReturn SilentKillerRetainConcealmentOnActivation(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComLWTuple								Tuple;
			local XComGameStateContext_Ability				AbilityContext;
			local XComGameState_Ability						AbilityState;
			local XComGameState_Unit						Attacker, Target;
			local XComGameState_Destructible				DestructibleTarget;
			local XComGameState_Player						PlayerState;
			local UnitValue									ShadowStacksValue;
			local bool										bRetainConcealment, bValidAttack;
			local bool										bPrimaryWeapon, bSecondaryWeapon;
			local int										iCost;
						

			Tuple = XComLWTuple(EventData);
			AbilityContext = XComGameStateContext_Ability(EventSource);
			AbilityState = XComGameState_Ability(GameState.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
			Attacker = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
			Target = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
			DestructibleTarget = XComGameState_Destructible(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
			PlayerState = XComGameState_Player(`XCOMHISTORY.GetGameStateForObjectID(Attacker.ControllingPlayer.ObjectID));
			bRetainConcealment = Tuple.Data[0].b;

			// Attacker must have the Silent Killer effect/ability and expect to be revealed
			if (Attacker.AffectedByEffectNames.Find('WOTC_APA_SilentKiller') != -1 && !bRetainConcealment)
			{
				// Attack must not be from an excluded ability (Faceoff, Banish, etc.)
				if (class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SILENT_KILLER_EXCLUDED_ABILITIES.Find(AbilityState.GetMyTemplateName()) == -1)
				{
					// Source weapon must be either the attacker's primary or secondary weapon
					if (AbilityState.SourceWeapon == Attacker.GetPrimaryWeapon().GetReference())
					{
						bPrimaryWeapon = true;
						iCost = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_PRIMARY_ATTACK_COST;
					}
					else if (AbilityState.SourceWeapon == Attacker.GetSecondaryWeapon().GetReference())
					{
						bSecondaryWeapon = true;
						iCost = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_SECONDARY_ATTACK_COST;
					}

					if (bPrimaryWeapon || bSecondaryWeapon)
					{
						// Attack must be a targeted shot (no AOEs) and the Target must be dead or bleeding out
						if (AbilityState.GetMyTemplate().AbilityMultiTargetStyle == none && (Target.IsDead() || Target.bBleedingOut))
						{
							bValidAttack = true;
						}
						else if (DestructibleTarget != none && DestructibleTarget.Health == 0)
						{
							bValidAttack = true;
						}
						else if (AbilityState.GetMyTemplate().AbilityMultiTargetStyle == none && bSecondaryWeapon && Attacker.AffectedByEffectNames.Find('WOTC_APA_Undermine') != -1)
						{
							bValidAttack = true;
						}

						if (bValidAttack)
						{
							Attacker.GetUnitValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue);
							if (ShadowStacksValue.fValue >= iCost)
							{
								// Retain individual concealment, but still break general squad concealment
								Tuple.Data[0].b = true;
								EventSource = Tuple;

								ShadowStacksValue.fValue = Max(0, ShadowStacksValue.fValue - iCost);
								Attacker.SetUnitFloatValue(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CURRENT_NAME, ShadowStacksValue.fValue, eCleanup_BeginTactical);
						
								class'X2Ability_WOTC_APA_ReaperAbilitySet'.static.BreakSquadConcealment(PlayerState, GameState);
								GameState.GetContext().PostBuildVisualizationFn.AddItem(class'X2Ability_WOTC_APA_ReaperAbilitySet'.static.BasicSourceFlyover_BuildVisualization);
			}	}	}	}	}

			return ELR_NoInterrupt;
		}



// 'ValidateGTSClassTraining' event listeners
static function CHEventListenerTemplate CreateValidateGTSClassTrainingListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_ReaperValidateGTSClassTraining');

	Template.RegisterInTactical = false;
	Template.RegisterInStrategy = true;
	Template.AddCHEvent('ValidateGTSClassTraining', ReaperValidateGTSClassTraining, ELD_Immediate);
	
	return Template;
}

		// Enable GTS Training and Choose My Class promotion of Reaper Agents
		static function EventListenerReturn ReaperValidateGTSClassTraining(Object EventData, Object EventSource, XComGameState NewGameState, Name Event, Object CallbackData)
		{
			local XComLWTuple				OverrideTuple;
			local X2SoldierClassTemplate	SoldierClassTemplate;

			OverrideTuple = XComLWTuple(EventData);

			if (OverrideTuple != none)
			{
				SoldierClassTemplate = X2SoldierClassTemplate(OverrideTuple.Data[1].o);
				if (SoldierClassTemplate != none && SoldierClassTemplate.DataName == 'WOTC_APA_ReaperAgent')
				{
					if (IsReaperAgentAvailable())
					{
						OverrideTuple.Data[0].b = true;
					}
				}
			}
			return ELR_NoInterrupt;
		}

		static private function bool IsReaperAgentAvailable()
		{
			local XComGameState_HeadquartersXCom XComHQ;
			local XComGameState_HeadquartersProjectTrainRookie TrainProject;
			local XComGameState_Unit HQUnitState;
			local XComGameStateHistory History;
			local name TemplateName;
			local int i, j, NumUnlocks;

			XComHQ = `XCOMHQ;
			History = `XCOMHISTORY;

			// No Reaper Agents Given
			if (default.REAPER_AGENT_PER_UPGRADE == 0)
				return false;

			// Get number of Unlocks purchased
			foreach XComHQ.SoldierUnlockTemplates(TemplateName)
			{
				if (TemplateName == 'WOTC_APA_ReaperUnlock1' || TemplateName == 'WOTC_APA_ReaperUnlock2')
				{
					NumUnlocks++;
			}	}
			
			// Compare current Reaper Agents vs current limit
			if (NumUnlocks > 0)
			{
				if (default.REAPER_AGENT_PER_UPGRADE > 0)
				{
					// Count number of soldiers currently training to become Reaper Agents
					///**/`Log("WOTC_APA_Reaper - Checking HQ Projects:");
					foreach History.IterateByClassType(class'XComGameState_HeadquartersProjectTrainRookie', TrainProject)
					{
						///**/`Log("WOTC_APA_Reaper - HQ Train Project:" @ TrainProject.NewClassName);
						if (TrainProject.NewClassName == 'WOTC_APA_ReaperAgent')
						{
							j++;
							///**/`Log("WOTC_APA_Reaper - HQ Projects Found:" @ string(j));
							if (j >= default.REAPER_AGENT_PER_UPGRADE * NumUnlocks)
							{
								return false;
					}	}	}

					// Count number of Reaper Agents
					///**/`Log("WOTC_APA_Reaper - Checking HQ Soldiers:");
					for (i = 0; i < XComHQ.Crew.Length; i++)
					{
						HQUnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Crew[i].ObjectID));
						if(HQUnitState != none && HQUnitState.IsSoldier())
						{
							if (HQUnitState.GetSoldierClassTemplate().DataName == 'WOTC_APA_ReaperAgent')
							{
								j++;
								///**/`Log("WOTC_APA_Reaper - HQ Soldiers Found:" @ string(j));
								if (j >= default.REAPER_AGENT_PER_UPGRADE * NumUnlocks)
								{
									return false;
				}	}	}	}	}
				return true;
			}

			return false;
		}