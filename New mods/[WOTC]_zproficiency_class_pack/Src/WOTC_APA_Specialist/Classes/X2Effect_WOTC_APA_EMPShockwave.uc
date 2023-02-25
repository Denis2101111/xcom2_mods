
class X2Effect_WOTC_APA_EMPShockwave extends X2Effect;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		TargetUnit;
	local int						TargetShield;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	TargetShield = TargetUnit.GetCurrentStat(eStat_ShieldHP);

	if (TargetShield > 0)
	{
		TargetUnit.SetCurrentStat(eStat_ShieldHP, 0);
		// The shields have been expended, remove the shields
		`XEVENTMGR.TriggerEvent('ShieldsExpended', TargetUnit, TargetUnit, NewGameState);
	}
}