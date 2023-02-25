
class X2AbilityTag_WOTC_APA_Reaper extends X2AbilityTag;

// Modified and Implemented from Xylith's XModBase

// The previous X2AbilityTag. We save it so we can just call it to handle any tag we don't
// recognize, so we don't have to include a copy of the regular X2AbilityTag code. This also
// makes it so we will play well with any other mods that replace X2AbilityTag this way.
var X2AbilityTag WrappedTag;

var localized string strOnce;
var localized string strUpTo;
var localized string strTimes;
var localized string strTiles;

var localized string strFailsafeActionFreeDesc;
var localized string strFailsafeActionCostDesc;


// Supporting Text Functions
simulated static function TrimTrailingZerosFromFloat(float InputValue, out string text)
{
	text = string(InputValue);

	while ((Len(text) > 0) && (InStr(text, "0", true) == Len(text) - 1))
		text = left(text, Len(text) - 1);
	while ((Len(text) > 0) && (InStr(text, ".", true) == Len(text) - 1))
		text = left(text, Len(text) - 1);
}

simulated static function TrimTrailingZerosFromFloatExceptOne(float InputValue, out string text)
{
	text = string(InputValue);

	while ((Len(text) > 0) && (InStr(text, "0", true) == Len(text) - 1))
		text = left(text, Len(text) - 1);
	while ((Len(text) > 0) && (InStr(text, ".", true) == Len(text) - 1))
		text = left(text, Len(text) - 1);

	if (InStr(text, ".", true) == -1)
		text = text $ ".0";
}


simulated static function RoundUpFloat(float InputValue, out int i)
{

	if (InputValue - int(InputValue) > 0)
	{
		i = int(InputValue) + 1;
	}
	else
	{
		i = InputValue;
	}
}


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

		// Shadow Meld Proficiency Level Tags
		case 'SHADOW_STACK_MAX_I':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_MAX_I);
			break;
		case 'SHADOW_STACK_MAX_II':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_MAX_II);
			break;
		case 'SHADOW_STACK_MAX_III':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_MAX_III);
			break;
		case 'SHADOW_STACK_START_I':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_START_I);
			break;
		case 'SHADOW_STACK_START_II':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_START_II);
			break;
		case 'SHADOW_STACK_START_III':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_START_III);
			break;

		case 'SHADOW_STACK_GAIN_PER_TURN':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_GAIN_PER_TURN);
			break;
		case 'SHADOW_STACK_GAIN_HUNKER':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_GAIN_HUNKER);
			break;

		case 'SHADOW_STACK_VARIABLE_DETECTION_BONUS':
			fVal = (class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_VARIABLE_DETECTION_BONUS * 100);
			TrimTrailingZerosFromFloat(fVal, OutString);
			break;
		case 'SHADOW_STACK_CRIT_CHANCE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_CRIT_CHANCE_BONUS);
			break;

		// Class Ability Tags
		case 'SHADOW_STACK_PRIMARY_ATTACK_COST':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_PRIMARY_ATTACK_COST);
			break;
		case 'SHADOW_STACK_SECONDARY_ATTACK_COST':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_STACK_SECONDARY_ATTACK_COST);
			break;
		
		case 'INFILTRATION_HACK_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.INFILTRATION_HACK_BONUS);
			break;
		case 'INFILTRATION_RECONCEAL_SHADOW_STACKS':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.INFILTRATION_RECONCEAL_SHADOW_STACKS);
			break;
		
		case 'HAUNT_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.HAUNT_DAMAGE_BONUS);
			break;
		case 'HAUNT_PANIC_CHANCE':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.HAUNT_PANIC_CHANCE);
			break;
		case 'HAUNT_PANIC_RANGE':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.HAUNT_PANIC_RANGE);
			break;
		case 'BEAST_HUNTER_DAMAGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.BEAST_HUNTER_DAMAGE_BONUS);
			break;
		case 'BEAST_HUNTER_SHADOW_CRIT_CHANCE_MOD':
			fVal = (class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.BEAST_HUNTER_SHADOW_CRIT_CHANCE_MOD);
			TrimTrailingZerosFromFloatExceptOne(fVal, OutString);
			break;

		case 'SHADOW_VALUE_THRESHOLD_I':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_I) $ "-" $ string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_II - 1);
			break;
		case 'SHADOW_VALUE_THRESHOLD_II':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_II) $ "-" $ string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_III - 1);
			break;
		case 'SHADOW_VALUE_THRESHOLD_III':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.SHADOW_VALUE_THRESHOLD_III) $ "+ ";
			break;
		case 'WEAKPOINT_ARMOR_PIERCE_I':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.WEAKPOINT_ARMOR_PIERCE_I);
			break;
		case 'WEAKPOINT_ARMOR_PIERCE_II':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.WEAKPOINT_ARMOR_PIERCE_II);
			break;
		case 'WEAKPOINT_ARMOR_PIERCE_III':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.WEAKPOINT_ARMOR_PIERCE_III);
			break;
		case 'HOUND_MOBILITY_BONUS_I':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.HOUND_MOBILITY_BONUS_I);
			break;
		case 'HOUND_MOBILITY_BONUS_II':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.HOUND_MOBILITY_BONUS_II);
			break;
		case 'HOUND_MOBILITY_BONUS_III':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.HOUND_MOBILITY_BONUS_III);
			break;
		case 'PRECISE_STRIKE_COVER_AIM_BONUS_I':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.PRECISE_STRIKE_COVER_AIM_BONUS_I);
			break;
		case 'PRECISE_STRIKE_COVER_AIM_BONUS_II':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.PRECISE_STRIKE_COVER_AIM_BONUS_II);
			break;
		case 'PRECISE_STRIKE_COVER_AIM_BONUS_III':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.PRECISE_STRIKE_COVER_AIM_BONUS_III);
			break;
		case 'UNDERMINE_RUPTURE_DAMAGE':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.UNDERMINE_RUPTURE_DAMAGE);
			break;
		case 'ANNIHILATION_CHARGE_BONUS':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.ANNIHILATION_CHARGE_BONUS);
			break;
		case 'ANNIHILATION_BANISH_COOLDOWN':
			OutString = string(class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.ANNIHILATION_BANISH_COOLDOWN - 1);
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