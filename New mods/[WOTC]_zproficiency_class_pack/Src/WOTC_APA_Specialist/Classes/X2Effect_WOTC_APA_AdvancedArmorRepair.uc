class X2Effect_WOTC_APA_AdvancedArmorRepair extends X2Effect;

var int ArmorRestored;
var localized string strAdvancedArmorRepairMsg;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit		TargetUnit;
	local int						TargetArmor, TargetShredded;
	local bool						bLog;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	TargetUnit = XComGameState_Unit(kNewTargetState);
	TargetArmor = TargetUnit.GetCurrentStat(eStat_ArmorMitigation);
	TargetShredded = TargetUnit.Shredded;

	/**/`Log("WOTC_APA_Specialist - AdvancedArmorRepair: Target's (" $ TargetUnit.GetFullName() $ ") Total Armor is" @ TargetArmor, bLog);
	/**/`Log("WOTC_APA_Specialist - AdvancedArmorRepair: Target has had" @ TargetShredded @ "Armor Shredded", bLog);

	if (TargetShredded > 0)
	{
		ArmorRestored = Min(TargetShredded, class'X2Ability_WOTC_APA_SpecialistAbilitySet'.default.ADVANCED_REPAIR_ARMOR_RESTORED);
		TargetUnit.AddShreddedValue(-ArmorRestored);
		NewGameState.GetContext().PostBuildVisualizationFn.AddItem(AdvancedArmorRepair_BuildVisualization);
	}
}

// Plays a Flyover message on the Healer with the strFlyoverMessage to indicate why this heal is being modified
simulated function AdvancedArmorRepair_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateContext_Ability				AbilityContext;
	local X2AbilityTemplateManager					AbilityTemplateManager;
	local X2AbilityTemplate							AbilityTemplate;
	local int										TargetID;
	local VisualizationActionMetadata				Metadata;
	local string									WorldMessage;
	local X2Action_PlaySoundAndFlyOver				SoundAndFlyOver;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	TargetID = AbilityContext.InputContext.PrimaryTarget.ObjectID;
	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate('WOTC_APA_RemoteRepair');
	
	Metadata.StateObject_OldState = `XCOMHISTORY.GetGameStateForObjectID(TargetID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	Metadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(TargetID);
	if (Metadata.StateObject_NewState == none)
		Metadata.StateObject_NewState = Metadata.StateObject_OldState;
	Metadata.VisualizeActor = `XCOMHISTORY.GetVisualizer(TargetID);

	// Insert actual ArmorRestored value into Flyover Message
	WorldMessage = Repl(default.strAdvancedArmorRepairMsg, "<HealMod/>", ArmorRestored);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(Metadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, WorldMessage, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME, true);
}