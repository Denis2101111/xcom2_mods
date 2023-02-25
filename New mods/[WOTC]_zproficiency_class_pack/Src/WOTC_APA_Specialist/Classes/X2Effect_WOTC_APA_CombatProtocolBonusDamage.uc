class X2Effect_WOTC_APA_CombatProtocolBonusDamage extends X2Effect_Persistent;

var int Gremlin_Tier;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState) 
{
	local int								BaseDmg;
	local XComGameState_Unit				TargetUnit;
	local XComGameState_HeadquartersXCom	XComHQ;
	local StateObjectReference				ObjectRef;
	local XComGameState_Tech				BreakthroughTech;
	local X2TechTemplate					TechTemplate;
	local XComGameState_Item				SourceItem;
	local X2AbilityTemplateManager			AbilityTemplateMan;
	local X2AbilityTemplate					AbilityTemplate;
	local X2Effect							TargetEffect;
	local X2Effect_BonusWeaponDamage		BonusDamage;

	// Only applies to Combat Protocol
	if (AbilityState.GetMyTemplateName() != 'WOTC_APA_CombatProtocol')
		return 0;

	if (Gremlin_Tier == 2)
		BaseDmg = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T2_BONUS;

	if (Gremlin_Tier > 2)
		BaseDmg =  class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T3_BONUS;

	// Add Non-Robotic bonus Damage from Overload
	if (Attacker.HasSoldierAbility('WOTC_APA_Overload'))
	{
		TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AppliedData.TargetStateObjectRef.ObjectID));
		if (!TargetUnit.IsRobotic())
		{
			BaseDmg += class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.OVERLOAD_NON_MECH_DAMAGE_BONUS;
	}	}

	// Add bonus damage from tech breakthroughs (these are flat bonuses on top of end result - they are not multiplied vs mechanical enemies... too powerful)
	XComHQ = XComGameState_HeadquartersXCom( `XCOMHISTORY.GetSingleGameStateObjectForClass( class'XComGameState_HeadquartersXCom', true ) );
	if (XComHQ != none)
	{
		AbilityTemplateMan = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

		foreach XComHQ.TacticalTechBreakthroughs(ObjectRef)
		{
			BreakthroughTech = XComGameState_Tech(`XCOMHISTORY.GetGameStateForObjectID(ObjectRef.ObjectID));
			TechTemplate = BreakthroughTech.GetMyTemplate();
			SourceItem = XComGameState_Item(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.ItemStateObjectRef.ObjectID));

			if (TechTemplate.BreakthroughCondition != none && TechTemplate.BreakthroughCondition.MeetsCondition(SourceItem))
			{
				AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate( TechTemplate.RewardName );
				foreach AbilityTemplate.AbilityTargetEffects( TargetEffect )
				{
					BonusDamage = X2Effect_BonusWeaponDamage( TargetEffect );
					if (BonusDamage != none)
					{
						BaseDmg += BonusDamage.BonusDmg;
	}	}	}	}	}

	return BaseDmg;
}


defaultproperties
{
	bDisplayInSpecialDamageMessageUI = true
}