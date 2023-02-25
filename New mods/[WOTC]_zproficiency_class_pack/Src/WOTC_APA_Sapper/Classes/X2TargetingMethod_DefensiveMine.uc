
class X2TargetingMethod_DefensiveMine extends X2TargetingMethod_Grenade;


function name ValidateTargetLocations(const array<Vector> TargetLocations)
{
	local name AbilityAvailability;
	local TTile TeleportTile;
	local XComWorldData World;
	local bool bFoundFloorTile;

	AbilityAvailability = super.ValidateTargetLocations(TargetLocations);
	if( AbilityAvailability == 'AA_Success' )
	{
		// There is only one target location and visible by squadsight
		World = `XWORLD;
		
		`assert(TargetLocations.Length == 1);
		bFoundFloorTile = World.GetFloorTileForPosition(TargetLocations[0], TeleportTile);
		if( bFoundFloorTile && !World.CanUnitsEnterTile(TeleportTile) )
		{
			AbilityAvailability = 'AA_TileIsBlocked';
		}
	}

	return AbilityAvailability;
}


function Update(float DeltaTime)
{
	local array<Actor> CurrentlyMarkedTargets;
	local vector NewTargetLocation;
	local array<vector> TargetLocations;
	local array<TTile> Tiles;

	NewTargetLocation = GetSplashRadiusCenter();
	TargetLocations.AddItem(NewTargetLocation);

	if (ValidateTargetLocations(TargetLocations) == 'AA_Success' )
	{		
		if (NewTargetLocation != CachedTargetLocation)
		{
			GetTargetedActors(NewTargetLocation, CurrentlyMarkedTargets, Tiles);
			CheckForFriendlyUnit(CurrentlyMarkedTargets);	
			MarkTargetedActors(CurrentlyMarkedTargets, (!AbilityIsOffensive) ? FiringUnit.GetTeam() : eTeam_None );
			DrawAOETiles(Tiles);
		}
		DrawSplashRadius( );
	}
	else
	{
		DrawInvalidTile();
	}

	super.Update(DeltaTime);
}


simulated protected function DrawInvalidTile()
{
	// Hide the ExplosionEmitter
	ExplosionEmitter.ParticleSystemComponent.DeactivateSystem();
}


static function bool UseGrenadePath() { return false; }