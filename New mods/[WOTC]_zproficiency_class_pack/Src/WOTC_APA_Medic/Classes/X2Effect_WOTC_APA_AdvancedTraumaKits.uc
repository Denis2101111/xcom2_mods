
class X2Effect_WOTC_APA_AdvancedTraumaKits extends X2Effect_Persistent config(WOTC_APA_MedicSkills);


function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local Object EffectObj;
	local XComGameState_Unit EffectTargetUnit;

	EventMgr = `XEVENTMGR;
	EffectObj = EffectGameState;
	EffectTargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	EventMgr.RegisterForEvent(EffectObj, 'OverrideBleedoutChance', OverrideBleedoutChance, ELD_Immediate, , EffectTargetUnit);
	EventMgr.RegisterForEvent(EffectObj, 'UnitBleedingOut', OnUnitBleedingOut, ELD_OnStateSubmitted, , EffectTargetUnit);
}


// Increase chance to enter Bleedout rather than die outright
static function EventListenerReturn OverrideBleedoutChance(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComLWTuple			OverrideTuple;
	local bool					bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	OverrideTuple = XComLWTuple(EventData);
	if(OverrideTuple == none)
		return ELR_NoInterrupt;

	if(OverrideTuple.Id != 'OverrideBleedoutChance')
		return ELR_NoInterrupt;

	/**/`Log("WOTC_APA_Class - Trauma Kit Bleedout Chance Event: Initial bleedout chance roll is" @ OverrideTuple.Data[0].i @ "out of" @ OverrideTuple.Data[1].i, bLog);
	/**/`Log("WOTC_APA_Class - Trauma Kit Bleedout Chance Event: Modified bleedout chance roll is" @ OverrideTuple.Data[0].i += class'X2Ability_WOTC_APA_MedicAbilitySet'.default.TRAUMA_KITS_BLEEDINGOUT_CHANCE_BONUS @ "out of" @ OverrideTuple.Data[1].i, bLog);

	OverrideTuple.Data[0].i += class'X2Ability_WOTC_APA_MedicAbilitySet'.default.TRAUMA_KITS_BLEEDINGOUT_CHANCE_BONUS;

	return ELR_NoInterrupt;
}


// Increase Bleedout turns
static function EventListenerReturn OnUnitBleedingOut(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit UnitState;
	local XComGameState_Effect BleedOutEffect;

	UnitState = XComGameState_Unit(EventData);
	
	BleedOutEffect = UnitState.GetUnitAffectedByEffectState(class'X2StatusEffects'.default.BleedingOutName);
	BleedOutEffect = XComGameState_Effect(GameState.GetGameStateForObjectID(BleedOutEffect.ObjectID));
	if( BleedOutEffect != none )
	{
		BleedOutEffect.iTurnsRemaining += class'X2Ability_WOTC_APA_MedicAbilitySet'.default.TRAUMA_KITS_BLEEDINGOUT_TURNS_BONUS;
	}

	return ELR_NoInterrupt;
}


DefaultProperties
{
	EffectName="WOTC_APA_AdvancedTraumaKits"
	DuplicateResponse=eDupe_Ignore
}