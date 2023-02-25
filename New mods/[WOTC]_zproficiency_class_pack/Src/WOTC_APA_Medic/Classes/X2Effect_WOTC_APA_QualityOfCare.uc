
class X2Effect_WOTC_APA_QualityOfCare extends X2Effect_Persistent config(WOTC_APA_MedicSkills);

//var config array<name>	QUALITY_CARE_VALID_ABILITIES;
//
//
//// Register for the OnHeal Event Trigger
//function RegisterForEvents(XComGameState_Effect EffectGameState)
//{
	//local X2EventManager						EventManager;
	//local Object								EffectObj, TargetObj;
	//local bool									bLog;
//
	//bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
//
	//EventManager = `XEVENTMGR;
	//EffectObj = EffectGameState;
	//TargetObj = `XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);
//
	//EventManager.RegisterForEvent(EffectObj, 'XpHealDamage', QualityOfCareHeal, ELD_OnStateSubmitted, 50,,, EffectObj);
	//`LOG("WOTC_APA_Medic - Event Registered: Quality of Care Event Listener for" @ XComGameState_Unit(TargetObj).GetFullName(), bLog);
//}
//
//
//// This is triggered by a Medikit heal
//static function EventListenerReturn QualityOfCareHeal(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
//{
	//local XComGameState_Unit					TargetUnit, SourceUnit, ExpectedSourceUnit;
	//local XComGameState_Effect					EffectState;
	//local XComGameStateContext_Ability			AbilityContext;
	//local bool									bLog;
//
	//bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
//
	//`LOG("WOTC_APA_Medic - Event Fired: Quality of Care", bLog);
//
	//// Get the Expected SourceUnit
	//EffectState = XComGameState_Effect(CallbackData);
	//ExpectedSourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	//`LOG("WOTC_APA_Medic - Quality of Care: Expected(CallbackData) Source Unit" @ ExpectedSourceUnit.GetFullName(), bLog);
//
	//// Get the Source and Target Units for the Heal Event
	//AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());
	//SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
	//`LOG("WOTC_APA_Medic - Quality of Care: AbilityContext(NewGameState) Source Unit" @ SourceUnit.GetFullName(), bLog);
//
	//TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	//`LOG("WOTC_APA_Medic - Quality of Care: AbilityContext(NewGameState) Target Unit" @ TargetUnit.GetFullName(), bLog);
//
	//// Check that the SourceUnit is the Expected SourceUnit
	//if (ExpectedSourceUnit.ObjectID != SourceUnit.ObjectID)
	//{
		//`LOG("WOTC_APA_Medic - Quality of Care: Heal does not originate from Expected SourceUnit.", bLog);
		//return ELR_NoInterrupt;
	//}
	//`LOG("WOTC_APA_Medic - Quality of Care: Expected SourceUnit found.", bLog);
	//
	//// Modify LowestHP for wound time reduction, if applicable
	//if (TargetUnit.LowestHP < int(TargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.QUALITY_CARE_HP_PERCENT_CAP))
	//{
		//TargetUnit.LowestHP = int(TargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.QUALITY_CARE_HP_PERCENT_CAP);
		//`Log("WOTC_APA_Medic - Quality of Care:" $ TargetUnit.GetFullName() $ "'s LowestHP set to: " $ int(TargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.QUALITY_CARE_HP_PERCENT_CAP), bLog);
		//return ELR_NoInterrupt;
	//}
//
	//// If the target's LowestHP is the minimum of 1 and their HighestHP is too low to be eligible for boosts, give the minimum 1 HP boost
	//if (TargetUnit.LowestHP == 1)
	//{
		//TargetUnit.LowestHP += 1;
		//`Log("WOTC_APA_Medic - Quality of Care:" $ TargetUnit.GetFullName() $ "'s LowestHP set to: 2 (Minimum boost applied - Target's total HP too low to qualify normally)", bLog);
		//return ELR_NoInterrupt;
	//}
//
	//return ELR_NoInterrupt;
//}
//
//
//// Check for valid abilities that do not trigger the XpHealDamage event (primarily for non-healing Stabilize abilities, etc.)
//function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
//{
	//local XComGameStateHistory		History;
	//local XComGameState_Unit		TargetUnit, PrevTargetUnit;
	//local name						AbilityName;
	//local bool						bLog;
//
	//bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;
	//
	//// Check that a valid ability was used
	//if(kAbility == none)
		//return false;
//
	//AbilityName = kAbility.GetMyTemplateName();
//
	//if (default.QUALITY_CARE_VALID_ABILITIES.Find(AbilityName) == -1)
		//return false;
//
	//`LOG("WOTC_APA_Medic - Quality of Care: PostCostAbilityPaid triggered for valid non-healing ability," @ AbilityName, bLog);
//
	//History = `XCOMHISTORY;
	//TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	//PrevTargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(TargetUnit.ObjectID));
//
	/////**/`Log("WOTC_APA_Medic - Quality of Care: Beginning checks for " $ AbilityName $ " applied to " $ PrevTargetUnit.GetFullName());
	/////**/`Log("WOTC_APA_Medic - Quality of Care:" $ PrevTargetUnit.GetFullName() $ "'s current LowestHP/HighestHP: " $ PrevTargetUnit.LowestHP $ "/" $ PrevTargetUnit.HighestHP);
	/////**/`Log("WOTC_APA_Medic - Quality of Care:" $ PrevTargetUnit.GetFullName() $ "'s LowestHP cap for Quality of Care to apply: " $ int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.QUALITY_CARE_HP_PERCENT_CAP));
//
	//// Check that the target's LowestHP value is below the %-cap threshold
	//if (PrevTargetUnit.LowestHP < int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.QUALITY_CARE_HP_PERCENT_CAP))
	//{
		//TargetUnit.LowestHP = int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.QUALITY_CARE_HP_PERCENT_CAP);
		//`Log("WOTC_APA_Medic - Quality of Care:" $ PrevTargetUnit.GetFullName() $ "'s LowestHP set to: " $ int(PrevTargetUnit.HighestHP * class'X2Ability_WOTC_APA_MedicAbilitySet'.default.QUALITY_CARE_HP_PERCENT_CAP), bLog);
		//return false;
	//}
//
	//// If the target's LowestHP is the minimum of 1 and their HighestHP is too low to be eligible for boosts, give the minimum 1 HP boost
	//if (PrevTargetUnit.LowestHP == 1)
	//{
		//TargetUnit.LowestHP += 1;
		//`Log("WOTC_APA_Medic - Quality of Care:" $ PrevTargetUnit.GetFullName() $ "'s LowestHP set to: 2 (Minimum boost applied - Target's total HP too low to qualify normally)", bLog);
		//return false;
	//}
//
	//return false;
//}
//
//
//DefaultProperties
//{
	//EffectName="WOTC_APA_QualityCare"
	//DuplicateResponse=eDupe_Ignore
//}