
class X2AbilityTag_WOTC_APA_Class_Pack extends X2AbilityTag;

// Modified and Implemented from Xylith's XModBase

// The previous X2AbilityTag. We save it so we can just call it to handle any tag we don't
// recognize, so we don't have to include a copy of the regular X2AbilityTag code. This also
// makes it so we will play well with any other mods that replace X2AbilityTag this way.
var X2AbilityTag WrappedTag;

var localized string strGenericClassName;
var localized string strOnce;
var localized string strUpTo;
var localized string strTimes;
var localized string strTiles;

var localized string strNaturalLeaderSpecializationDesc;

var localized string strBurstFireName;
var localized string strSteadiedBurstFireName;
var localized string strStrategyBurstFireDesc;
var localized string strTacticalBurstFireDesc;
var localized string strTacticalSteadiedBurstFireDesc;

var localized string strAidProtocolRechargeDesc;
var localized string strBlindProtocolRechargeDesc;
var localized string strCombatProtocolRechargeDesc;

var localized string strAidProtocolRadiusStrategy;
var localized string strAidProtocolRadiusTactical;

var localized string strBlindProtocolRadiusStrategy;
var localized string strBlindProtocolRadiusTactical;

var localized string strCombatProtocolBaseDamageStrategy;
var localized string strCombatProtocolDamageDescStrategy;
var localized string strCombatProtocolDamageDesc;
var localized string strCombatProtocolOverloadDamageDesc;

var localized string strBreaksSquadConcealmentWarning;

var localized string strRemoteRepairBaseHealthStrategy;
var localized string strRemoteRepairHealthStrategyDesc;

var localized string strFailsafeActionFreeDesc;
var localized string strFailsafeActionCostDesc;

var localized string strConcussionGrenadesDisorientAlliesTrue;
var localized string strConcussionGrenadesDisorientAlliesFalse;

var localized string strSlipIntoPositionDesc;

var localized string strFireDisciplineReactionBonusRifle;
var localized string strFireDisciplineReactionBonusCannon;


event ExpandHandler(string InString, out string OutString)
{
	local name						Type;
	local XComGameStateHistory		History;
	local XComGameState_Unit		TargetUnitState, SourceUnitState;
	local XComGameState_Item		ItemState;
	local X2WeaponTemplate			WeaponTemplate;
	local X2SoldierClassTemplate	ClassTemplate;
	local XComGameState_Effect		EffectState;
	local XComGameState_Ability		AbilityState;
	local X2AbilityTemplate			AbilityTemplate;
	local UnitValue					UnitValue;
	local name						nName;
	local string					sStr;
	local float						fVal;
	local int						iVal;

	Type = name(InString);
	History = `XCOMHISTORY;

	switch (Type)
	{	
		
		// -------------
		// Generic Tags:
		// -------------

		case 'RANKNAME1':
		case 'RANKNAME2':
		case 'RANKNAME3':
		case 'RANKNAME4':
		case 'RANKNAME5':
		case 'RANKNAME6':
		case 'RANKNAME7':
		case 'RANKNAME8':
			if (StrategyParseObj != none)
				TargetUnitState = XComGameState_Unit(StrategyParseObj);
			else
				TargetUnitState = XComGameState_Unit(ParseObj);
			
			if (TargetUnitState != none)
				ClassTemplate = TargetUnitState.GetSoldierClassTemplate();
				
			iVal = int(Right(Type, 1));
			if (ClassTemplate != none)
				OutString = class'X2ExperienceConfig'.static.GetRankName(iVal, ClassTemplate.DataName);
			else
				OutString = class'X2ExperienceConfig'.static.GetRankName(iVal, 'nonPsi');
			break;

		case 'DISORIENTED_AIM_ADJUST':
			OutString = string(class'X2StatusEffects'.default.DISORIENTED_AIM_ADJUST);
			break;
		case 'DISORIENTED_MOBILITY_ADJUST':
			OutString = string(class'X2StatusEffects'.default.DISORIENTED_MOBILITY_ADJUST);
			break;
		case 'NATURAL_LEADER_SPECIALIZATION_DESC':
			OutString = "";
			if (class'X2DownloadableContentInfo_WOTC_APA_Class_Pack'.static.IsModLoaded('WOTC_APA_CommandHeadset'))
			{
				OutString = default.strNaturalLeaderSpecializationDesc;				
			}
			break;
		case 'FREE_MEDKIT_BONUS_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_GeneralAbilitySet'.default.FREE_MEDKIT_BONUS_CHARGES);
			break;
		case 'FARSEER_SQUADSIGHT_RANGE_PENALTY_MULTIPLIER':
			fVal = (class'X2Ability_WOTC_APA_GeneralAbilitySet'.default.FARSEER_SQUADSIGHT_RANGE_PENALTY_MULTIPLIER * 100);
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, OutString);
			break;





		// ------------------------------ //
		// Class-Specific Tags - Assault: //
		// ------------------------------ //

		// CQB Dominance Proficiency Level Tags
		case 'CQB_DOMINANCE_I_STAT_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_I_STAT_BONUS);
			break;
		case 'CQB_DOMINANCE_II_STAT_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_I_STAT_BONUS + class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_II_STAT_BONUS);
			break;
		case 'CQB_DOMINANCE_III_STAT_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_I_STAT_BONUS + class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_II_STAT_BONUS + class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_III_STAT_BONUS);
			break;
		case 'CQB_DOMINANCE_I_RADIUS':
			fVal = (class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_I_BASE_RADIUS);
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, OutString);
			break;
		case 'CQB_DOMINANCE_II_RADIUS':
			fVal = (class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_I_BASE_RADIUS + class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_II_BONUS_RADIUS);
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, OutString);
			break;
		case 'CQB_DOMINANCE_III_RADIUS':
			fVal = (class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_I_BASE_RADIUS + class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_II_BONUS_RADIUS + class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_II_BONUS_RADIUS);
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, OutString);
			break;
		case 'CQB_DOMINANCE_BULLPUP_BONUS_RADIUS':
			fVal = (class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_BULLPUP_BONUS_RADIUS);
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, OutString);
			break;

		case 'CQB_DOMINANCE_RADIUS':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
				
				if (SourceUnitState.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CQB_DOMINANCE_RADIUS_NAME, UnitValue))
				{
					class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(UnitValue.fValue, sStr);
					OutString = " (<font color='#3ABD23'>" $ sStr $ "</font>" @ default.strTiles $ ")";
				}
			}
			break;

		// Class Ability Tags
		case 'RUN_AND_GUN_BASE_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUN_AND_GUN_BASE_COOLDOWN - 1);
			break;
		case 'RUN_AND_GUN_LIGHT_WEAPON_COOLDOWN_REDUCTION':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUN_AND_GUN_LIGHT_WEAPON_COOLDOWN_REDUCTION);
			break;
		case 'RUN_AND_GUN_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUN_AND_GUN_BASE_COOLDOWN - 1);
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				
				if (SourceUnitState.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUN_AND_GUN_COOLDOWN_NAME, UnitValue))	
					class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(UnitValue.fValue - 1, OutString);
			}
			break;
		case 'PREP_FOR_ENTRY_RANGE_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((1 - class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.PREP_FOR_ENTRY_RANGE_MULTIPLIER) * 100, OutString);
			break;
		case 'PREP_FOR_ENTRY_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.PREP_FOR_ENTRY_COOLDOWN - 1);
			break;
		case 'ZONE_CONTROL_AIM_PENALTY':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.ZONE_CONTROL_AIM_PENALTY);
			break;
		case 'ZONE_CONTROL_MOBILITY_PENALTY':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.ZONE_CONTROL_MOBILITY_PENALTY);
			break;
		case 'ZONE_CONTROL_CQB_BONUS_RADIUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.ZONE_CONTROL_CQB_BONUS_RADIUS);
			break;
		case 'HONED_EDGE_BONUS_AIM':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.HONED_EDGE_BONUS_AIM);
			break;
		case 'HONED_EDGE_BONUS_CRIT':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.HONED_EDGE_BONUS_CRIT);
			break;
		case 'LARGE_PARTIAL_MOVE_MOBILITY_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.LARGE_PARTIAL_MOVE_MOBILITY_MULTIPLIER * 100, OutString);
			break;
		case 'SMALL_PARTIAL_MOVE_MOBILITY_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SMALL_PARTIAL_MOVE_MOBILITY_MULTIPLIER * 100, OutString);
			break;
		case 'DEEP_RESERVES_COOLDOWN_MODIFIER':
			OutString = string(-class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.DEEP_RESERVES_COOLDOWN_MODIFIER);
			break;
		case 'DEEP_RESERVES_MOBILITY_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.DEEP_RESERVES_MOBILITY_BONUS);
			break;
		case 'LIGHTNING_REFLEXES_REACTION_FIRE_DEFENSE':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.LIGHTNING_REFLEXES_REACTION_FIRE_DEFENSE);
			break;
		case 'BATTERING_RAM_ARMOR_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.BATTERING_RAM_ARMOR_BONUS);
			break;
		case 'BATTERING_RAM_CONDITIONAL_ARMOR_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.BATTERING_RAM_CONDITIONAL_ARMOR_BONUS);
			break;
		case 'SHOCK_AND_MAUL_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SHOCK_AND_MAUL_DAMAGE_BONUS);
			break;
		case 'SHOCK_AND_MAUL_CONDITIONAL_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SHOCK_AND_MAUL_CONDITIONAL_DAMAGE_BONUS);
			break;
		case 'KILLER_INSTINCT_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.KILLER_INSTINCT_DAMAGE_BONUS);
			break;
		case 'KILLER_INSTINCT_CRITICAL_DAMAGE_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.KILLER_INSTINCT_CRITICAL_DAMAGE_MULTIPLIER - 1) * 100, OutString);
			break;
		case 'RUTHLESS_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUTHLESS_DAMAGE_BONUS);
			break;
		case 'RUTHLESS_CRIT_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.RUTHLESS_CRIT_CHANCE);
			break;
		case 'CONCUSSION_GRENADES_CHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CONCUSSION_GRENADES_CHARGE_BONUS);
			break;
		case 'CONCUSSION_GRENADES_DISORIENT_ALLIES':
			if (class'WOTC_APA_Class_Pack_ModifyTemplates'.default.CONCUSSION_GRENADES_DISORIENT_ALLIES)
				OutString = default.strConcussionGrenadesDisorientAlliesTrue;
			else
				OutString = default.strConcussionGrenadesDisorientAlliesFalse;
			break;
		case 'NON_MOVE_ACTION_ACTIVATION_LIMIT':
			OutString = default.strOnce;
			iVal = class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.NON_MOVE_ACTION_ACTIVATION_LIMIT;
			if (iVal > 1)
			{
				OutString = default.strUpTo @ "<font color='#3ABD23'>" $ string(iVal) $ "</font>" @ default.strTimes;
			}
			break;
		case 'SLIP_INTO_POSITION_DETECTION_RANGE_BONUS':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
				
				if (SourceUnitState.GetUnitValue(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SLIP_INTO_POSITION_BONUS_NAME, UnitValue))
				{
					class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(UnitValue.fValue * 100, sStr);
					Outstring = default.strSlipIntoPositionDesc @ "<font color='#3ABD23'>" $ sStr $ "%</font>.";
				}
			}
			break;
		case 'SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_1':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_1) * 100, OutString);
			break;
		case 'SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_2':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.SLIP_INTO_POSITION_DETECTION_RANGE_BONUS_2) * 100, OutString);
			break;
		case 'EVASIVE_DODGE_BONUS_PER_TILE':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.EVASIVE_DODGE_BONUS_PER_TILE);
			break;
		case 'EVASIVE_DODGE_BONUS_CAP':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.EVASIVE_DODGE_BONUS_PER_TILE * class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.EVASIVE_DODGE_BONUS_TILE_CAP, OutString);
			break;
		case 'HIT_RUN_ACTIVATIONS_PER_TURN':
			OutString = default.strOnce;
			iVal = class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.HIT_RUN_ACTIVATIONS_PER_TURN;
			if (iVal > 1)
			{
				OutString = default.strUpTo @ "<font color='#3ABD23'>" $ string(iVal) $ "</font>" @ default.strTimes;
			}
			break;
		case 'CLOSE_COMBAT_SPECIALIST_TILE_RADIUS':
			OutString = string(class'X2Ability_WOTC_APA_AssaultAbilitySet'.default.CLOSE_COMBAT_SPECIALIST_TILE_RADIUS);
			break;




		// ---------------------------- //
		// Class-Specific Tags - Medic: //
		// ---------------------------- //

		// Medical Specialist Proficiency Level Tags - Individual
		case 'MED_I_FREE_MEDKITS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_I_FREE_MEDKITS);
			break;
		case 'MED_I_EQUIPPED_MEDKITS_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_I_EQUIPPED_MEDKITS_BONUS);
			break;		
		case 'MED_II_MEDKIT_HEAL_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_II_MEDKIT_HEAL_BONUS);
			break;
		case 'MED_II_REVIVE_CHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_II_REVIVE_CHARGE_BONUS);
			break;
		case 'MED_III_FREE_MEDKITS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_III_FREE_MEDKITS);
			break;
		case 'MED_III_MEDKIT_HEAL_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_III_MEDKIT_HEAL_BONUS);
			break;

		// Medical Specialist Proficiency Level Tags - Totals
		case 'MED_III_FREE_MEDKITS_TOTAL':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_I_FREE_MEDKITS + class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_III_FREE_MEDKITS);
			break;
		case 'MED_III_MEDKIT_HEAL_BONUS_TOTAL':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_II_MEDKIT_HEAL_BONUS + class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MED_III_MEDKIT_HEAL_BONUS);
			break;

		// Class Ability Tags
		case 'BATTLEFIELD_TRIAGE_HP_PERCENT_CAP':
			iVal = (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BATTLEFIELD_TRIAGE_HP_PERCENT_CAP * 100);
			OutString = string(iVal);
			break;
		case 'ADRENALINE_RUSH_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ADRENALINE_RUSH_COOLDOWN - 1);
			break;
		case 'ADRENALINE_RUSH_DAMAGE_PENALTY':
			iVal = (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ADRENALINE_RUSH_DAMAGE_PENALTY * 100);
			OutString = string(iVal);
			break;
		case 'REPOSITION_MOBILITY_PENALTY':
			iVal = ((1 - class'X2Ability_WOTC_APA_MedicAbilitySet'.default.REPOSITION_MOBILITY_PENALTY) * 100);
			OutString = string(iVal);
			break;
		case 'FLEET_FOOTED_DODGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.FLEET_FOOTED_DODGE_BONUS);
			break;
		case 'TRAUMA_KITS_REVIVE_HEAL_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.TRAUMA_KITS_REVIVE_HEAL_BONUS);
			break;
		case 'TRAUMA_KITS_REVIVE_CHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.TRAUMA_KITS_REVIVE_CHARGE_BONUS);
			break;
		case 'TRAUMA_KITS_BLEEDINGOUT_CHANCE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.TRAUMA_KITS_BLEEDINGOUT_CHANCE_BONUS);
			break;
		case 'TRAUMA_KITS_BLEEDINGOUT_TURNS_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.TRAUMA_KITS_BLEEDINGOUT_TURNS_BONUS);
			break;
		case 'COMBAT_CONDITIONING_MOBILITY_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_CONDITIONING_MOBILITY_BONUS);
			break;
		case 'COMBAT_CONDITIONING_AIM_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_CONDITIONING_AIM_BONUS);
			break;
		case 'EMERGENCY_AID_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.EMERGENCY_AID_COOLDOWN - 1);
			break;
		case 'SENTINEL_USES_PER_TURN':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.SENTINEL_USES_PER_TURN);
			break;
		case 'BURST_FIRE_AMMO_COST':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BURST_FIRE_AMMO_COST);
			break;
		case 'BURST_FIRE_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BURST_FIRE_COOLDOWN - 1);
			break;
		case 'BURST_FIRE_AIM_PENALTY':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.BURST_FIRE_AIM_PENALTY);
			break;
		case 'BURST_FIRE_NAME':
			OutString = default.strBurstFireName;
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					TargetUnitState = XComGameState_Unit(History.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					TargetUnitState = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));	

				if (TargetUnitState != none)
				{
					iVal = 2;
					
					if (TargetUnitState.ActionPoints.Find('FleetFootedEmergencyAid') != -1)
						iVal += 1;

					if (TargetUnitState.ActionPoints.Find('FleetFootedRapidDeployment') != -1)
						iVal += 1;

					if (TargetUnitState.ActionPoints.length >= iVal)
						OutString = default.strSteadiedBurstFireName;
				}
			}
			break;
		case 'BURST_FIRE_DESCRIPTION':
			OutString = default.strStrategyBurstFireDesc;
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					TargetUnitState = XComGameState_Unit(History.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					TargetUnitState = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));	

				if (TargetUnitState != none)
				{
					iVal = 2;
					
					if (TargetUnitState.ActionPoints.Find('FleetFootedEmergencyAid') != -1)
						iVal += 1;

					if (TargetUnitState.ActionPoints.Find('FleetFootedRapidDeployment') != -1)
						iVal += 1;

					if (TargetUnitState.ActionPoints.length >= iVal)
						OutString = default.strTacticalSteadiedBurstFireDesc;
					else
						OutString = default.strTacticalBurstFireDesc;
				}
			}
			Outstring = `XEXPAND.ExpandString(Outstring);
			break;
		case 'ANTIVENOM_STIMS_DISTANCE':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ANTIVENOM_STIMS_DISTANCE, OutString);
			break;
		case 'ANTIVENOM_STIMS_ADRENALINE_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ANTIVENOM_STIMS_ADRENALINE_COOLDOWN - 1);
			break;
		case 'SMOKESCREEN_FREE_SMOKE_GRENADES':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.SMOKESCREEN_FREE_SMOKE_GRENADES);
			break;
		case 'SMOKESCREEN_EQUIPPED_SMOKE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.SMOKESCREEN_EQUIPPED_SMOKE_BONUS);
			break;
		case 'INFILTRATION_DETECTION_RANGE_BONUS':
			iVal = (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.INFILTRATION_DETECTION_RANGE_BONUS * 100);
			OutString = string(iVal);
			break;
		case 'FIRE_SUPPORT_AIM_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.FIRE_SUPPORT_AIM_BONUS);
			break;
		case 'RAPID_DEPLOYMENT_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.RAPID_DEPLOYMENT_COOLDOWN - 1);
			break;
		case 'COMBAT_STIMULANTS_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_CHARGES);
			break;
		case 'COMBAT_STIMULANTS_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_COOLDOWN - 1);
			break;
		case 'COMBAT_STIMULANTS_ACTION_POINT_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_ACTION_POINT_BONUS);
			break;
		case 'COMBAT_STIMULANTS_DAMAGE_RESISTANCE':
			iVal = (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_DAMAGE_RESISTANCE * 100);
			OutString = string(iVal);
			break;
		case 'COMBAT_STIMULANTS_TURN_DURATION':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_TURN_DURATION);
			break;
		case 'COMBAT_STIMULANTS_WILL_PENALTY':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_WILL_PENALTY);
			break;
		case 'COMBAT_STIMULANTS_HEALTH_PENALTY':
			iVal = (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_HEALTH_PENALTY * 100);
			OutString = string(iVal);
			break;
		case 'COMBAT_STIMULANTS_STATS_BONUS':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.COMBAT_STIMULANTS_STATS_BONUS, OutString);
			break;
		case 'APPLIED_KNOWLEDGE_CRIT_CHANCE_BONUS':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.APPLIED_KNOWLEDGE_CRIT_CHANCE_BONUS, OutString);
			break;
		case 'APPLIED_KNOWLEDGE_CRIT_DAMAGE_BONUS':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.APPLIED_KNOWLEDGE_CRIT_DAMAGE_BONUS, OutString);
			break;
		case 'ARMED_INTERVENTION_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ARMED_INTERVENTION_COOLDOWN - 1);
			break;


			
		
		case 'SIDEARM_SPECIALIST_AIM_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.SIDEARM_SPECIALIST_AIM_BONUS);
			break;
		case 'SIDEARM_SPECIALIST_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.SIDEARM_SPECIALIST_DAMAGE_BONUS);
			break;
		case 'MEDIVAC_BONUS_HEAL_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.MEDIVAC_BONUS_HEAL_CHARGES);
			break;
		case 'CERTIFIED_CMT_MEDIKIT_CHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.CERTIFIED_CMT_MEDIKIT_CHARGE_BONUS);
			break;
		case 'CERTIFIED_CMT_MEDIKIT_HEAL_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.CERTIFIED_CMT_MEDIKIT_HEAL_BONUS);
			break;
		case 'STUN_SHOT_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MedicAbilitySet'.default.STUN_SHOT_COOLDOWN - 1);
			break;
		case 'STUN_SHOT_AIM_PENALTY':
			fVal = (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.STUN_SHOT_AIM_PENALTY * 100);
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, OutString);
			break;




		// ----------------------------- //
		// Class-Specific Tags - Marine: //
		// ----------------------------- //

		case 'FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_1':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_1);
			break;
		case 'FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_2':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_2);
			break;
		case 'FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_3':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_FIRE_AIM_BONUS_3);
			break;
		case 'FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_1':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_1);
			break;
		case 'FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_2':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_2);
			break;
		case 'FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_3':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_3);
			break;
		case 'FIRE_DISCIPLINE_CURRENT_REACTION_CHANCE_LIMIT':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				
				if (SourceUnitState.GetUnitValue(class'X2Condition_WOTC_APA_Class_RequiredChanceToHit'.default.MinHitChanceValueName, UnitValue))	
					class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(UnitValue.fValue, OutString);
				else
					OutString = "0";
			}
			break;
			
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_REACTION_CHANCE_LIMIT_3);
			break;
		case 'FIRE_DISCIPLINE_REACTION_FIRE_BONUS_TYPE':
			OutString = default.strFireDisciplineReactionBonusRifle;
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
				
				if (SourceUnitState != none)
				{
					ItemState = SourceUnitState.GetItemInSlot(eInvSlot_PrimaryWeapon);
					if (ItemState != none)
					{
						WeaponTemplate = X2WeaponTemplate(ItemState.GetMyTemplate());
						if (WeaponTemplate != none)
						{
							if (WeaponTemplate.WeaponCat == 'cannon')
							{
								OutString = default.strFireDisciplineReactionBonusCannon;
				}	}	}	}
			}
			break;
		case 'FIRE_DISCIPLINE_AMMO_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FIRE_DISCIPLINE_AMMO_BONUS);
			break;
		case 'SUPPRESSION_AMMO_COST':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.SUPPRESSION_AMMO_COST);
			break;
		case 'ZONE_SUPPRESSION_AMMO_COST':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZONE_SUPPRESSION_AMMO_COST);
			break;
		case 'ZONE_SUPPRESSION_RIFLE_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZONE_SUPPRESSION_RIFLE_COOLDOWN - 1);
			break;
		case 'ZONE_SUPPRESSION_CANNON_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZONE_SUPPRESSION_CANNON_COOLDOWN - 1);
			break;
		case 'ZONE_SUPPRESSION_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZONE_SUPPRESSION_RIFLE_COOLDOWN - 1);
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
				
				if (SourceUnitState != none)
				{
					ItemState = SourceUnitState.GetItemInSlot(eInvSlot_PrimaryWeapon);
					if (ItemState != none)
					{
						WeaponTemplate = X2WeaponTemplate(ItemState.GetMyTemplate());
						if (WeaponTemplate != none)
						{
							if (WeaponTemplate.WeaponCat == 'cannon')
							{
								OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZONE_SUPPRESSION_CANNON_COOLDOWN - 1);
				}	}	}	}
			}
			break;
		case 'ZONE_SUPPRESSION_CONE_WIDTH':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZONE_SUPPRESSION_CONE_WIDTH);
			break;
		case 'ZONE_SUPPRESSION_CONE_WIDTH_CANNON_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZONE_SUPPRESSION_CONE_WIDTH_CANNON_BONUS);
			break;
		case 'LOCKEDON_AIM_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.LOCKEDON_AIM_BONUS);
			break;
		case 'LOCKEDON_CRIT_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.LOCKEDON_CRIT_BONUS);
			break;
		case 'FLUSH_SHOT_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FLUSH_SHOT_COOLDOWN - 1);
			break;
		case 'FLUSH_SHOT_AMMO_COST':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FLUSH_SHOT_AMMO_COST);
			break;
		case 'FLUSH_SHOT_AIM_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FLUSH_SHOT_AIM_BONUS);
			break;
		case 'FLUSH_SHOT_DAMAGE_MODIFIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((1 - class'X2Ability_WOTC_APA_MarineAbilitySet'.default.FLUSH_SHOT_DAMAGE_MODIFIER) * 100, OutString);
			break;
		case 'DANGER_ZONE_WIDTH_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.DANGER_ZONE_WIDTH_BONUS);
			break;
		case 'DANGER_ZONE_WIDTH_CANNON_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.DANGER_ZONE_WIDTH_CANNON_BONUS);
			break;
		case 'PIN_DOWN_MOBILITY_PENALTY':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((1 - class'X2Ability_WOTC_APA_MarineAbilitySet'.default.PIN_DOWN_MOBILITY_PENALTY) * 100, OutString);
			break;
		case 'SPLINTER_ARMOR_SHRED':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.SPLINTER_ARMOR_SHRED);
			break;
		case 'EMPLACED_AIM_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.EMPLACED_AIM_BONUS);
			break;
		case 'EMPLACED_VISION_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.EMPLACED_VISION_BONUS);
			break;
		case 'COMBAT_AWARENESS_DEFENSE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.COMBAT_AWARENESS_DEFENSE_BONUS);
			break;
		case 'COMBAT_AWARENESS_ARMOR_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.COMBAT_AWARENESS_ARMOR_BONUS);
			break;
		case 'BRINGEM_ON_CRIT_CHANCE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.BRINGEM_ON_CRIT_CHANCE_BONUS);
			break;
		case 'BRINGEM_ON_CRIT_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.BRINGEM_ON_CRIT_DAMAGE_BONUS);
			break;
		case 'ON_TARGET_DODGE_REDUCTION':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ON_TARGET_DODGE_REDUCTION);
			break;
		case 'ON_TARGET_TRIGGER_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ON_TARGET_TRIGGER_CHANCE);
			break;
		case 'WEAPONS_HOT_TRIGGER_CHANCE_RIFLE':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.WEAPONS_HOT_TRIGGER_CHANCE_RIFLE);
			break;
		case 'WEAPONS_HOT_TRIGGER_CHANCE_CANNON':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.WEAPONS_HOT_TRIGGER_CHANCE_CANNON);
			break;
		case 'WITHERING_BARRAGE_TRIGGER_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.WITHERING_BARRAGE_TRIGGER_CHANCE);
			break;
		case 'TACTICAL_SENSE_DEFENSE_PER_ENEMY':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.TACTICAL_SENSE_DEFENSE_PER_ENEMY);
			break;
		case 'TACTICAL_SENSE_DEFENSE_CAP':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.TACTICAL_SENSE_DEFENSE_CAP);
			break;
		case 'AGGRESSION_CRIT_CHANCE_PER_ENEMY':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.AGGRESSION_CRIT_CHANCE_PER_ENEMY);
			break;
		case 'AGGRESSION_CRIT_CHANCE_CAP':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.AGGRESSION_CRIT_CHANCE_CAP);
			break;
		case 'ZEROED_IN_CHANCE_PER_ENEMY':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZEROED_IN_CHANCE_PER_ENEMY);
			break;
		case 'ZEROED_IN_CHANCE_CAP':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.ZEROED_IN_CHANCE_CAP);
			break;
		case 'IMPRESSIVE_STRENGTH_HP_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarineAbilitySet'.default.IMPRESSIVE_STRENGTH_HP_BONUS);
			break;
		case 'IMPRESSIVE_STRENGTH_THROW_RANGE_MODIFIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((class'X2Ability_WOTC_APA_MarineAbilitySet'.default.IMPRESSIVE_STRENGTH_THROW_RANGE_MODIFIER - 1) * 100, OutString);
			break;
		


		// ------------------------------- //
		// Class-Specific Tags - Marksman: //
		// ------------------------------- //

		// Precision Targeting Proficiency Level Tags
		case 'PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_1':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_1 * 100, OutString);
			break;
		case 'PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_2':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_2 * 100, OutString);
			break;
		case 'PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_3':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_TARGETING_SQUADSIGHT_PENALTY_NEGATED_3 * 100, OutString);
			break;
		case 'PRECISION_TARGETING_COVER_CRIT_BONUS_1':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_TARGETING_COVER_CRIT_BONUS_1);
			break;
		case 'PRECISION_TARGETING_COVER_CRIT_BONUS_2':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_TARGETING_COVER_CRIT_BONUS_2);
			break;
		case 'PRECISION_TARGETING_COVER_CRIT_BONUS_3':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_TARGETING_COVER_CRIT_BONUS_3);
			break;
		case 'PRECISION_TARGETING_ENEMY_DODGE_NEGATED_1':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_TARGETING_ENEMY_DODGE_NEGATED_1);
			break;
		case 'PRECISION_TARGETING_ENEMY_DODGE_NEGATED_2':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_TARGETING_ENEMY_DODGE_NEGATED_2);
			break;
		case 'PRECISION_TARGETING_ENEMY_DODGE_NEGATED_3':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_TARGETING_ENEMY_DODGE_NEGATED_3);
			break;

		// Class Ability Tags
		case 'BRACED_AIM_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.BRACED_AIM_BONUS);
			break;
		case 'BRACED_RANGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.BRACED_RANGE_BONUS);
			break;
		case 'STALKER_CRIT_CHANCE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.STALKER_CRIT_CHANCE_BONUS);
			break;
		case 'STALK_MOBILITY_MODIFIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((1 - class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.STALK_MOBILITY_MODIFIER) * 100, OutString);
			break;
		case 'STALK_DETECTION_MODIFIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((1 - class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.STALK_DETECTION_MODIFIER) * 100, OutString);
			break;
		case 'WEAPON_HANDLING_VEKTOR_CRIT_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.WEAPON_HANDLING_VEKTOR_CRIT_BONUS);
			break;
		case 'LEAD_TARGET_AIM_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.LEAD_TARGET_AIM_BONUS);
			break;
		case 'LEAD_TARGET_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.LEAD_TARGET_COOLDOWN - 1);
			break;
		case 'MUFFLED_SHOT_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.MUFFLED_SHOT_COOLDOWN - 1);
			break;
		case 'MUFFLED_SHOT_DAMAGE_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.MUFFLED_SHOT_DAMAGE_MULTIPLIER * 100, OutString);
			break;
		case 'MUFFLED_SHOT_CRIT_DAMAGE_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.MUFFLED_SHOT_CRIT_DAMAGE_MULTIPLIER * 100, OutString);
			break;
		case 'BLINDSIDE_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.BLINDSIDE_COOLDOWN - 1);
			break;
		case 'BLINDSIDE_DAMAGE_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.BLINDSIDE_DAMAGE_MULTIPLIER * 100, OutString);
			break;
		case 'BLINDSIDE_CRIT_DAMAGE_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.BLINDSIDE_CRIT_DAMAGE_MULTIPLIER * 100, OutString);
			break;
		case 'HIGH_APPROACH_ANGLE_COVER_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.HIGH_APPROACH_ANGLE_COVER_MULTIPLIER * 100, OutString);
			break;
		case 'QUICK_BRACE_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.QUICK_BRACE_COOLDOWN - 1);
			break;
		case 'RAPTORS_PERCH_ACTIVATIONS':
			OutString = default.strOnce;
			iVal = class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.RAPTORS_PERCH_ACTIVATIONS;
			if (iVal > 1)
			{
				OutString = default.strUpTo @ "<font color='#3ABD23'>" $ string(iVal) $ "</font>" @ default.strTimes;
			}
			break;
		case 'OPPORTUNIST_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.OPPORTUNIST_DAMAGE_BONUS);
			break;
		case 'WEAPON_SPECIALIST_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.WEAPON_SPECIALIST_DAMAGE_BONUS);
			break;
		case 'GHOST_MOBILITY_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.GHOST_MOBILITY_BONUS);
			break;
		case 'PRECISION_SHOT_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_SHOT_MULTIPLIER - 1) * 100, OutString);
			break;
		case 'PRECISION_SHOT_AIM_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((1 - class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_SHOT_AIM_MULTIPLIER) * 100, OutString);
			break;
		case 'PRECISION_SHOT_STUN_DURATION':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_SHOT_STUN_DURATION);
			break;
		case 'PRECISION_SHOT_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.PRECISION_SHOT_COOLDOWN - 1);
			break;
		case 'HARRIERS_TALON_ARMOR_PIERCE':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.HARRIERS_TALON_ARMOR_PIERCE);
			break;
		case 'APEX_PREDATOR_CRIT_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.APEX_PREDATOR_CRIT_DAMAGE_BONUS);
			break;
		case 'APEX_PREDATOR_PANIC_RADIUS':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.APEX_PREDATOR_PANIC_RADIUS, OutString);
			break;
		case 'APEX_PREDATOR_DISORIENT_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.APEX_PREDATOR_DISORIENT_CHANCE);
			break;
		case 'APEX_PREDATOR_PANIC_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.APEX_PREDATOR_PANIC_CHANCE);
			break;
		case 'APEX_PREDATOR_WEAPON_MODIFIER':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.APEX_PREDATOR_WEAPON_MODIFIER);
			break;
		case 'RECON_DETECTION_MODIFIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((1 - class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.RECON_DETECTION_MODIFIER) * 100, OutString);
			break;
		case 'RECON_VISION_RANGE_MODIFIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.RECON_VISION_RANGE_MODIFIER, OutString);
			break;
			break;
		case 'HIGH_CALIBER_ARMOR_PIERCE':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.HIGH_CALIBER_ARMOR_PIERCE);
			break;
		case 'HIGH_CALIBER_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.HIGH_CALIBER_DAMAGE_BONUS);
			break;
		case 'HIGH_CALIBER_AMMO_MODIFIER':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.HIGH_CALIBER_AMMO_MODIFIER);
			break;
		case 'CONCEALING_SMOKE_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.CONCEALING_SMOKE_CHARGES);
			break;
		case 'CONCEALING_SMOKE_RADIUS':
			fVal = (class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.CONCEALING_SMOKE_RADIUS);
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, OutString);
			break;
		case 'SIXTH_SENSE_DODGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.SIXTH_SENSE_DODGE_BONUS);
			break;
		case 'SIXTH_SENSE_TILE_RADIUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.SIXTH_SENSE_TILE_RADIUS);
			break;
		case 'STEADY_HANDS_CRIT_CHANCE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.STEADY_HANDS_CRIT_CHANCE_BONUS);
			break;
		case 'STEADY_HANDS_CRIT_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.STEADY_HANDS_CRIT_DAMAGE_BONUS);
			break;
		case 'HAWKEYE_RANGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.HAWKEYE_RANGE_BONUS);
			break;
		case 'DEATH_FROM_ABOVE_ACTIVATIONS':
			OutString = default.strOnce;
			iVal = class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.DEATH_FROM_ABOVE_ACTIVATIONS;
			if (iVal > 1)
			{
				OutString = default.strUpTo @ "<font color='#3ABD23'>" $ string(iVal) $ "</font>" @ default.strTimes;
			}
			break;






		// ----------------------------- //
		// Class-Specific Tags - Sapper: //
		// ----------------------------- //
		
		// Explosive Ordnance Proficiency Level Tags

		case 'EXPLOSIVE_ORDNANCE_BONUS_ENVIRONMENT_DAMAGE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_BONUS_ENVIRONMENT_DAMAGE);
			break;
		case 'EXPLOSIVE_ORDNANCE_EXPLOSIVE_CRIT_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_EXPLOSIVE_CRIT_CHANCE);
			break;
		case 'EXPLOSIVE_ORDNANCE_EXPLOSIVE_CRIT_DAMAGE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_EXPLOSIVE_CRIT_DAMAGE);
			break;
		case 'EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_2':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_2);
			break;
		case 'EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_3':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_3);
			break;
		case 'EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_3_TOTAL':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_2 + class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_BONUS_GRENADE_POCKET_CHARGE_3);
			break;
		case 'EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_ENVIRONMENT_DAMAGE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_ENVIRONMENT_DAMAGE);
			break;
		case 'EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_BASE_DAMAGE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_BASE_DAMAGE);
			break;
		case 'EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_CRIT_DAMAGE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ORDNANCE_STANDARD_EXPLOSIVE_CRIT_DAMAGE);
			break;


		// Class Ability Tags

		case 'DEFENSIVE_MINE_DAMAGE_RANGE':
			iVal = class'X2Item_WOTC_APA_DefensiveMine'.default.DEFENSIVE_MINE_BASEDAMAGE.DAMAGE - class'X2Item_WOTC_APA_DefensiveMine'.default.DEFENSIVE_MINE_BASEDAMAGE.SPREAD;
			sStr = string(iVal) $ "-";
			iVal = class'X2Item_WOTC_APA_DefensiveMine'.default.DEFENSIVE_MINE_BASEDAMAGE.DAMAGE + class'X2Item_WOTC_APA_DefensiveMine'.default.DEFENSIVE_MINE_BASEDAMAGE.SPREAD;
			if (class'X2Item_WOTC_APA_DefensiveMine'.default.DEFENSIVE_MINE_BASEDAMAGE.PLUSONE > 0)
			{	
				iVal += 1;
			}
			OutString = sStr $ string(iVal);
			break;
		case 'DEFENSIVE_MINE_RADIUS':
			OutString = string(class'X2Item_WOTC_APA_DefensiveMine'.default.DEFENSIVE_MINE_RADIUS);
			break;
		case 'SKIRMISHER_MOBILITY_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.SKIRMISHER_MOBILITY_BONUS);
			break;
		case 'SKIRMISHER_CHANCE_PER_TILE':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.SKIRMISHER_CHANCE_PER_TILE, OutString);
			break;
		case 'SKIRMISHER_CHANCE_CAP':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.SKIRMISHER_CHANCE_PER_TILE * class'X2Ability_WOTC_APA_SapperAbilitySet'.default.SKIRMISHER_CHANCE_TILE_CAP, OutString);
			break;
		case 'ENTRENCHED_DAMAGE_REDUCTION':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.ENTRENCHED_DAMAGE_REDUCTION);
			break;
		case 'RETURN_FIRE_ACTIVATIONS_PER_TURNS':
			OutString = default.strOnce;
			iVal = class'X2Ability_WOTC_APA_SapperAbilitySet'.default.RETURN_FIRE_ACTIVATIONS_PER_TURN;
			if (iVal > 1)
			{
				OutString = default.strUpTo @ "<font color='#3ABD23'>" $ string(iVal) $ "</font>" @ default.strTimes;
			}
			break;
		case 'AIRBURST_GRENADES_BONUS_RADIUS':
			fVal = (class'X2Ability_WOTC_APA_SapperAbilitySet'.default.AIRBURST_GRENADES_BONUS_RADIUS);
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, OutString);
			break;
		case 'CHARGE_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.CHARGE_COOLDOWN - 1);
			break;
		case 'CONCENTRATED_CORROSIVES_ORGANIC_RUPTURE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.CONCENTRATED_CORROSIVES_ORGANIC_RUPTURE);
			break;
		case 'CONCENTRATED_CORROSIVES_MECHANICAL_RUPTURE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.CONCENTRATED_CORROSIVES_MECHANICAL_RUPTURE);
			break;
		case 'BURN_OUT_PANIC_CHANCE':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.BURN_OUT_PANIC_CHANCE, OutString);
			break;
		case 'BURN_OUT_SCATTER_CHANCE':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.BURN_OUT_SCATTER_CHANCE, OutString);
			break;
		case 'HOLD_POSITION_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.HOLD_POSITION_COOLDOWN - 1);
			break;

			
			

		case 'HEAT_WARHEADS_ARMOR_PIERCE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.HEAT_WARHEADS_ARMOR_PIERCE);
			break;
		case 'HEAT_WARHEADS_ARMOR_SHRED':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.HEAT_WARHEADS_ARMOR_SHRED);
			break;
		case 'MINEFIELD_BONUS_MINE_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.MINEFIELD_BONUS_MINE_CHARGES);
			break;
		case 'REFLEX_ACTIVATIONS_PER_TURN':
			OutString = default.strOnce;
			iVal = class'X2Ability_WOTC_APA_SapperAbilitySet'.default.REFLEX_ACTIVATIONS_PER_TURN;
			if (iVal > 1)
			{
				OutString = default.strUpTo @ "<font color='#3ABD23'>" $ string(iVal) $ "</font>" @ default.strTimes;
			}
			break;
		case 'EXPLOSIVE_ACTION_ACTIONS_LOSE':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ACTION_ACTIONS_LOSE);
			break;
		case 'EXPLOSIVE_ACTION_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.EXPLOSIVE_ACTION_COOLDOWN - 1);
			break;
		case 'REMOTE_START_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_SapperAbilitySet'.default.REMOTE_START_COOLDOWN - 1);
			break;

			

			
			
		// --------------------------------- //
		// Class-Specific Tags - Specialist: //
		// --------------------------------- //

		// Protocol Packages Proficiency Level Tags - Individual
		case 'AID_PROTOCOL_INITIAL_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_INITIAL_CHARGES);
			break;
		case 'BLIND_PROTOCOL_INITIAL_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_INITIAL_CHARGES);
			break;
		case 'COMBAT_PROTOCOL_INITIAL_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_INITIAL_CHARGES);
			break;
		case 'PP_III_ABC_PROTOCOL_RECHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.PP_III_ABC_PROTOCOL_RECHARGE_BONUS);
			break;
		case 'PP_III_ABC_PROTOCOL_CHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.PP_III_ABC_PROTOCOL_CHARGE_BONUS);
			break;
		case 'AID_PROTOCOL_INITIAL_RECHARGE_TURNS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_INITIAL_RECHARGE_TURNS - 1);
			break;
		case 'BLIND_PROTOCOL_INITIAL_RECHARGE_TURNS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_INITIAL_RECHARGE_TURNS - 1);
			break;
		case 'COMBAT_PROTOCOL_INITIAL_RECHARGE_TURNS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_INITIAL_RECHARGE_TURNS - 1);
			break;

		// Class Ability Tags
		case 'AID_PROTOCOL_RECHARGE_TURNS':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				
				if (SourceUnitState.GetUnitValue(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RECHARGE_NAME, UnitValue))	
					class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(UnitValue.fValue - 1, OutString);
			}
			break;
		case 'AID_PROTOCOL_RECHARGE_DESC':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				if (AbilityState.iCharges == 1)
					Outstring = `XEXPAND.ExpandString(default.strAidProtocolRechargeDesc);
			}
			break;
		case 'AID_PROTOCOL_RADIUS_CV':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T1_BASE, OutString);
			break;
		case 'AID_PROTOCOL_RADIUS_MG':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T2_BONUS, OutString);
			break;
		case 'AID_PROTOCOL_RADIUS_BM':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T3_BONUS, OutString);
			break;
		case 'AID_PROTOCOL_RADIUS_DESC':
			OutString = default.strAidProtocolRadiusStrategy;
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
			}
			if (SourceUnitState != none)
			{
				nName = X2WeaponTemplate(SourceUnitState.GetItemInSlot(eInvSlot_SecondaryWeapon, GameState).GetMyTemplate()).WeaponTech;
				switch (nName)
				{
					case 'conventional':
						fVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T1_BASE;
						break;
					case 'magnetic':
						fVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T2_BONUS;
						break;
					case 'beam':
						fVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_RADIUS_T3_BONUS;
						break;
				}
				if (SourceUnitState.HasSoldierAbility('WOTC_APA_NeutralizingAgents'))
				{
					fVal += class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.NEUTRALIZING_AGENTS_BONUS_RADIUS;
				}
				class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, sStr);
				OutString = Repl(default.strAidProtocolRadiusTactical, "<Radius/>", "<font color='#3ABD23'>" $ sStr $ "</font>");
			}
			break;
		case 'AID_PROTOCOL_DEFENSE_BOOST':
			//OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.AID_PROTOCOL_SMOKE_DEFENSE);
			OutString = string(-class'X2Item_DefaultGrenades'.default.SMOKEGRENADE_HITMOD);
			break;
		case 'AID_PROTOCOL_SMOKE_DURATION':
			OutString = string(class'X2Effect_ApplySmokeGrenadeToWorld'.default.Duration);
			break;

		case 'BLIND_PROTOCOL_RECHARGE_TURNS':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				
				if (SourceUnitState.GetUnitValue(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RECHARGE_NAME, UnitValue))	
					class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(UnitValue.fValue - 1, OutString);
			}
			break;
		case 'BLIND_PROTOCOL_RECHARGE_DESC':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				if (AbilityState.iCharges == 1)
					Outstring = `XEXPAND.ExpandString(default.strBlindProtocolRechargeDesc);
			}
			break;
		case 'BLIND_PROTOCOL_RADIUS_CV':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T1_BASE, OutString);
			break;
		case 'BLIND_PROTOCOL_RADIUS_MG':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T2_BONUS, OutString);
			break;
		case 'BLIND_PROTOCOL_RADIUS_BM':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T3_BONUS, OutString);
			break;
		case 'BLIND_PROTOCOL_RADIUS_DESC':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
			}
			if (SourceUnitState != none)
			{
				nName = X2WeaponTemplate(SourceUnitState.GetItemInSlot(eInvSlot_SecondaryWeapon, GameState).GetMyTemplate()).WeaponTech;
				switch (nName)
				{
					case 'conventional':
						fVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T1_BASE;
						break;
					case 'magnetic':
						fVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T2_BONUS;
						break;
					case 'beam':
						fVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.BLIND_PROTOCOL_RADIUS_T3_BONUS;
						break;
				}
				class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(fVal, sStr);
				OutString = Repl(default.strBlindProtocolRadiusTactical, "<Radius/>", "<font color='#3ABD23'>" $ sStr $ "</font>");
			}
			break;
		case 'BLIND_PROTOCOL_STRATEGY_DESC':
			OutString = "";
			if (StrategyParseObj != none)
			{
				OutString = default.strBlindProtocolRadiusStrategy;
			}
			break;

		case 'COMBAT_PROTOCOL_RECHARGE_TURNS':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				
				if (SourceUnitState.GetUnitValue(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_RECHARGE_NAME, UnitValue))	
					class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(UnitValue.fValue - 1, OutString);
			}
			break;
		case 'COMBAT_PROTOCOL_RECHARGE_DESC':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				if (AbilityState.iCharges == 1)
					Outstring = `XEXPAND.ExpandString(default.strCombatProtocolRechargeDesc);
			}
			break;
		case 'COMBAT_PROTOCOL_BASE_DAMAGE_CV':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T1_BASE);
			break;
		case 'COMBAT_PROTOCOL_BASE_DAMAGE_MG':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T2_BONUS);
			break;
		case 'COMBAT_PROTOCOL_BASE_DAMAGE_BM':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T3_BONUS);
			break;
		case 'COMBAT_PROTOCOL_BASE_DAMAGE':
			OutString = default.strCombatProtocolBaseDamageStrategy;
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
			}
			if (SourceUnitState != none)
			{
				nName = X2WeaponTemplate(SourceUnitState.GetItemInSlot(eInvSlot_SecondaryWeapon, GameState).GetMyTemplate()).WeaponTech;
				switch (nName)
				{
					case 'conventional':
						iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T1_BASE;
						break;
					case 'magnetic':
						iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T2_BONUS;
						break;
					case 'beam':
						iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_DAMAGE_T3_BONUS;
						break;
				}
				OutString = "<font color='#3ABD23'>" $ string(iVal) $ "</font>";
			}
			break;
		case 'COMBAT_PROTOCOL_MECH_DAMAGE_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.COMBAT_PROTOCOL_MECH_DAMAGE_MULTIPLIER * 100, OutString);
			break;
		case 'COMBAT_PROTOCOL_DAMAGE_DESC':
			OutString = default.strCombatProtocolDamageDescStrategy;
			if (StrategyParseObj == none)
			{
				OutString = default.strCombatProtocolDamageDesc;
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
			}
			if (SourceUnitState != none)
			{
				if (SourceUnitState.HasSoldierAbility('WOTC_APA_Overload'))
				{
					OutString = default.strCombatProtocolOverloadDamageDesc;
				}
				else
				{
					OutString = default.strCombatProtocolDamageDesc;
				}
			}
			Outstring = `XEXPAND.ExpandString(Outstring);
			break;
		case 'BREAKS_SQUAD_CONCEALMENT_WARNING':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
			}
			if (SourceUnitState != none)
			{
				if (XComGameState_Player(`XCOMHISTORY.GetGameStateForObjectID(SourceUnitState.ControllingPlayer.ObjectID)).bSquadIsConcealed)
				{
					OutString = default.strBreaksSquadConcealmentWarning;
				}
			}
			break;

		case 'REMOTE_REPAIR_BASE_HEALTH_CV':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T1_BASE);
			break;
		case 'REMOTE_REPAIR_BASE_HEALTH_MG':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T2_BONUS);
			break;
		case 'REMOTE_REPAIR_BASE_HEALTH_BM':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T3_BONUS);
			break;
		case 'REMOTE_REPAIR_BASE_HEALTH':
			OutString = default.strRemoteRepairBaseHealthStrategy;
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
			}
			if (SourceUnitState != none)
			{
				nName = X2WeaponTemplate(SourceUnitState.GetItemInSlot(eInvSlot_SecondaryWeapon, GameState).GetMyTemplate()).WeaponTech;
				switch (nName)
				{
					case 'conventional':
						iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T1_BASE;
						break;
					case 'magnetic':
						iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T2_BONUS;
						break;
					case 'beam':
						iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T1_BASE + class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.REMOTE_REPAIR_HP_T3_BONUS;
						break;
				}
				OutString = "<font color='#3ABD23'>+" $ string(iVal) $ "HP</font>";
			}
			break;
		case 'REMOTE_REPAIR_STRATEGY_DESC':
			OutString = "";
			if (StrategyParseObj != none)
			{
				OutString = default.strRemoteRepairHealthStrategyDesc;
			}
			break;
		case 'HAYWIRE_PROTOCOL_COOLDOWN':
			OutString = string(class'X2Ability_SpecialistAbilitySet'.default.HAYWIRE_PROTOCOL_COOLDOWN - 1);
			break;
		case 'HAYWIRE_PROTOCOL_TURN_DURATION':
			OutString = string(class'X2Ability_HackRewards'.default.CONTROL_ROBOT_DURATION);
			break;
		case 'FAILSAFE_HACK_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.FAILSAFE_HACK_BONUS);
			break;
		case 'FAILSAFE_ACTION_COST':
			OutString = default.strFailsafeActionCostDesc;
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
			}
			if (SourceUnitState != none)
			{
				SourceUnitState.GetUnitValue(class'X2Effect_WOTC_APA_ElectronicWarfare'.default.FreeFailsafeActivationsUnitName, UnitValue);
				iVal = int(UnitValue.fValue);
				if (iVal > 0)
				{
					OutString = Repl(default.strFailsafeActionFreeDesc, "<Amount/>", "<font color='#3ABD23'>" $ iVal $ "</font>");
				}
			}
			break;
			

		case 'ADAPTIVE_PLATING_ABLATIVE':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ADAPTIVE_PLATING_ABLATIVE);
			break;
		case 'ADAPTIVE_PLATING_ARMOR':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ADAPTIVE_PLATING_ARMOR);
			break;
		case 'SURVEILLANCE_FREE_BATTLESCANNERS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.SURVEILLANCE_FREE_BATTLESCANNERS);
			break;
		case 'SURVEILLANCE_BONUS_BATTLESCANNERS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.SURVEILLANCE_BONUS_BATTLESCANNERS);
			break;
		case 'OVERLOAD_NON_MECH_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.OVERLOAD_NON_MECH_DAMAGE_BONUS);
			break;
		case 'OVERLOAD_MECH_DAMAGE_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.OVERLOAD_MECH_DAMAGE_MULTIPLIER * 100, OutString);
			break;
		case 'OVERLOAD_RECHARGE_TURN_PENALTY':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.OVERLOAD_RECHARGE_TURN_PENALTY);
			break;
		case 'SILENT_MOTORS_DETECTION_BONUS':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.SILENT_MOTORS_DETECTION_BONUS * 100, OutString);
			break;
		case 'SILENT_MOTORS_DETECTION_PENALTY':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.SILENT_MOTORS_DETECTION_PENALTY * 100, OutString);
			break;
		case 'DISRUPTION_FIELD_BONUS_DEFENSE':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.DISRUPTION_FIELD_BONUS_DEFENSE);
			break;
		case 'DISRUPTION_FIELD_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.DISRUPTION_FIELD_COOLDOWN - 1);
			break;
		case 'PSIONIC_FEEDBACK_VULNERABLE_PANIC_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.PSIONIC_FEEDBACK_VULNERABLE_PANIC_CHANCE);
			break;
		case 'PSIONIC_FEEDBACK_NORMAL_PANIC_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.PSIONIC_FEEDBACK_NORMAL_PANIC_CHANCE);
			break;
		case 'PSIONIC_FEEDBACK_RESISTANT_PANIC_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.PSIONIC_FEEDBACK_RESISTANT_PANIC_CHANCE);
			break;
		case 'PSIONIC_FEEDBACK_T2_GREMLIN_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.PSIONIC_FEEDBACK_T2_GREMLIN_MULTIPLIER, OutString);
			break;
		case 'PSIONIC_FEEDBACK_T3_GREMLIN_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.PSIONIC_FEEDBACK_T3_GREMLIN_MULTIPLIER, OutString);
			break;
		case 'PSIONIC_FEEDBACK_UNACTIVATED_MULTIPLIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((1 - class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.PSIONIC_FEEDBACK_UNACTIVATED_MULTIPLIER) * 100, OutString);
			break;
		case 'NEUTRALIZING_AGENTS_BONUS_RADIUS':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.NEUTRALIZING_AGENTS_BONUS_RADIUS, OutString);
			break;
		case 'NEUTRALIZING_AGENTS_IMMUNITY_DURATION':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.NEUTRALIZING_AGENTS_IMMUNITY_DURATION);
			break;
		case 'ANTI_ARMOR_MECH_BONUS_CRIT':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ANTI_ARMOR_MECH_BONUS_CRIT);
			break;
		case 'ANTI_ARMOR_RIFLE_MOBILITY_PENALTY':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ANTI_ARMOR_RIFLE_MOBILITY_PENALTY);
			break;
		case 'ELECTRONIC_WARFARE_FREE_FAILSAFE':
			OutString = "";
			iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ELECTRONIC_WARFARE_FREE_FAILSAFE;
			if (iVal > 1)
			{
				OutString = " " $ string(iVal);
			}
			break;
		case 'ELECTRONIC_WARFARE_BONUS_HACKING':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ELECTRONIC_WARFARE_BONUS_HACKING);
			break;
		case 'TARGETING_UPLINK_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.TARGETING_UPLINK_COOLDOWN - 1);
			break;
		case 'TARGETING_UPLINK_RANGE_PENALTY_NEGATED':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.TARGETING_UPLINK_RANGE_PENALTY_NEGATED * 100, OutString);
			break;
		case 'TARGETING_UPLINK_CRIT_BONUS_PER_TECH_LVL':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.TARGETING_UPLINK_CRIT_BONUS_PER_TECH_LVL);
			break;
		case 'TARGETING_UPLINK_CRIT_BONUS':
			OutString = "";
			if (StrategyParseObj == none)
			{
				AbilityState = XComGameState_Ability(ParseObj);
				EffectState = XComGameState_Effect(ParseObj);
				if (AbilityState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
				else if (EffectState != none)
					SourceUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
			}
			if (SourceUnitState != none)
			{
				nName = X2WeaponTemplate(SourceUnitState.GetItemInSlot(eInvSlot_SecondaryWeapon, GameState).GetMyTemplate()).WeaponTech;
				switch (nName)
				{
					case 'conventional':
						iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.TARGETING_UPLINK_CRIT_BONUS_PER_TECH_LVL;
						break;
					case 'magnetic':
						iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.TARGETING_UPLINK_CRIT_BONUS_PER_TECH_LVL * 2;
						break;
					case 'beam':
						iVal = class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.TARGETING_UPLINK_CRIT_BONUS_PER_TECH_LVL * 3;
						break;
				}
				OutString = "<font color='#3ABD23'>+" $ string(iVal) $ "%</font> ";
			}
			break;
		case 'EMP_SHOCKWAVE_HACK_DEFENSE_REDUCTION':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.EMP_SHOCKWAVE_HACK_DEFENSE_REDUCTION);
			break;
		case 'EMP_SHOCKWAVE_SHUTDOWN_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.EMP_SHOCKWAVE_SHUTDOWN_CHANCE);
			break;
		case 'ADVANCED_REPAIR_BONUS_REPAIR_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ADVANCED_REPAIR_BONUS_REPAIR_CHARGES);
			break;
		case 'ADVANCED_REPAIR_ARMOR_RESTORED':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ADVANCED_REPAIR_ARMOR_RESTORED);
			break;
		case 'MINIATURIZED_MUNITIONS_BONUS_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.MINIATURIZED_MUNITIONS_BONUS_CHARGES);
			break;
		case 'MINIATURIZED_MUNITIONS_DAMAGE_MODIFIER':
			class'WOTC_APA_Class_Utilities_Text'.static.TrimTrailingZerosFromFloat((1 - class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.MINIATURIZED_MUNITIONS_DAMAGE_MODIFIER) * 100, OutString);
			break;
		case 'ADVANCED_ROBOTICS_ABC_PROTOCOL_CHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ADVANCED_ROBOTICS_ABC_PROTOCOL_CHARGE_BONUS);
			break;
		case 'ADVANCED_ROBOTICS_ABC_PROTOCOL_RECHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ADVANCED_ROBOTICS_ABC_PROTOCOL_RECHARGE_BONUS);
			break;
		case 'FULL_OVERRIDE_INITIAL_CHARGES':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.FULL_OVERRIDE_INITIAL_CHARGES);
			break;
		case 'SPRINT_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.SPRINT_COOLDOWN - 1);
			break;
		case 'HOT_CHARGED_BATTERIES_CHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.HOT_CHARGED_BATTERIES_CHARGE_BONUS);
			break;
		case 'HOT_CHARGED_BATTERIES_RECHARGE_PENALTY':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.HOT_CHARGED_BATTERIES_RECHARGE_PENALTY);
			break;
		case 'UPGRADED_SCANNERS_DURATION':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.UPGRADED_SCANNERS_DURATION);
			break;
		case 'UPGRADED_SCANNERS_AIM_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.UPGRADED_SCANNERS_AIM_BONUS);
			break;
		case 'UPGRADED_SCANNERS_CRIT_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.UPGRADED_SCANNERS_CRIT_BONUS);
			break;




		// We don't handle this tag, check the wrapped tag.
		default:
			WrappedTag.ParseObj = ParseObj;
			WrappedTag.StrategyParseObj = StrategyParseObj;
			WrappedTag.GameState = GameState;
			WrappedTag.ExpandHandler(InString, OutString);
			// clear them out again (the 3 lines below are the part updated from 2.0.0 to prevent garbage collection-related crashes after missions)
			WrappedTag.ParseObj = none;
			WrappedTag.StrategyParseObj = none;
			WrappedTag.GameState = none;  
			return;
	}
}