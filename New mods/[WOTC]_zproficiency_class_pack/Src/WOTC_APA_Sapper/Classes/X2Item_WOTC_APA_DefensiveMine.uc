
class X2Item_WOTC_APA_DefensiveMine extends X2Item config(WOTC_APA_SapperSkills);

var config WeaponDamageValue	DEFENSIVE_MINE_BASEDAMAGE;
var config int					DEFENSIVE_MINE_ENVIRONMENTDAMAGE;
var config int					DEFENSIVE_MINE_RANGE;
var config int					DEFENSIVE_MINE_RADIUS;
var config int					DEFENSIVE_MINE_SOUNDRANGE;
var config int					DEFENSIVE_MINE_PHYSICSIMPULSE;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Grenades;

	Grenades.AddItem(WOTC_APA_DefensiveMine());

	return Grenades;
}


static function X2GrenadeTemplate WOTC_APA_DefensiveMine()
{
	local X2GrenadeTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'WOTC_APA_DefensiveMineItem');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Proximity_Mine";
	Template.GameArchetype = "WP_Proximity_Mine.WP_Proximity_Mine";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.HideInInventory = true;
	Template.CanBeBuilt = false;
	
	Template.iRange = default.DEFENSIVE_MINE_RANGE;
	Template.iRadius = default.DEFENSIVE_MINE_RADIUS;
	Template.iClipSize = 1;
	Template.BaseDamage = default.DEFENSIVE_MINE_BASEDAMAGE;
	Template.iSoundRange = default.DEFENSIVE_MINE_SOUNDRANGE;
	Template.iPhysicsImpulse = default.DEFENSIVE_MINE_PHYSICSIMPULSE;
	Template.iEnvironmentDamage = default.DEFENSIVE_MINE_ENVIRONMENTDAMAGE;
	Template.DamageTypeTemplateName = 'Explosion';
	Template.Tier = 1;

	Template.Abilities.AddItem('WOTC_APA_DefensiveMineDeploy');
	Template.Abilities.AddItem(class'X2Ability_Grenades'.default.ProximityMineDetonationAbilityName);
	Template.Abilities.AddItem('GrenadeFuse');
	
	return Template;
}


defaultproperties
{
	bShouldCreateDifficultyVariants = true
}