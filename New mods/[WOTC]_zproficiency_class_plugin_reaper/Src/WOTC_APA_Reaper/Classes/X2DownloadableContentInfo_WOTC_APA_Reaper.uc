
class X2DownloadableContentInfo_WOTC_APA_Reaper extends X2DownloadableContentInfo;


static event OnPostTemplatesCreated()
{
	AddPistolRuptureEffects();
	AddBanishCooldown();
	HideReaperAcademyUnlock();
	ChainAbilityTag();
}


// Add a rupture effect to valid secondary attack abilities
static function AddPistolRuptureEffects()
{
	local X2AbilityTemplateManager							AbilityTemplateMgr;
	local array<X2AbilityTemplate>							AbilityTemplateArray;
	local X2AbilityTemplate									AbilityTemplate;
	local X2Effect_ApplyWeaponDamage						RuptureEffect;
	local X2Condition_WOTC_APA_EffectRequirement			EffectCondition;
	
	EffectCondition = new class'X2Condition_WOTC_APA_EffectRequirement';
	EffectCondition.RequiredEffectNames.AddItem('WOTC_APA_Undermine');
	EffectCondition.bCheckSourceUnit = true;

	RuptureEffect = new class'X2Effect_ApplyWeaponDamage';
	RuptureEffect.bIgnoreBaseDamage = true;
	RuptureEffect.EffectDamageValue.Rupture = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.UNDERMINE_RUPTURE_DAMAGE;
	RuptureEffect.TargetConditions.AddItem(EffectCondition);

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('FanFire', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{		
		AbilityTemplate.AddTargetEffect(RuptureEffect);
		AbilityTemplate.AddMultiTargetEffect(RuptureEffect);
	}

	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('Faceoff', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{		
		AbilityTemplate.AddTargetEffect(RuptureEffect);
		AbilityTemplate.AddMultiTargetEffect(RuptureEffect);
	}

	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('Shadowfall', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{		
		AbilityTemplate.AddTargetEffect(RuptureEffect);
	}

	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('WOTC_APA_StunShot', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{		
		AbilityTemplate.AddTargetEffect(RuptureEffect);
	}

	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('PistolStandardShot', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{		
		AbilityTemplate.AddTargetEffect(RuptureEffect);
	}

	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('PistolOverwatchShot', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{		
		AbilityTemplate.AddTargetEffect(RuptureEffect);
	}

	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('PistolReturnFire', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{		
		AbilityTemplate.AddTargetEffect(RuptureEffect);
	}
}


// Add a cooldown to Banish for use with Annihilation's extra charge(s)
static function AddBanishCooldown()
{
	local X2AbilityTemplateManager							AbilityTemplateMgr;
	local array<X2AbilityTemplate>							AbilityTemplateArray;
	local X2AbilityTemplate									AbilityTemplate;
	local X2AbilityCooldown									Cooldown;
	
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = class'X2Ability_WOTC_APA_ReaperAbilitySet'.default.ANNIHILATION_BANISH_COOLDOWN;

	AbilityTemplateMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplateMgr.FindAbilityTemplateAllDifficulties('SoulReaper', AbilityTemplateArray);
	foreach AbilityTemplateArray(AbilityTemplate)
	{		
		AbilityTemplate.AbilityCooldown = Cooldown;
	}
}


// Hide Reaper's Infiltration GTS Unlock
static function HideReaperAcademyUnlock()
{
	local X2StrategyElementTemplateManager		TemplateManager;
	local X2FacilityTemplate					FacilityTemplate;
    local X2SoldierAbilityUnlockTemplate		SoldierAbilityUnlockTemplate;
    local array<X2DataTemplate>					DataTemplates;
    local X2DataTemplate						DiffTemplate;

    TemplateManager = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	TemplateManager.FindDataTemplateAllDifficulties('OfficerTrainingSchool', DataTemplates);
	foreach DataTemplates(DiffTemplate)
	{
		FacilityTemplate = X2FacilityTemplate(DiffTemplate);
		if (FacilityTemplate != none)
		{
			FacilityTemplate.SoldierUnlockTemplates.RemoveItem('InfiltrationUnlock');
}	}	}



// Handle all the localization tags
static function ChainAbilityTag()
{
	local XComEngine						Engine;
	local X2AbilityTag_WOTC_APA_Reaper		NewAbilityTag;
	local X2AbilityTag						OldAbilityTag;
	local int idx;
	
	Engine = `XENGINE;
	
	OldAbilityTag = Engine.AbilityTag;
	
	NewAbilityTag = new class'X2AbilityTag_WOTC_APA_Reaper';
	NewAbilityTag.WrappedTag = OldAbilityTag;
	
	idx = Engine.LocalizeContext.LocalizeTags.Find(Engine.AbilityTag);
	Engine.AbilityTag = NewAbilityTag;
	Engine.LocalizeContext.LocalizeTags[idx] = NewAbilityTag;
}