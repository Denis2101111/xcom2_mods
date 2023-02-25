
class X2Effect_WOTC_APA_AntiVenomStims extends X2Effect_Persistent;

var name WOTC_APA_AntiVenomStims_TriggeredName;

// Provide Poison Immunity if effect passes relevant check
function bool ProvidesDamageImmunity(XComGameState_Effect EffectState, name DamageType)
{

	local XComGameState_Unit TargetUnit;

	if(DamageType == 'Poison' || DamageType == 'ParthenogenicPoison')
	{
		TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
		return IsEffectCurrentlyRelevant(EffectState, TargetUnit);
	}
	return false;
}

// Check that effect should apply (valid Source, Target, and within range)
function bool IsEffectCurrentlyRelevant(XComGameState_Effect EffectGameState, XComGameState_Unit TargetUnit)
{

	local XComGameState_Unit SourceUnit;

	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	
	if (SourceUnit == none || SourceUnit.IsDead() || TargetUnit == none || TargetUnit.IsDead())
		return false;

	if (SourceUnit.ObjectID != TargetUnit.ObjectID)
	{
		// Add 0.01 to range to smooth rounding wierdness on half values
		if(!class'Helpers'.static.IsUnitInRange(SourceUnit, TargetUnit, 0, (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ANTIVENOM_STIMS_DISTANCE + 0.01) * class'XComWorldData'.const.WORLD_StepSize))
			return false;
	}
	return true;
}


// Keeping same XComPerkContent Particle FX for now
function OnUnitChangedTile(const out TTile NewTileLocation, XComGameState_Effect EffectState, XComGameState_Unit TargetUnit)
{
	local XComWorldData WorldData;
	local XComGameStateHistory History;
	local XComGameState_Unit SourceUnit, CurrentTargetUnit;
	local XGUnit SourceXGUnit;
	local XComGameState_Effect OtherEffect;
	local bool bAddTarget;
	local int i;
	local bool bHazard;
	local XComUnitPawnNativeBase SourcePawn;
	local array<XComPerkContentInst> Perks;
	local PerkActivationData ActivationData;
	local array<XGUnit> Targets;
	local array<vector> Locations;

	//first handle the passive little effects, like Solace, that trigger when unit enters/leaves range

	History = `XCOMHISTORY;
	if (TargetUnit.ObjectID != EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID)
	{
		SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
		if (SourceUnit != none && SourceUnit.IsAlive() && TargetUnit.IsAlive())
		{
			bAddTarget = class'Helpers'.static.IsTileInRange(SourceUnit.TileLocation, NewTileLocation, (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ANTIVENOM_STIMS_DISTANCE + 0.01) ^ 2);
			EffectState.UpdatePerkTarget(bAddTarget);
		}
	}
	else
	{
		//  When the source moves, check all other targets and update them
		SourceUnit = TargetUnit;
		for (i = 0; i < EffectState.ApplyEffectParameters.AbilityInputContext.MultiTargets.Length; ++i)
		{
			if (EffectState.ApplyEffectParameters.AbilityInputContext.MultiTargets[i].ObjectID != SourceUnit.ObjectID)
			{
				CurrentTargetUnit = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityInputContext.MultiTargets[i].ObjectID));
				OtherEffect = CurrentTargetUnit.GetUnitAffectedByEffectState(default.EffectName);
				if (OtherEffect != none)
				{
					bAddTarget = class'Helpers'.static.IsTileInRange(NewTileLocation, CurrentTargetUnit.TileLocation, (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ANTIVENOM_STIMS_DISTANCE + 0.01) ^ 2);
					OtherEffect.UpdatePerkTarget(bAddTarget);
				}
			}
		}
	}

	//update FX for unit entering a hazard tile
	SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	if(class'Helpers'.static.IsTileInRange(SourceUnit.TileLocation, NewTileLocation, (class'X2Ability_WOTC_APA_MedicAbilitySet'.default.ANTIVENOM_STIMS_DISTANCE + 0.01) ^ 2))
	{
		WorldData = `XWORLD;
		//  assumes DamageImmunities includes Poison
		bHazard = WorldData.TileContainsPoison(NewTileLocation);

		SourceXGUnit = XGUnit( History.GetVisualizer( EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID ) );

		if (SourceXGUnit != none)
		{
			SourcePawn = SourceXGUnit.GetPawn( );

			class'XComPerkContent'.static.GetAssociatedPerkInstances( Perks, SourcePawn, EffectState.ApplyEffectParameters.AbilityInputContext.AbilityTemplateName );
			
			for (i = 0; i < Perks.Length; ++i)
			{
				if (bHazard && Perks[ i ].IsInState('Idle'))
				{
					Targets.Length = 0;
					Locations.Length = 0;

					Perks[ i ].OnPerkActivation(ActivationData);
					//Perks[ i ].OnPerkActivation(SourceXGUnit, Targets, Locations, false);
				}
				else if (!bHazard && Perks[ i ].IsInState('ActionActive'))
				{
					Perks[ i ].OnPerkDeactivation( );
				}
			}
		}
	}
}

DefaultProperties
{
	EffectName="WOTC_APA_AntiVenomStims"
	DuplicateResponse=eDupe_Allow

	WOTC_APA_AntiVenomStims_TriggeredName="WOTC_APA_AntiVenomStims_Triggered"
}