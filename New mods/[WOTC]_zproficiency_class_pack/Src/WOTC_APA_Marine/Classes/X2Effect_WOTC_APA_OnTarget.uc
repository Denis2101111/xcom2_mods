
class X2Effect_WOTC_APA_OnTarget extends X2Effect_Persistent;


var name				WOTC_APA_OnTarget_TriggeredName;


function bool ChangeHitResultForAttacker(XComGameState_Unit Attacker, XComGameState_Unit TargetUnit, XComGameState_Ability AbilityState, const EAbilityHitResult CurrentResult, out EAbilityHitResult NewHitResult)
{
    local X2AbilityToHitCalc_StandardAim	AttackToHit;
	local int								RandRoll;
	local XComGameState						GameState;

    if (AbilityState.GetSourceWeapon() == Attacker.GetItemInSlot(eInvSlot_PrimaryWeapon))
    {
		//	don't respond to reaction fire
		AttackToHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
		if (AttackToHit != none && AttackToHit.bReactionFire)
			return false;

		if (CurrentResult == eHit_Miss)
		{
			RandRoll = `SYNC_RAND(100);
			if (Randroll <= class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ON_TARGET_TRIGGER_CHANCE)
            {
				NewHitResult = eHit_Graze;
				//`XEVENTMGR.TriggerEvent(default.WOTC_APA_OnTarget_TriggeredName, TargetUnit, Attacker);
				return true;
	}	}	}
	
	return false;
}


defaultproperties
{
	WOTC_APA_OnTarget_TriggeredName = "WOTC_APA_OnTarget_Triggered"
}