
class X2Effect_WOTC_APA_UpgradedScanners extends X2Effect_Persistent;

var int HitMod;
var int CritMod;

function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local X2AbilityToHitCalc_StandardAim	StandardAim;
	local UnitValue							UnitValue;
	local ShotModifierInfo					ShotMod;

	ShotMod.ModType = eHit_Success;
	ShotMod.Value = HitMod;
	ShotMod.Reason = FriendlyName;
	ShotModifiers.AddItem(ShotMod);

	ShotMod.ModType = eHit_Crit;
	ShotMod.Value = CritMod;
	ShotMod.Reason = FriendlyName;
	ShotModifiers.AddItem(ShotMod);
}


DefaultProperties
{
	DuplicateResponse = eDupe_Ignore;
	bApplyOnHit = true;
	bApplyOnMiss = true;
}