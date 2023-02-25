
class UIStrategyScreenListener_WOTC_APA_ReaperAcademyUnlocks extends UIStrategyScreenListener;

event OnInit(UIScreen Screen)
{
    if (IsInStrategy())
    {
		// Try to add the GTS perk
		AddSoldierUnlockTemplate('OfficerTrainingSchool', 'WOTC_APA_ReaperUnlock1');
		AddSoldierUnlockTemplate('OfficerTrainingSchool', 'WOTC_APA_ReaperUnlock2');
	}
}


static function AddSoldierUnlockTemplate(name FacilityName, name UnlockGTSName)
{
	local X2FacilityTemplate FacilityTemplate;

	// Find the GTS facility template
	FacilityTemplate = X2FacilityTemplate(class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().FindStrategyElementTemplate(FacilityName));
	if (FacilityTemplate == none)
		return;

	if (FacilityTemplate.SoldierUnlockTemplates.Find(UnlockGTSName) != INDEX_NONE)
		return;

	// Update the GTS template with the specified soldier unlock
	FacilityTemplate.SoldierUnlockTemplates.AddItem(UnlockGTSName);
}