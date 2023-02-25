
class X2Effect_WOTC_APA_MedivacSource extends X2Effect_Persistent;


function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local Object EffectObj;

	EffectObj = EffectGameState;

	// Remove the default UnitRemovedFromPlay registered by XComGameState_Effect. This is necessary so we can suppress
	// the usual behavior of the effects being removed when a unit evacs. We need to wait until the mission ends and then
	// process the Medivac ability. The Medic isn't eligible for his own Medivac effects, but his MedivacSource effect and
	// remaining medikit ammo must be preserved to determine total Medivac charges that can be applied once the mission ends.
	`XEVENTMGR.UnRegisterFromEvent(EffectObj, 'UnitRemovedFromPlay');
}


DefaultProperties
{
	EffectName="WOTC_APA_MedivacSource"
}