
class WOTC_APA_Class_AcademyUnlocks extends X2StrategyElement config(WOTC_APA_Class_Pack);


var config int			CLASS_UNLOCK_1_COST;
var config int			CLASS_UNLOCK_2_COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(WOTC_APA_AssaultUnlock1());
	Templates.AddItem(WOTC_APA_AssaultUnlock2());
	Templates.AddItem(WOTC_APA_MedicUnlock1());
	Templates.AddItem(WOTC_APA_MedicUnlock2());
	Templates.AddItem(WOTC_APA_MarineUnlock1());
	Templates.AddItem(WOTC_APA_MarineUnlock2());
	Templates.AddItem(WOTC_APA_MarksmanUnlock1());
	Templates.AddItem(WOTC_APA_MarksmanUnlock2());
	Templates.AddItem(WOTC_APA_SapperUnlock1());
	Templates.AddItem(WOTC_APA_SapperUnlock2());
	Templates.AddItem(WOTC_APA_SpecialistUnlock1());
	Templates.AddItem(WOTC_APA_SpecialistUnlock2());

	return Templates;
}

function bool IsClassEnabled(name ClassName)
{
	local X2SoldierClassTemplateManager		SoldierClassManager;
	local X2SoldierClassTemplate			SoldierClassTemplate;

	SoldierClassManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	SoldierClassTemplate = SoldierClassManager.FindSoldierClassTemplate(ClassName);

	if (SoldierClassTemplate != none && (SoldierClassTemplate.NumInForcedDeck > 0 || SoldierClassTemplate.NumInDeck > 0))
		return true;

	return false;
}



// Assault Infantry Unlocks:

static function X2SoldierAbilityUnlockTemplate WOTC_APA_AssaultUnlock1()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_AssaultUnlock1');
	
	Template.AllowedClasses.AddItem('WOTC_APA_Assault');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize1";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 3;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Assault';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsAssaultEnabled;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_1_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

static function X2SoldierAbilityUnlockTemplate WOTC_APA_AssaultUnlock2()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_AssaultUnlock2');

	Template.AllowedClasses.AddItem('WOTC_APA_Assault');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize2";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 6;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Assault';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsAssaultUnlock1Purchased;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_2_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

function bool IsAssaultEnabled()
{
	return IsClassEnabled('WOTC_APA_Assault');
}

function bool IsAssaultUnlock1Purchased()
{
	local XComGameState_HeadquartersXCom XComHQ;

	if (IsAssaultEnabled())
	{
		XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		if (XComHQ.SoldierUnlockTemplates.Find('WOTC_APA_AssaultUnlock1') != INDEX_NONE)
		{
			return true;
	}	}
		
	return false;
}



// Field Medic Unlocks

static function X2SoldierAbilityUnlockTemplate WOTC_APA_MedicUnlock1()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_MedicUnlock1');

	Template.AllowedClasses.AddItem('WOTC_APA_Medic');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize1";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 3;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Medic';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsMedicEnabled;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_1_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

static function X2SoldierAbilityUnlockTemplate WOTC_APA_MedicUnlock2()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_MedicUnlock2');

	Template.AllowedClasses.AddItem('WOTC_APA_Medic');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize2";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 6;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Medic';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsMedicUnlock1Purchased;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_2_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

function bool IsMedicEnabled()
{
	return IsClassEnabled('WOTC_APA_Medic');
}

function bool IsMedicUnlock1Purchased()
{
	local XComGameState_HeadquartersXCom XComHQ;

	if (IsMedicEnabled())
	{
		XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		if (XComHQ.SoldierUnlockTemplates.Find('WOTC_APA_MedicUnlock1') != INDEX_NONE)
		{
			return true;
	}	}
		
	return false;
}



// Marine Unlocks

static function X2SoldierAbilityUnlockTemplate WOTC_APA_MarineUnlock1()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_MarineUnlock1');

	Template.AllowedClasses.AddItem('WOTC_APA_Marine');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize1";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 3;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Marine';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsMarineEnabled;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_1_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

static function X2SoldierAbilityUnlockTemplate WOTC_APA_MarineUnlock2()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_MarineUnlock2');

	Template.AllowedClasses.AddItem('WOTC_APA_Marine');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize2";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 6;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Marine';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsMarineUnlock1Purchased;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_2_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

function bool IsMarineEnabled()
{
	return IsClassEnabled('WOTC_APA_Marine');
}

function bool IsMarineUnlock1Purchased()
{
	local XComGameState_HeadquartersXCom XComHQ;

	if (IsMarineEnabled())
	{
		XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		if (XComHQ.SoldierUnlockTemplates.Find('WOTC_APA_MarineUnlock1') != INDEX_NONE)
		{
			return true;
	}	}
		
	return false;
}



// Marksman Unlocks

static function X2SoldierAbilityUnlockTemplate WOTC_APA_MarksmanUnlock1()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_MarksmanUnlock1');

	Template.AllowedClasses.AddItem('WOTC_APA_Marksman');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize1";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 3;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Marksman';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsMarksmanEnabled;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_1_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

static function X2SoldierAbilityUnlockTemplate WOTC_APA_MarksmanUnlock2()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_MarksmanUnlock2');

	Template.AllowedClasses.AddItem('WOTC_APA_Marksman');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize2";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 6;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Marksman';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsMarksmanUnlock1Purchased;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_2_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

function bool IsMarksmanEnabled()
{
	return IsClassEnabled('WOTC_APA_Marksman');
}

function bool IsMarksmanUnlock1Purchased()
{
	local XComGameState_HeadquartersXCom XComHQ;

	if (IsMarksmanEnabled())
	{
		XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		if (XComHQ.SoldierUnlockTemplates.Find('WOTC_APA_MarksmanUnlock1') != INDEX_NONE)
		{
			return true;
	}	}
		
	return false;
}



// Sapper Unlocks

static function X2SoldierAbilityUnlockTemplate WOTC_APA_SapperUnlock1()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_SapperUnlock1');

	Template.AllowedClasses.AddItem('WOTC_APA_Sapper');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize1";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 3;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Sapper';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsSapperEnabled;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_1_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

static function X2SoldierAbilityUnlockTemplate WOTC_APA_SapperUnlock2()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_SapperUnlock2');

	Template.AllowedClasses.AddItem('WOTC_APA_Sapper');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize2";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 6;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Sapper';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsSapperUnlock1Purchased;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_2_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

function bool IsSapperEnabled()
{
	return IsClassEnabled('WOTC_APA_Sapper');
}

function bool IsSapperUnlock1Purchased()
{
	local XComGameState_HeadquartersXCom XComHQ;

	if (IsSapperEnabled())
	{
		XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		if (XComHQ.SoldierUnlockTemplates.Find('WOTC_APA_SapperUnlock1') != INDEX_NONE)
		{
			return true;
	}	}
		
	return false;
}



// Tech. Specialist Unlocks

static function X2SoldierAbilityUnlockTemplate WOTC_APA_SpecialistUnlock1()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_SpecialistUnlock1');

	Template.AllowedClasses.AddItem('WOTC_APA_Specialist');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize1";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 3;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Specialist';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsSpecialistEnabled;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_1_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

static function X2SoldierAbilityUnlockTemplate WOTC_APA_SpecialistUnlock2()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_SpecialistUnlock2');

	Template.AllowedClasses.AddItem('WOTC_APA_Specialist');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize2";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 6;
	Template.Requirements.RequiredSoldierClass = 'WOTC_APA_Specialist';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsSpecialistUnlock1Purchased;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_2_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

function bool IsSpecialistEnabled()
{
	return IsClassEnabled('WOTC_APA_Specialist');
}

function bool IsSpecialistUnlock1Purchased()
{
	local XComGameState_HeadquartersXCom XComHQ;

	if (IsSpecialistEnabled())
	{
		XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		if (XComHQ.SoldierUnlockTemplates.Find('WOTC_APA_SpecialistUnlock1') != INDEX_NONE)
		{
			return true;
	}	}
		
	return false;
}