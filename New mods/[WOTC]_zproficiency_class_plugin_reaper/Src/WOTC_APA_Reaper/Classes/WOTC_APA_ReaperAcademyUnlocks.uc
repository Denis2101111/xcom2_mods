
class WOTC_APA_ReaperAcademyUnlocks extends X2StrategyElement config(WOTC_APA_ReaperSkills);


var config int			CLASS_UNLOCK_1_COST;
var config int			CLASS_UNLOCK_2_COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
		
	Templates.AddItem(WOTC_APA_ReaperUnlock1());
	Templates.AddItem(WOTC_APA_ReaperUnlock2());

	return Templates;
}


static function X2SoldierAbilityUnlockTemplate WOTC_APA_ReaperUnlock1()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_ReaperUnlock1');
	
	Template.AllowedClasses.AddItem('Reaper');
	Template.AllowedClasses.AddItem('WOTC_APA_ReaperAgent');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize1";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 3;
	Template.Requirements.RequiredSoldierClass = 'Reaper';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_1_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

static function X2SoldierAbilityUnlockTemplate WOTC_APA_ReaperUnlock2()
{
	local X2SoldierAbilityUnlockTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SoldierAbilityUnlockTemplate', Template, 'WOTC_APA_ReaperUnlock2');

	Template.AllowedClasses.AddItem('Reaper');
	Template.AllowedClasses.AddItem('WOTC_APA_ReaperAgent');
	Template.strImage = "img:///UILibrary_StrategyImages.GTS.GTS_SquadSize2";

	// Requirements
	Template.Requirements.RequiredHighestSoldierRank = 6;
	Template.Requirements.RequiredSoldierClass = 'Reaper';
	Template.Requirements.RequiredSoldierRankClassCombo = true;
	Template.Requirements.bVisibleIfSoldierRankGatesNotMet = true;
	Template.Requirements.SpecialRequirementsFn = IsReaperUnlock1Purchased;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = default.CLASS_UNLOCK_2_COST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	// Ability
	Template.AbilityName = 'WOTC_APA_AcademyAbility';
	
	return Template;
}

function bool IsReaperUnlock1Purchased()
{
	local XComGameState_HeadquartersXCom XComHQ;

	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	if (XComHQ.SoldierUnlockTemplates.Find('WOTC_APA_ReaperUnlock1') != INDEX_NONE)
	{
		return true;
	}
		
	return false;
}