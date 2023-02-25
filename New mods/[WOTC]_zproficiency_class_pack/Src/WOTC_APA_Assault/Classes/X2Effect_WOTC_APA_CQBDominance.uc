
class X2Effect_WOTC_APA_CQBDominance extends X2Effect_Persistent;

var int BonusAmount;


// Grant increased Defense and Crit Defense against attacks within CQB Dominance range
function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local X2AbilityToHitCalc_StandardAim	StandardAim;
	local UnitValue							UnitValue;
	local ShotModifierInfo					ShotMod;


	if (Target.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_RADIUS_NAME, UnitValue))	
	{
		StandardAim = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
		if (StandardAim != none && Attacker.TileDistanceBetween(Target) <= UnitValue.fValue)
		{
			ShotMod.ModType = eHit_Success;
			ShotMod.Value = -BonusAmount;
			ShotMod.Reason = FriendlyName;
			ShotModifiers.AddItem(ShotMod);

			ShotMod.ModType = eHit_Crit;
			ShotMod.Value = -BonusAmount;
			ShotMod.Reason = FriendlyName;
			ShotModifiers.AddItem(ShotMod);
}	}	}


// Grant increased Crit Chance against targets within CQB Dominance range
function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local X2AbilityToHitCalc_StandardAim	StandardAim;
	local UnitValue							UnitValue;
	local ShotModifierInfo					ShotMod;


	if (Attacker.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_RADIUS_NAME, UnitValue))	
	{
		StandardAim = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
		if (StandardAim != none && Attacker.TileDistanceBetween(Target) <= UnitValue.fValue)
		{
			ShotMod.ModType = eHit_Crit;
			ShotMod.Value = BonusAmount;
			ShotMod.Reason = FriendlyName;
			ShotModifiers.AddItem(ShotMod);
}	}	}


// Convert any grazes within CQB Radius to standard hits
function bool ChangeHitResultForAttacker(XComGameState_Unit Attacker, XComGameState_Unit TargetUnit, XComGameState_Ability AbilityState, const EAbilityHitResult CurrentResult, out EAbilityHitResult NewHitResult)
{
    local X2AbilityToHitCalc_StandardAim	StandardAim;
	local UnitValue							UnitValue;
	local ShotModifierInfo					ShotMod;

	if (Attacker.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_RADIUS_NAME, UnitValue))	
	{
		StandardAim = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
		if (CurrentResult == eHit_Graze && Attacker.TileDistanceBetween(TargetUnit) <= UnitValue.fValue)
		{
			NewHitResult = eHit_Success;
			return true;
	}	}
	
	return false;
}




DefaultProperties
{
	DuplicateResponse = eDupe_Ignore
}