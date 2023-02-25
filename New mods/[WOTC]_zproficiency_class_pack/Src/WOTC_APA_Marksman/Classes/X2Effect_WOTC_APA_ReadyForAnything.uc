
class X2Effect_WOTC_APA_ReadyForAnything extends X2Effect_Persistent implements(XMBEffectInterface) config (WOTC_APA_MarksmanSkills);

var config array<name> READY_FOR_ANYTHING_VALID_ABILITIES;


function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local XComGameState_Ability					AbilityState;
	local XComGameState_Item					WeaponItem;
	local X2WeaponTemplate						WeaponTemplate;
	local UnitValue								UnitValue;
	local XComGameState_Unit					TargetUnit, PrevTargetUnit;

	if (XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID)) == none)
		return false;

	if (SourceUnit.AffectedByEffectNames.Find(class'X2Effect_Suppression'.default.EffectName) != -1)
		return false;

	if (SourceUnit.AffectedByEffectNames.Find(class'X2AbilityTemplateManager'.default.DisorientedName) != -1)
		return false;

	if (SourceUnit.IsPanicked())
		return false;

	if (SourceUnit.IsImpaired(false))
		return false;

	if (SourceUnit.IsDead())
		return false;

	if (SourceUnit.IsIncapacitated())
		return false;

	// Copy of Raptor's Perch conditions to prevent effect applying when a regular action will be granted
	if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_RaptorsPerchEffect') != -1)
	{
		// Source must not have already triggered Raptor's Perch this turn
		SourceUnit.GetUnitValue(class'X2Effect_WOTC_APA_RaptorsPerch'.default.RaptorsPerchActivationsUnitName, UnitValue);	
		if (UnitValue.fValue < class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.RAPTORS_PERCH_ACTIVATIONS)
		{
			// Source must be Braced and have height advantage over a target that was killed
			if (SourceUnit.AffectedByEffectNames.Find('WOTC_APA_Brace_BracedEffect') != -1 || SourceUnit.AffectedByEffectNames.Find('WOTC_APA_Brace_TempBracedEffect') != -1)
			{
				TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
				if (TargetUnit != None)
				{
					PrevTargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(TargetUnit.ObjectID));      //  get the most recent version from the history rather than our modified (attacked) version
					if (TargetUnit.IsDead() && PrevTargetUnit != None && SourceUnit.HasHeightAdvantageOver(PrevTargetUnit, true))
					{
						return false;
	}	}	}	}	}


	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	if (AbilityState != none)
	{
		if (default.READY_FOR_ANYTHING_VALID_ABILITIES.Find(kAbility.GetMyTemplateName()) != Index_None)
		{
			if (SourceUnit.NumActionPoints() == 0)
			{
				// Check Primary weapon first
				WeaponItem = SourceUnit.GetItemInSlot(eInvSlot_PrimaryWeapon);
				WeaponTemplate = X2WeaponTemplate(WeaponItem.GetMyTemplate());
				if (WeaponItem != none && WeaponTemplate != none)
				{
					if (WeaponItem.Ammo > 1 && WeaponTemplate.WeaponCat != 'sniper_rifle')
					{
						SourceUnit.ReserveActionPoints.AddItem(class'X2CharacterTemplateManager'.default.OverwatchReserveActionPoint);
						NewGameState.AddStateObject(SourceUnit);
						`XEVENTMGR.TriggerEvent('WOTC_APA_ReadyForAnythingTriggered', AbilityState, SourceUnit, NewGameState);
						return false;
				}	}

				// Check Secondary weapon next
				WeaponItem = SourceUnit.GetItemInSlot(eInvSlot_SecondaryWeapon);
				WeaponTemplate = X2WeaponTemplate(WeaponItem.GetMyTemplate());
				if (WeaponItem != none && WeaponTemplate != none)
				{
					if (WeaponTemplate.WeaponCat == 'pistol')
					{
						SourceUnit.ReserveActionPoints.AddItem(class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint);
						NewGameState.AddStateObject(SourceUnit);
						`XEVENTMGR.TriggerEvent('WOTC_APA_ReadyForAnythingTriggered', AbilityState, SourceUnit, NewGameState);
						return false;
				}	}

	}	}	}

	return false;
}


// XMB Action Point Interface


function bool GetTagValue(name Tag, XComGameState_Ability AbilityState, out string TagValue);
function bool GetExtModifiers(name Type, XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, optional ShotBreakdown ShotBreakdown, optional out array<ShotModifierInfo> ShotModifiers);

function bool GetExtValue(LWTuple Data)
{
	local XComGameState_Unit SourceUnit;
	local XComGameState_Ability AbilityState;
	//local XComGameState_Effect EffectState;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityCost Cost;
	local name Type;

	if (Data.Id == 'GetActionPointCost')
	{
		SourceUnit = XComGameState_Unit(Data.Data[0].o);
		AbilityState = XComGameState_Ability(Data.Data[1].o);
		//EffectState = XComGameState_Effect(Data.Data[2].o);

		if (AbilityState.GetMyTemplateName() == 'SniperRifleOverwatch')
		{
			foreach AbilityState.GetMyTemplate().AbilityCosts(Cost)
			{
				ActionPointCost = X2AbilityCost_ActionPoints(Cost);
				if (ActionPointCost != none)
				{
					foreach SourceUnit.ActionPoints(Type)
					{
						if (ActionPointCost.AllowedTypes.Find(Type) != -1)
						{
							Data.Data[3].i = 1;
							return true;
	}	}	}	}	}	}

	return false;
}

DefaultProperties
{
	DuplicateResponse=eDupe_Ignore
}