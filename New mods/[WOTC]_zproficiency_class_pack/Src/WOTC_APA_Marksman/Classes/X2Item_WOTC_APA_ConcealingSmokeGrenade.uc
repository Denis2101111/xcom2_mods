
class X2Item_WOTC_APA_ConcealingSmokeGrenade extends X2Item_DefaultGrenades;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> Items;

    Items.AddItem(WOTC_APA_ConcealingSmokeGrenade());

    return Items;
}


static function X2GrenadeTemplate WOTC_APA_ConcealingSmokeGrenade()
{
	local X2GrenadeTemplate									Template;
	local X2Effect_ApplySmokeGrenadeToWorld					SmokeEffect;
	local X2Condition_UnitProperty							TargetPropertyCondition;
	local X2Condition_WOTC_APA_Class_AbilityRequirement		TargetAbilityCondition;
	local X2Effect_Shadow									StealthEffect;
	local X2Effect_Spotted									UnspottedEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'WOTC_APA_ConcealingSmokeGrenade');

	Template.WeaponCat = 'Utility';
    Template.ItemCat = 'Utility';
	Template.strImage = "img:///UILibrary_WOTC_APA_Class_Pack.perk_ConcealingSmoke";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ConcealingSmoke");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_WOTC_APA_Class_Pack.perk_ConcealingSmoke");
	Template.iRange = (1.5 * class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.CONCEALING_SMOKE_RADIUS) - 1;
    Template.iRadius = (1.5 * class'X2Ability_WOTC_APA_MarksmanAbilitySet'.default.CONCEALING_SMOKE_RADIUS) + 1;

	Template.iSoundRange = default.SMOKEGRENADE_ISOUNDRANGE;
	Template.iEnvironmentDamage = 0;
	Template.iClipSize = 0;
	Template.Tier = 0;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.bFriendlyFireWarning = false;
	Template.CanBeBuilt = false;

	Template.GameArchetype = "WP_Grenade_Smoke.WP_Grenade_Smoke";
	Template.OnThrowBarkSoundCue = 'ActivateConcealment';
	//Template.OnThrowBarkSoundCue = 'SmokeGrenade';
	Template.bOverrideConcealmentRule = true;
	Template.OverrideConcealmentRule = eConceal_AlwaysEvenWithObjective;


	// Setup smoke effects
	SmokeEffect = new class'X2Effect_ApplySmokeGrenadeToWorld';

	Template.ThrownGrenadeEffects.AddItem(SmokeEffect);
	Template.ThrownGrenadeEffects.AddItem(SmokeGrenadeEffect());


	// Setup concealment effects
	TargetPropertyCondition = new class'X2Condition_UnitProperty';
	TargetPropertyCondition.ExcludeDead = true;
	TargetPropertyCondition.ExcludeFriendlyToSource = false;
	TargetPropertyCondition.ExcludeHostileToSource = true;
	TargetPropertyCondition.ExcludeCivilian = true;
	TargetPropertyCondition.FailOnNonUnits = true;

	TargetAbilityCondition = new class'X2Condition_WOTC_APA_Class_AbilityRequirement';
	TargetAbilityCondition.RequiredAbilityNames = class'X2AbilityTemplateManager'.default.AbilityProvidesStartOfMatchConcealment;
	TargetAbilityCondition.bRequireAll = false;

	StealthEffect = new class'X2Effect_Shadow';
	StealthEffect.BuildPersistentEffect(1, true, true, false, eGameRule_PlayerTurnEnd);
	StealthEffect.bRemoveWhenTargetConcealmentBroken = true;
	StealthEffect.TargetConditions.AddItem(TargetPropertyCondition);
	StealthEffect.TargetConditions.AddItem(TargetAbilityCondition);

	UnspottedEffect = new class'X2Effect_Spotted';
	UnspottedEffect.m_bBecomeUnspotted = true;
	UnspottedEffect.TargetConditions.AddItem(TargetPropertyCondition);
	UnspottedEffect.TargetConditions.AddItem(TargetAbilityCondition);

	Template.ThrownGrenadeEffects.AddItem(StealthEffect);
	Template.ThrownGrenadeEffects.AddItem(UnspottedEffect);

	Template.LaunchedGrenadeEffects = Template.ThrownGrenadeEffects;

	return Template;
}