class X2Effect_WOTC_APA_ApplyNeutralizingAgentsSmokeToWorld extends X2Effect_World;

var int Duration;
var string SmokeParticleSystemFill_Name;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{ }

static simulated function int GetTileDataDynamicFlagValue() { return 8; }
static simulated event bool IsConsideredHazard( const out VolumeEffectTileData TileData ) { return false; }
static simulated function bool FillRequiresLOSToTargetLocation( ) { return false; }
static simulated function int GetTileDataNumTurns() { return default.Duration; }

event array<X2Effect> GetTileEnteredEffects()
{
	local array<X2Effect>										TileEnteredEffects;
	local X2Effect_WOTC_APA_NeutralizingAgentsDamageImmunity	DamageImmunity;
	local X2Effect_RemoveEffectsByDamageType					ClenseEffect;
	
	DamageImmunity = new class'X2Effect_WOTC_APA_NeutralizingAgentsDamageImmunity';
	DamageImmunity.BuildPersistentEffect(Duration + 1, false, false, false, eGameRule_PlayerTurnBegin);
	DamageImmunity.SetDisplayInfo(ePerkBuff_Bonus, class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.strNeutralizingAgentsEffectName, class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.strNeutralizingAgentsEffectDesc, "img:///UILibrary_WOTC_APA_Class_Pack.perk_NeutralizingAgents");
	DamageImmunity.DuplicateResponse = eDupe_Refresh;
	DamageImmunity.ImmuneTypes.AddItem('Fire');
	DamageImmunity.ImmuneTypes.AddItem('Acid');

	ClenseEffect = new class'X2Effect_RemoveEffectsByDamageType';
	ClenseEffect.DamageTypesToRemove.AddItem('Fire');
	ClenseEffect.DamageTypesToRemove.AddItem('Acid');

	TileEnteredEffects.AddItem(DamageImmunity);
	TileEnteredEffects.AddItem(ClenseEffect);
	return TileEnteredEffects;
}

event array<ParticleSystem> GetParticleSystem_Fill()
{
	local array<ParticleSystem> ParticleSystems;
	//ParticleSystems.AddItem(none);
	ParticleSystems.AddItem(ParticleSystem(DynamicLoadObject("PerkFX_WOTC_APA_Class_Pack.P_Neutralizing_Agents_Smoke_Fill", class'ParticleSystem')));
	return ParticleSystems;
}

simulated function ApplyEffectToWorld(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState)
{
	local XComGameStateHistory History;
	local XComGameState_Ability AbilityStateObject;
	local XComGameState_Unit SourceStateObject;
	local float AbilityRadius, AbilityCoverage;
	local XComWorldData WorldData;
	local vector TargetLocation, TopLocation;
	local array<TilePosPair> OutTiles;

	if( ApplyEffectParameters.AbilityInputContext.TargetLocations.Length > 0 )
	{
		History = `XCOMHISTORY;
		SourceStateObject = XComGameState_Unit(History.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));	
		AbilityStateObject = XComGameState_Ability(History.GetGameStateForObjectID(ApplyEffectParameters.AbilityStateObjectRef.ObjectID));									

		if( SourceStateObject != none && AbilityStateObject != none )
		{	
			WorldData = `XWORLD;
			AbilityRadius = AbilityStateObject.GetAbilityRadius();
			AbilityCoverage = AbilityStateObject.GetAbilityCoverage();
			TargetLocation = ApplyEffectParameters.AbilityInputContext.TargetLocations[0];
			
			TopLocation = TargetLocation;
			TopLocation.Z += AbilityRadius;
			
			WorldData.CollectFloorTilesBelowDisc( OutTiles, TopLocation, AbilityRadius );
			
			AddEffectToTiles(Class.Name, self, NewGameState, OutTiles, TargetLocation, AbilityRadius, AbilityCoverage);
		}
	}
}

static simulated event AddEffectToTiles(Name EffectName, X2Effect_World Effect, XComGameState NewGameState, array<TilePosPair> Tiles, vector TargetLocation, float Radius, float Coverage, optional XComGameState_Unit SourceStateObject = none, optional XComGameState_Item SourceWeaponState = none, optional bool bUseFireChance)
{
	local XComGameState_WorldEffectTileData GameplayTileUpdate;
	local array<TileIsland> TileIslands;
	local array<TileParticleInfo> TileParticleInfos;
	local VolumeEffectTileData InitialTileData;

	GameplayTileUpdate = XComGameState_WorldEffectTileData(NewGameState.CreateNewStateObject(class'XComGameState_WorldEffectTileData'));
	GameplayTileUpdate.WorldEffectClassName = EffectName;

	InitialTileData.EffectName = EffectName;
	InitialTileData.NumTurns = GetTileDataNumTurns();
	InitialTileData.DynamicFlagUpdateValue = GetTileDataDynamicFlagValue();
	if( SourceStateObject != none )
		InitialTileData.SourceStateObjectID = SourceStateObject.ObjectID;
	if( SourceWeaponState != none )
		InitialTileData.ItemStateObjectID = SourceWeaponState.ObjectID;

	FilterForLOS( Tiles, TargetLocation, Radius );

	TileIslands = CollapseTilesToPools(Tiles);
	DetermineFireBlocks(TileIslands, Tiles, TileParticleInfos);

	GameplayTileUpdate.SetInitialTileData(Tiles, InitialTileData, TileParticleInfos);

	`XEVENTMGR.TriggerEvent('GameplayTileEffectUpdate', GameplayTileUpdate, SourceStateObject, NewGameState);
}


simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, name EffectApplyResult)
{
	local X2Action_UpdateWorldEffects_Smoke AddSmokeAction;
	if( ActionMetadata.StateObject_NewState.IsA('XComGameState_WorldEffectTileData') )
	{
		AddSmokeAction = X2Action_UpdateWorldEffects_Smoke(class'X2Action_UpdateWorldEffects_Smoke'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
		AddSmokeAction.bCenterTile = bCenterTile;
		AddSmokeAction.SetParticleSystems(GetParticleSystem_Fill());
	}
}

simulated function AddX2ActionsForVisualization_Tick(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const int TickIndex, XComGameState_Effect EffectState)
{ }


defaultproperties
{
	bCenterTile = true;
}