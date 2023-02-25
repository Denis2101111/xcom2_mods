
class X2EventListener_WOTC_APA_Class_Pack extends X2EventListener;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateCleanupTacticalMissionListenerTemplate());
	Templates.AddItem(CreatePreAcquiredHackRewardListenerTemplate());
	Templates.AddItem(CreateOnGetItemRangeListenerTemplate());
	Templates.AddItem(CreateRetainConcealmentOnActivationListenerTemplate());
	Templates.AddItem(CreateModifyEnvironmentDamageListenerTemplate());
	Templates.AddItem(CreateOnProjectileFireSoundListenerTemplate());
	Templates.AddItem(CreateUnitRankUpListenerTemplate());

	return Templates;
}



// 'CleanupTacticalMission' event listeners
static function CHEventListenerTemplate CreateCleanupTacticalMissionListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_Class_OverrideCleanupTacticalMission');

	Template.RegisterInTactical = true;

	Template.AddCHEvent('CleanupTacticalMission', MedivacOverrideCleanupTacticalMission, ELD_Immediate, 75);
	return Template;
}

		// Apply post-mission healing from Medivac
		static function EventListenerReturn MedivacOverrideCleanupTacticalMission(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComGameStateHistory		History;
			local XComGameState_Unit		TargetUnit;
			local XComGameState_Effect		EffectState;
			local StateObjectReference		EffectRef;
			local array<XComGameState_Item> CurrentInventory;
			local XComGameState_Item		InventoryItem;
			local X2WeaponTemplate			WeaponTemplate;
			local int						iMedivacHealingCharges;
			local bool						bLog;

			bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

			History = `XCOMHISTORY;

			// Process Medivac Post-Mission Healing Effects:
			// ---------------------------------------------
			// Get total number of Medivac Healing charges (unused Medikit ammo on Medivac source units)
			foreach History.IterateByClassType(class'XComGameState_Unit', TargetUnit)
			{
				// Source units must be alive, conscious, and must not be mind-controlled/captured
				if (TargetUnit.IsAlive() && !TargetUnit.bBleedingOut && !TargetUnit.bUnconscious && !TargetUnit.IsMindControlled())
				{
					foreach TargetUnit.AffectedByEffects(EffectRef)
					{
						// Source unit must be under the MedivacSource effect
						EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
						if (EffectState.GetX2Effect().EffectName == class'X2Effect_WOTC_APA_MedivacSource'.default.EffectName)
						{
							// Apply bonus charges from Medivac, if present
							if (TargetUnit.HasSoldierAbility('WOTC_APA_Medivac'))
							{
								iMedivacHealingCharges += class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MEDIVAC_BONUS_HEAL_CHARGES;
							}

							// Get Source unit's current inventory items to parse through
							CurrentInventory = TargetUnit.GetAllInventoryItems(GameState);
					
							// Loop through Source unit's inventory to find Medikit items and their remaining ammo
							foreach CurrentInventory(InventoryItem)
							{
								WeaponTemplate = X2WeaponTemplate(InventoryItem.GetMyTemplate());
								if (WeaponTemplate.WeaponCat == 'medikit')
								{
									iMedivacHealingCharges += InventoryItem.Ammo;
			}	}	}	}	}	}

			/**/`Log("WOTC_APA_Medic - Medivac: Total healing charges available: " $ iMedivacHealingCharges, bLog);
	
			// Loop through units to apply Medivac Healing charges where appropriate
			if (iMedivacHealingCharges > 0)
			{
				foreach History.IterateByClassType(class'XComGameState_Unit', TargetUnit)
				{
					// TargetUnit must be alive and must not be robotic, left bleeding out, or mind-controlled/captured
					if (TargetUnit.IsAlive() && !TargetUnit.IsRobotic() && !TargetUnit.bBleedingOut && !TargetUnit.IsMindControlled())
					{
						foreach TargetUnit.AffectedByEffects(EffectRef)
						{
							// TargetUnit must be under the Medivac effect
							EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
							if (EffectState.GetX2Effect().EffectName == class'X2Effect_WOTC_APA_Medivac'.default.EffectName)
							{
								// Attempt to apply Medivac healing effect - if TargetUnit successfully receives the effect, remove charge(s)
								iMedivacHealingCharges -= X2Effect_WOTC_APA_Medivac(EffectState.GetX2Effect()).ApplyMedivacHealing(EffectState, TargetUnit, GameState);
								break;
							}
						}
						// Stop looping when Medivac Healing charges run out
						if (iMedivacHealingCharges == 0) break;
			}	}	}
	
			return ELR_NoInterrupt;
		}



// 'PreAcquiredHackReward' event listeners
static function CHEventListenerTemplate CreatePreAcquiredHackRewardListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_Class_OverridePreAcquiredHackReward');

	Template.RegisterInTactical = true;

	Template.AddCHEvent('PreAcquiredHackReward', FailsafeOverridePreAcquiredHackReward, ELD_Immediate);
	return Template;
}

		// Override negative effects from failed hacks while FailSafe is active
		static function EventListenerReturn FailsafeOverridePreAcquiredHackReward(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComLWTuple				OverrideHackRewardTuple;
			local XComGameState_Unit		Hacker;
			local XComGameState_BaseObject	HackTarget;
			local X2HackRewardTemplate		HackTemplate;
			local bool						bLog;

			bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

			OverrideHackRewardTuple = XComLWTuple(EventData);
			if (OverrideHackRewardTuple == none)
			{
				/**/`Log("WOTC_APA_Specialist - Failsafe: Triggered with no Tuple! (This should not happen!)", bLog);
				return ELR_NoInterrupt;
			}

			HackTemplate = X2HackRewardTemplate(EventSource);
			if (HackTemplate == none)
				return ELR_NoInterrupt;

			if (OverrideHackRewardTuple.Id != 'OverrideHackRewards')
				return ELR_NoInterrupt;

			Hacker = XComGameState_Unit(OverrideHackRewardTuple.Data[1].o);
			HackTarget = XComGameState_BaseObject(OverrideHackRewardTuple.Data[2].o); // not necessarily a unit, could be a Hackable environmental object

			if (Hacker == none || HackTarget == none)
				return ELR_NoInterrupt;

			if (Hacker.AffectedByEffectNames.Find('WOTC_APA_FailsafeEffect') == -1)
				return ELR_NoInterrupt;

			if (HackTemplate.bBadThing)
			{
				OverrideHackRewardTuple.Data[0].b = true;
				`XEVENTMGR.TriggerEvent('WOTC_APA_FailsafeTriggered', Hacker, Hacker, GameState);
			}

			return ELR_NoInterrupt;
		}



// 'OnGetItemRange' event listeners
static function CHEventListenerTemplate CreateOnGetItemRangeListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_Class_OverrideItemRange');

	Template.RegisterInTactical = true;

	Template.AddCHEvent('OnGetItemRange', PrepForEntryOverrideItemRange, ELD_Immediate);
	Template.AddCHEvent('OnGetItemRange', ImpressiveStrengthOverrideItemRange, ELD_Immediate);
	return Template;
}

		// Reduce grenade throw range when Prep for Entry is active
		static function EventListenerReturn PrepForEntryOverrideItemRange(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComLWTuple				OverrideTuple;
			local XComGameState_Item		Item;
			local XComGameState_Ability		Ability;
			local XComGameState_Unit		UnitState;
			local X2GrenadeLauncherTemplate	GLTemplate;
			local X2WeaponTemplate			WeaponTemplate;
			local XComGameState_Item		SourceAmmo;
			local float						fRange;
	
			OverrideTuple = XComLWTuple(EventData);
			if(OverrideTuple == none)
				return ELR_NoInterrupt;

			Item = XComGameState_Item(EventSource);
			if(Item == none)
				return ELR_NoInterrupt;

			if(OverrideTuple.Id != 'GetItemRange')
				return ELR_NoInterrupt;

			Ability = XComGameState_Ability(OverrideTuple.Data[2].o);  // optional ability

			if(Ability == none)
				return ELR_NoInterrupt;

			UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Item.OwnerStateObject.ObjectID));
			if (UnitState.AffectedByEffectNames.Find('WOTC_APA_PrepForEntryEffect') == -1)
				return ELR_NoInterrupt;

			if(class'X2Effect_WOTC_APA_PrepForEntry'.default.PREP_FOR_ENTRY_VALID_ABILITIES.Find(Ability.GetMyTemplateName()) == -1)
				return ELR_NoInterrupt;
		
			// All the validation checks are complete - get the existing range and modify
			GLTemplate = X2GrenadeLauncherTemplate(Item.GetMyTemplate());
			if(GLTemplate != none)
			{
				SourceAmmo = Ability.GetSourceAmmo();
				if(SourceAmmo != none)
				{
					WeaponTemplate = X2WeaponTemplate(SourceAmmo.GetMyTemplate());
					if(WeaponTemplate != none)
					{
						fRange = WeaponTemplate.iRange + GLTemplate.IncreaseGrenadeRange;
			}	}	}

			if (fRange == 0)
			{
				WeaponTemplate = X2WeaponTemplate(Item.GetMyTemplate());
				if(WeaponTemplate != none)
				{
					fRange = WeaponTemplate.iRange;
			}	}
	
			fRange *= class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.PREP_FOR_ENTRY_RANGE_MULTIPLIER;

			// Flag override Tuple as an override and pass the modified value
			OverrideTuple.Data[0].b = true;
			OverrideTuple.Data[1].i = Round(fRange);

			return ELR_NoInterrupt;
		}


		// Increase grenade throw range when the unit has the Impressive Strength ability
		static function EventListenerReturn ImpressiveStrengthOverrideItemRange(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComLWTuple				OverrideTuple;
			local XComGameState_Item		Item;
			local XComGameState_Ability		Ability;
			local XComGameState_Unit		UnitState;
			local X2GrenadeLauncherTemplate	GLTemplate;
			local X2WeaponTemplate			WeaponTemplate;
			local XComGameState_Item		SourceAmmo;
			local float						fRange;
	
			OverrideTuple = XComLWTuple(EventData);
			if(OverrideTuple == none)
				return ELR_NoInterrupt;

			Item = XComGameState_Item(EventSource);
			if(Item == none)
				return ELR_NoInterrupt;

			if(OverrideTuple.Id != 'GetItemRange')
				return ELR_NoInterrupt;

			Ability = XComGameState_Ability(OverrideTuple.Data[2].o);  // optional ability

			if(Ability == none)
				return ELR_NoInterrupt;

			UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Item.OwnerStateObject.ObjectID));
			if (UnitState.HasSoldierAbility('WOTC_APA_ImpressiveStrength') == false)
				return ELR_NoInterrupt;

			if(Ability.GetMyTemplateName() != 'ThrowGrenade')
				return ELR_NoInterrupt;
		
			// All the validation checks are complete - get the existing range and modify
			GLTemplate = X2GrenadeLauncherTemplate(Item.GetMyTemplate());
			if(GLTemplate != none)
			{
				SourceAmmo = Ability.GetSourceAmmo();
				if(SourceAmmo != none)
				{
					WeaponTemplate = X2WeaponTemplate(SourceAmmo.GetMyTemplate());
					if(WeaponTemplate != none)
					{
						fRange = WeaponTemplate.iRange + GLTemplate.IncreaseGrenadeRange;
			}	}	}

			if (fRange == 0)
			{
				WeaponTemplate = X2WeaponTemplate(Item.GetMyTemplate());
				if(WeaponTemplate != none)
				{
					fRange = WeaponTemplate.iRange;
			}	}
	
			fRange *= class'X2Ability_WOTC_APA_MarineAbilitySet'.default.IMPRESSIVE_STRENGTH_THROW_RANGE_MODIFIER;

			// Flag override Tuple as an override and pass the modified value
			OverrideTuple.Data[0].b = true;
			OverrideTuple.Data[1].i = Round(fRange);

			return ELR_NoInterrupt;
		}



// 'RetainConcealmentOnActivation' event listeners
static function CHEventListenerTemplate CreateRetainConcealmentOnActivationListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_Class_OverrideRetainConcealmentOnActivation');

	Template.RegisterInTactical = true;

	Template.AddCHEvent('RetainConcealmentOnActivation', GhostRetainConcealmentOnActivation, ELD_Immediate);
	Template.AddCHEvent('RetainConcealmentOnActivation', ProxyMineRetainConcealmentOnActivation, ELD_Immediate);
	return Template;
}

		// Retain individual concealment when the unit has the Ghost ability and kills a target with no enemies left in visual range
		static function EventListenerReturn GhostRetainConcealmentOnActivation(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComLWTuple								Tuple;
			local XComGameStateContext_Ability				AbilityContext;
			local XComGameState_Ability						AbilityState;
			local XComGameState_Unit						Attacker, Target;
			local XComGameState_Player						PlayerState;
			local bool										bRetainConcealment;
			local array<GameRulesCache_VisibilityInfo>		VisInfos;
			local int										Idx;

			Tuple = XComLWTuple(EventData);
			AbilityContext = XComGameStateContext_Ability(EventSource);
			AbilityState = XComGameState_Ability(GameState.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
			Attacker = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
			Target = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
			PlayerState = XComGameState_Player(`XCOMHISTORY.GetGameStateForObjectID(Attacker.ControllingPlayer.ObjectID));
			bRetainConcealment = Tuple.Data[0].b;

			// Attacker must have the Ghost effect/ability and expect to be revealed
			if (Attacker.IsConcealed() && Attacker.AffectedByEffectNames.Find('WOTC_APA_GhostEffect') != Index_None && !bRetainConcealment)
			{
				// Attack must be a targeted shot (no AOEs) and the Target must be dead or bleeding out
				if (AbilityState.GetMyTemplate().AbilityMultiTargetStyle == none && (Target.IsDead() || Target.bBleedingOut))
				{
					`TACTICALRULES.VisibilityMgr.GetAllViewersOfLocation(Attacker.TileLocation, VisInfos, class'XComGameState_Unit');
					bRetainConcealment = true;

					// Iterate through all units that can see the Attacker's tile to see if any will reveal the Attacker
					for (Idx = 0; Idx < VisInfos.Length; ++Idx)
					{
						if (VisInfos[Idx].bVisibleBasic)
						{
							Target = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(VisInfos[Idx].SourceID));

							// Viewing unit must be an enemy of the Attacker
							if (Target != none && Target.IsEnemyUnit(Attacker) && Target.GetMyTemplateName() != 'FactionAnchorMX')
							{
								// Viewing unit cannot be dead, stunned, unconscious, bleeding out, or in stasis
								if (!Target.IsDead() && !Target.IsStunned() && !Target.bUnconscious && !Target.bBleedingOut && !Target.bInStasis)
								{
									// Viewing unit reveals Attacker
									bRetainConcealment = false;
									break;
					}	}	}	}
			
					if (bRetainConcealment)
					{
						Tuple.Data[0].b = bRetainConcealment;
						EventSource = Tuple;
						class'X2Ability_WOTC_APA_Utilities'.static.BreakSquadConcealment(PlayerState, GameState);
						GameState.GetContext().PostBuildVisualizationFn.AddItem(class'X2Ability_WOTC_APA_Utilities'.static.BasicSourceFlyover_BuildVisualization);
			}	}	}

			return ELR_NoInterrupt;
		}

		// Retain individual concealment when a proxy mine detonates, but break squad concealment (also covers Defensive Mine detonations)
		static function EventListenerReturn ProxyMineRetainConcealmentOnActivation(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComLWTuple								Tuple;
			local XComGameStateContext_Ability				AbilityContext;
			local XComGameState_Ability						AbilityState;
			local XComGameState_Unit						Attacker, Target;
			local XComGameState_Player						PlayerState;
			local bool										bRetainConcealment;
			local array<GameRulesCache_VisibilityInfo>		VisInfos;
			local int										Idx;

			Tuple = XComLWTuple(EventData);
			AbilityContext = XComGameStateContext_Ability(EventSource);
			AbilityState = XComGameState_Ability(GameState.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
			Attacker = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
			Target = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
			PlayerState = XComGameState_Player(`XCOMHISTORY.GetGameStateForObjectID(Attacker.ControllingPlayer.ObjectID));
			bRetainConcealment = Tuple.Data[0].b;

			if (AbilityState.GetMyTemplateName() == class'X2Ability_Grenades'.default.ProximityMineDetonationAbilityName || AbilityState.GetMyTemplateName() == 'ProximityMineM2Detonation')
			{
				Tuple.Data[0].b = true;
				EventSource = Tuple;
				class'X2Ability_WOTC_APA_Utilities'.static.BreakSquadConcealment(PlayerState, GameState);
			}

			return ELR_NoInterrupt;
		}



// 'ModifyEnvironmentDamage' event listeners
static function CHEventListenerTemplate CreateModifyEnvironmentDamageListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_Class_ModifyEnvironmentDamage');

	Template.RegisterInTactical = true;

	Template.AddCHEvent('ModifyEnvironmentDamage', SapperModifyEnvironmentDamage, ELD_Immediate);
	Template.AddCHEvent('ModifyEnvironmentDamage', MiniMunitionsModifyEnvironmentDamage, ELD_Immediate);
	return Template;
}

		// Add bonus environmental damage from Explosive Ordnance
		static function EventListenerReturn SapperModifyEnvironmentDamage(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComLWTuple				OverrideTuple;
			local XComGameState_Unit		UnitState;
			local XComGameState_Ability		AbilityState;
			local XComGameState_Item		SourceAmmo, SourceWeapon;
			local X2GrenadeTemplate			SourceGrenade;
			local X2WeaponTemplate			WeaponTemplate;
			local int						BonusDamage;

			OverrideTuple = XComLWTuple(EventData);
			if (OverrideTuple == none)
				return ELR_NoInterrupt;

			if (OverrideTuple.Id != 'ModifyEnvironmentDamage')
				return ELR_NoInterrupt;

			AbilityState = XComGameState_Ability(OverrideTuple.Data[2].o);
			if (AbilityState == none)
				return ELR_NoInterrupt;

			UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
			if (UnitState.AffectedByEffectNames.Find('WOTC_APA_ExplosiveOrdnanceSapperEffect') == -1)
				return ELR_NoInterrupt;

			SourceAmmo = AbilityState.GetSourceAmmo();
			if (SourceAmmo == none)
			{
				SourceAmmo = AbilityState.GetSourceWeapon();
				if (SourceAmmo == none)
				{
					return ELR_NoInterrupt;
			}	}

			// Explosive source must be a grenade, or a heavy weapon (with Destructive Nature effect), and deal some environmental damage initially
			SourceGrenade = X2GrenadeTemplate(SourceAmmo.GetMyTemplate());
			if (SourceGrenade != none && SourceGrenade.iEnvironmentDamage <= 0)
				return ELR_NoInterrupt;

			if (SourceGrenade == none && UnitState.AffectedByEffectNames.Find('WOTC_APA_DestructiveNatureEffect') != -1)
			{
				SourceWeapon = AbilityState.GetSourceWeapon();
				WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
				if (WeaponTemplate.WeaponCat != 'heavy' || WeaponTemplate.iEnvironmentDamage <= 0)
				{
					return ELR_NoInterrupt;
			}	}

			// Set bonus environmental damage
			BonusDamage = class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_BONUS_ENVIRONMENT_DAMAGE;

			// Set enhanced bonus environmental damage if unit has the enhanced effect (level 3) and SourceGrenade is valid type
			if (UnitState.AffectedByEffectNames.Find('WOTC_APA_ExplosiveOrdnanceEnhancedSapperEffect') == -1)
			{
				if (class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_STANDARD_GRENADE_TYPES.Find(SourceGrenade.DataName) != -1 || WeaponTemplate.WeaponCat == 'heavy')
				{
					BonusDamage += class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_ENVIRONMENT_DAMAGE;
			}	}

			// Add bonus environment damage
			OverrideTuple.Data[0].b = false;
			OverrideTuple.Data[1].i += BonusDamage;

			return ELR_NoInterrupt;
		}


		// Reduce environmental damage from heavy weapons from Miniaturized Munitions
		static function EventListenerReturn MiniMunitionsModifyEnvironmentDamage(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComLWTuple				OverrideTuple;
			local XComGameState_Unit		UnitState;
			local XComGameState_Ability		AbilityState;
			local XComGameState_Item		SourceAmmo, SourceWeapon;
			local X2GrenadeTemplate			SourceGrenade;
			local X2WeaponTemplate			WeaponTemplate;
			local int						NewDamage;

			OverrideTuple = XComLWTuple(EventData);
			if (OverrideTuple == none)
				return ELR_NoInterrupt;

			if (OverrideTuple.Id != 'ModifyEnvironmentDamage')
				return ELR_NoInterrupt;

			AbilityState = XComGameState_Ability(OverrideTuple.Data[2].o);
			if (AbilityState == none)
				return ELR_NoInterrupt;

			UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
			if (UnitState.AffectedByEffectNames.Find('WOTC_APA_MiniMunitionsDamageEffect') == -1)
				return ELR_NoInterrupt;

			SourceAmmo = AbilityState.GetSourceAmmo();
			if (SourceAmmo == none)
			{
				SourceAmmo = AbilityState.GetSourceWeapon();
				if (SourceAmmo == none)
				{
					return ELR_NoInterrupt;
			}	}

			// Explosive source must be a heavy weapon
			SourceWeapon = AbilityState.GetSourceWeapon();
			WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
			if (WeaponTemplate.WeaponCat != 'heavy' || WeaponTemplate.iEnvironmentDamage <= 0)
			{
				return ELR_NoInterrupt;
			}

			// Set environmental damage modifier
			NewDamage = OverrideTuple.Data[1].i * class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.MINIATURIZED_MUNITIONS_DAMAGE_MODIFIER;

			
			// Add bonus environment damage
			OverrideTuple.Data[0].b = false;
			OverrideTuple.Data[1].i = NewDamage;

			return ELR_NoInterrupt;
		}



// 'OnProjectileFireSound' event listeners
static function CHEventListenerTemplate CreateOnProjectileFireSoundListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_Class_OnProjectileFireSound');

	Template.RegisterInStrategy = false;
	Template.RegisterInTactical = true;

	Template.AddCHEvent('OnProjectileFireSound', OnProjectileFireSound, ELD_Immediate);
	return Template;
}

		// Use silence sounds for Blindside shots
		static function EventListenerReturn OnProjectileFireSound(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComLWTuple Tuple;
			local int AbilityContextAbilityRefID;
			local XComGameState_Ability AbilityState;
			local XComGameState_Unit SourceUnit;
			local XComGameState_Item SourceWeapon;
			local name WeaponCategory;
			local SoundCue Sound;
	
			Tuple = XComLWTuple(EventData);
			AbilityContextAbilityRefID = Tuple.Data[2].i;

			AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(AbilityContextAbilityRefID));
			SourceWeapon = AbilityState.GetSourceWeapon();
			WeaponCategory = SourceWeapon.GetWeaponCategory();

			if (AbilityState.GetMyTemplateName() == 'WOTC_APA_BlindsideShot' || AbilityState.GetMyTemplateName() == 'WOTC_APA_MuffledStandardShot' || AbilityState.GetMyTemplateName() == 'WOTC_APA_RemoteStart')
			{
				switch (WeaponCategory)
				{
					case 'vektor_rifle':
					case 'sniper_rifle':
						Sound = FindSound("SilencedSniper_Cue");
						break;	
					case 'rifle':
					case 'bullpup':
						Sound = FindSound("SilencedSmg_Cue");
						break;	
					case 'shotgun':
						Sound = FindSound("SilencedShotgun_Cue");
						break;
					case 'cannon':
						Sound = FindSound("SilencedCannon_Cue");
						break;

					default:
						return ELR_NoInterrupt;
				}

				if (Sound != none)
				{
					Tuple.Data[0].o = Sound;
				}
			}
			
			return ELR_NoInterrupt;
		}

		function static SoundCue FindSound(String SoundCuePath)
		{
			local string strKey;
			local int SoundIdx;
			local XComSoundManager SoundMgr;

			SoundIdx = -1;
			SoundMgr = `SOUNDMGR;
			SoundIdx = SoundMgr.SoundCues.Find('strKey', SoundCuePath);
			if (SoundIdx >= 0)
				return SoundMgr.SoundCues[SoundIdx].Cue;

			return none;
		}



// 'UnitRankUp' event listeners
static function CHEventListenerTemplate CreateUnitRankUpListenerTemplate()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'WOTC_APA_Class_UnitRankUp');

	Template.RegisterInStrategy = true;

	//Template.AddCHEvent('UnitRankUp', NaturalLeaderUnitRankUpListener, ELD_Immediate);
	Template.AddCHEvent('UnitRankUp', NaturalLeaderUnitRankUpListener, ELD_OnStateSubmitted);
	return Template;
}

		// Ensure units created or promoted into the Natural Leader ability have the minimum Combat Intelligence
		static function EventListenerReturn NaturalLeaderUnitRankUpListener(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
		{
			local XComGameState_Unit		UnitState;
			local ECombatIntelligence		CurrentComInt;
			local int						ComIntIncreases, Idx;

			UnitState = XComGameState_Unit(EventData);
			if (UnitState != none)
			{
				///**/`Log("WOTC_APA_Class - Natural Leader: Checking Combat Intelligence for" @ Unitstate.getfullname());
				if (UnitState.HasSoldierAbility('WOTC_APA_NaturalLeader', true))
				{				
					///**/`Log("WOTC_APA_Class - Natural Leader: Checking Combat Intelligence for" @ Unitstate.getfullname() @ "- Has Natural Leader");
					CurrentComInt = UnitState.ComInt;
					if (CurrentComInt < eComInt_Gifted)
					{
						ComIntIncreases = eComInt_Gifted - CurrentComInt;
						///**/`Log("WOTC_APA_Class - Natural Leader:" $ Unitstate.getfullname() @ "'s Combat Intelligence is" @ CurrentComInt);
						///**/`Log("WOTC_APA_Class - Natural Leader: Increasing Combat Intelligence" @ ComIntIncreases @ "times");
						for(Idx = 0; Idx < ComIntIncreases; Idx++)
						{
							///**/`Log("WOTC_APA_Class - Natural Leader: Increasing Combat Intelligence for" @ Unitstate.getfullname());
							UnitState.ImproveCombatIntelligence();
			}	}	}	}

			return ELR_NoInterrupt;
		}