
class X2DownloadableContentInfo_WOTC_APA_Class_Pack extends X2DownloadableContentInfo config(WOTC_APA_Class_Pack);

// Setup Structs
struct ABILITY_WEAPON_UNLOCK
{
	var name											ABILITY_NAME;
	var name											WEAPON_CATEGORY;
};

var config array<ABILITY_WEAPON_UNLOCK>					ABILITY_WEAPON_UNLOCKS;
var config array<name>									TRAINING_CENTER_XCOM_ABILITIES;

var config(ClassData) bool								DISABLE_BASE_GAME_GTS_UNLOCKS;


var config array<name>									NewAbilityAvailabilityCodes;
var localized array<string>								NewAbilityAvailabilityStrings;


// Game Setup/Load Events
//static event InstallNewCampaign(XComGameState StartState)
//{
//}

static event OnLoadedSavedGame()
{
	ManageWeaponTemplates();
}

static event OnLoadedSavedGameToStrategy()
{
	ManageWeaponTemplates();
}

static event OnPostMission()
{
	ManageWeaponTemplates();
}

// Add initial XPACK CV weapons to inventory if not already present
static function ManageWeaponTemplates()
{
	local XComGameState						NewGameState;
	local XComGameStateHistory				History;
	local XComGameState_HeadquartersXCom	XComHQ;
	local X2ItemTemplateManager				ItemTemplateMgr;
	local array<X2ItemTemplate>				CheckItemTemplates, AddItemTemplates;
	local XComGameState_Item				NewItemState;
	local int i;

	History = `XCOMHISTORY;
	ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	// Check to see if the base items are in the HQ Inventory - if any are not, add them
	CheckItemTemplates.AddItem(ItemTemplateMgr.FindItemTemplate('Bullpup_CV'));
	CheckItemTemplates.AddItem(ItemTemplateMgr.FindItemTemplate('VektorRifle_CV'));

	for (i = 0; i < CheckItemTemplates.Length; ++i)
	{
		if(CheckItemTemplates[i] != none)
		{
			`Log("WOTC_APA_Class_Pack: Checking inventory for " @ CheckItemTemplates[i].GetItemFriendlyName());
			if (!XComHQ.HasItem(CheckItemTemplates[i]))
			{
				AddItemTemplates.AddItem(CheckItemTemplates[i]);
	}	}	}

	// If any items need to be added, create a new gamestate and add them
	if (AddItemTemplates.length > 0)
	{
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("LW2 Secondaries: Updating HQ Storage");
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		NewGameState.AddStateObject(XComHQ);

		for (i = 0; i < AddItemTemplates.Length; ++i)
		{
			if(AddItemTemplates[i] != none)
			{
				`Log("WOTC_APA_Class_Pack: " @ AddItemTemplates[i].GetItemFriendlyName() @ " not found, adding to inventory");
				NewItemState = AddItemTemplates[i].CreateInstanceFromTemplate(NewGameState);
				NewGameState.AddStateObject(NewItemState);
				XComHQ.AddItemToHQInventory(NewItemState);
		}	}
			
		History.AddGameStateToHistory(NewGameState);
	}
}


// Handle any ability-changing functions that need to be done 
static function FinalizeUnitAbilitiesForInit(XComGameState_Unit UnitState, out array<AbilitySetupData> SetupData, optional XComGameState StartState, optional XComGameState_Player PlayerState, optional bool bMultiplayerDisplay)
{
	local int i, AbilityIndex;
	local AbilitySetupData SavedSetupData;
	
	// Remove Both Barrels from Marines, if applicable
	if (UnitState.GetSoldierClassTemplateName() == 'WOTC_APA_Marine' && class'X2Ability_WOTC_APA_MarineAbilitySet'.default.REMOVE_BOTH_BARRELS)
	{
		for (i = SetupData.Length - 1; i >= 0; i--)
		{
			if (SetupData[i].TemplateName == 'BothBarrels')
			{
				AbilityIndex = i;
				SetupData.Remove(i, 1);
				break;
	}	}	}

	// Ensure that Marauder and Traverse Fire properly overwrite Sustained Fire when Light'em Up is present
	if (UnitState.HasSoldierAbility('WOTC_APA_LightemUp'))
	{
		for (i = SetupData.Length - 1; i >= 0; i--)
		{
			if (SetupData[i].TemplateName == 'WOTC_APA_SustainedFire')
			{
				AbilityIndex = i;
				SetupData.Remove(i, 1);
			}

			if (SetupData[i].TemplateName == 'WOTC_APA_TraverseFire')
			{
				SavedSetupData = SetupData[i];
				SetupData.Remove(i, 1);
			}

			if (SetupData[i].TemplateName == 'WOTC_APA_Marauder')
			{
				SavedSetupData = SetupData[i];
				SetupData.Remove(i, 1);
			}
		}

		if (SavedSetupData.TemplateName != '')
		{
			SetupData.InsertItem(AbilityIndex, SavedSetupData);
	}	}
}


// Setup hooks allowing additional weapons to be equipped from abilities
static function bool CanAddItemToInventory_CH_Improved(out int bCanAddItem, const EInventorySlot Slot, const X2ItemTemplate ItemTemplate, int Quantity, XComGameState_Unit UnitState, optional XComGameState CheckGameState, optional out string DisabledReason, optional XComGameState_Item ItemState)
{
	local X2WeaponTemplate						WeaponTemplate;
	local ABILITY_WEAPON_UNLOCK					AbilityUnlock;

	WeaponTemplate = X2WeaponTemplate(ItemTemplate);
	if(CheckGameState == none)
	{
		// If DisabledReason is not blank, then this template has already been disabled by another mod, ignore.
		if (DisabledReason != "")
			return true;

		// If the template is normally allowed for this class, ignore
		if (UnitState.GetSoldierClassTemplate().IsWeaponAllowedByClass(WeaponTemplate))
			return true;

		foreach default.ABILITY_WEAPON_UNLOCKS(AbilityUnlock)
		{
			if (UnitState.HasSoldierAbility(AbilityUnlock.ABILITY_NAME))
			{
				if (WeaponTemplate.WeaponCat == AbilityUnlock.WEAPON_CATEGORY)
				{
					// Unit has an ability enabling this weapon template, allow
					DisabledReason = "";
					return false;
		}	}	}
		return true;
	}
	//return CheckGameState == none;
	return CanAddItemToInventory(bCanAddItem, Slot, ItemTemplate, Quantity, UnitState, CheckGameState);	
}

static private function bool CanAddItemToInventory(out int bCanAddItem, const EInventorySlot Slot, const X2ItemTemplate ItemTemplate, int Quantity, XComGameState_Unit UnitState, XComGameState CheckGameState)
{
	local X2WeaponTemplate						WeaponTemplate;
	local ABILITY_WEAPON_UNLOCK					AbilityUnlock;

	bCanAddItem = 0;
	WeaponTemplate = X2WeaponTemplate(ItemTemplate);
	
	// If the template is normally allowed for this class, ignore
	if (UnitState.GetSoldierClassTemplate().IsWeaponAllowedByClass(WeaponTemplate))
		return false;

	foreach default.ABILITY_WEAPON_UNLOCKS(AbilityUnlock)
	{
		if (UnitState.HasSoldierAbility(AbilityUnlock.ABILITY_NAME))
		{
			if (WeaponTemplate.WeaponCat == AbilityUnlock.WEAPON_CATEGORY)
			{
				if (UnitState.GetItemInSlot(slot, CheckGameState) == none)
				{
					// Unit has an ability enabling this weapon template, allow
					bCanAddItem = 1;
					break;
	}	}	}	}
	return bCanAddItem > 0;
}



// Setup hooks allowing additional animation sets
static function UpdateAnimations(out array<AnimSet> CustomAnimSets, XComGameState_Unit UnitState, XComUnitPawn Pawn)
{
	local X2WeaponTemplate	PrimaryWeaponTemplate;
	local Animset			AnimSetToAdd;

	if (UnitState.IsSoldier())
	{
		PrimaryWeaponTemplate = X2WeaponTemplate(UnitState.GetPrimaryWeapon().GetMyTemplate());
		if (PrimaryWeaponTemplate.WeaponCat == 'rifle' || PrimaryWeaponTemplate.WeaponCat == 'bullpup')
		{
			AnimSetToAdd = AnimSet(`CONTENT.RequestGameArchetype("PerkFX_WOTC_APA_Class_pack.Anims.AS_AssaultRifleBurstFire"));
			if (Pawn.Mesh.AnimSets.Find(AnimSetToAdd) == INDEX_NONE)
			{
				Pawn.Mesh.AnimSets.AddItem(AnimSetToAdd);
				Pawn.Mesh.UpdateAnimations();
	}	}	}
}




static event OnPostTemplatesCreated()
{
	class'WOTC_APA_Class_Pack_ModifyTemplates'.static.UpdateTemplates();
	UpdateAbilityAvailabilityStrings();
	SetupGTSUnlocks();
	PatchGremlins();
	ChainAbilityTag();
}



// Setup Display Strings for new AbilityAvailabilityCodes (the localized strings that tell you why an ability fails a condition)
static function UpdateAbilityAvailabilityStrings()
{
	local X2AbilityTemplateManager	AbilityTemplateManager;
	local int						i, idx;

	AbilityTemplateManager = X2AbilityTemplateManager(class'Engine'.static.FindClassDefaultObject("XComGame.X2AbilityTemplateManager"));

	i = AbilityTemplateManager.AbilityAvailabilityCodes.Length - AbilityTemplateManager.AbilityAvailabilityStrings.Length;

	// If there are more codes than strings, insert blank strings to bring them to equal before adding our new codes
	if (i > 0)
	{
		for (idx = 0; idx < i; idx++)
		{
			AbilityTemplateManager.AbilityAvailabilityStrings.AddItem("");
		}
	}

	// If there are more strings than codes, cut off the excess before adding our new codes
	if (i < 0)
	{
		AbilityTemplateManager.AbilityAvailabilityStrings.Length = AbilityTemplateManager.AbilityAvailabilityCodes.Length;
	}

	// Append new codes and strings to the arrays
	for (idx = 0; idx < default.NewAbilityAvailabilityCodes.Length; idx++)
	{
		AbilityTemplateManager.AbilityAvailabilityCodes.AddItem(default.NewAbilityAvailabilityCodes[idx]);
		AbilityTemplateManager.AbilityAvailabilityStrings.AddItem(default.NewAbilityAvailabilityStrings[idx]);
	}
}


// Hide Base-Game Class GTS Unlocks
static function SetupGTSUnlocks()
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
			// Add initial Proficiency Class Unlocks
			if (IsClassEnabled('WOTC_APA_Assault'))
			{
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_AssaultUnlock1');
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_AssaultUnlock2');
			}
			if (IsClassEnabled('WOTC_APA_Medic'))
			{
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_MedicUnlock1');
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_MedicUnlock2');
			}
			if (IsClassEnabled('WOTC_APA_Marine'))
			{
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_MarineUnlock1');
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_MarineUnlock2');
			}
			if (IsClassEnabled('WOTC_APA_Marksman'))
			{
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_MarksmanUnlock1');
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_MarksmanUnlock2');
			}
			if (IsClassEnabled('WOTC_APA_Sapper'))
			{
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_SapperUnlock1');
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_SapperUnlock2');
			}
			if (IsClassEnabled('WOTC_APA_Specialist'))
			{
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_SpecialistUnlock1');
				FacilityTemplate.SoldierUnlockTemplates.AddItem('WOTC_APA_SpecialistUnlock2');
			}

			if (default.DISABLE_BASE_GAME_GTS_UNLOCKS)
			{
				if (!IsClassEnabled('Ranger'))
				{
					FacilityTemplate.SoldierUnlockTemplates.RemoveItem('HuntersInstinctUnlock');
				}
				if (!IsClassEnabled('Sharpshooter'))
				{
					FacilityTemplate.SoldierUnlockTemplates.RemoveItem('HitWhereItHurtsUnlock');
				}
				if (!IsClassEnabled('Specialist'))
				{
					FacilityTemplate.SoldierUnlockTemplates.RemoveItem('CoolUnderPressureUnlock');
				}
				if (!IsClassEnabled('Grenadier'))
				{
					FacilityTemplate.SoldierUnlockTemplates.RemoveItem('BiggestBoomsUnlock');
				}
			}
}	}	}

static function bool IsClassEnabled(name ClassName)
{
	local X2SoldierClassTemplateManager		SoldierClassManager;
	local X2SoldierClassTemplate			SoldierClassTemplate;

	SoldierClassManager = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	SoldierClassTemplate = SoldierClassManager.FindSoldierClassTemplate(ClassName);

	if (SoldierClassTemplate != none && (SoldierClassTemplate.NumInForcedDeck > 0 || SoldierClassTemplate.NumInDeck > 0))
		return true;

	return false;
}

static private function PatchGremlins()
{
    local X2ItemTemplateManager				ItemMgr;
	local X2CharacterTemplateManager		CharMgr;
    local X2GremlinTemplate                 GremlinTemplate;
    local X2CharacterTemplate				CharTemplate;
    local array<X2DataTemplate>             DifficultyVariants;
    local array<X2DataTemplate>             DifficultyVariants2;
    local X2DataTemplate                    DifficultyVariant;
	local X2DataTemplate                    DifficultyVariant2;
    local X2DataTemplate                    DataTemplate;

    ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
    CharMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    foreach ItemMgr.IterateTemplates(DataTemplate)
    {   
        ItemMgr.FindDataTemplateAllDifficulties(DataTemplate.DataName, DifficultyVariants);

        foreach DifficultyVariants(DifficultyVariant)
        {
            GremlinTemplate = X2GremlinTemplate(DifficultyVariant);

            if (GremlinTemplate != none)
            {
                if (GremlinTemplate.weaponcat == 'gremlin')
				{
					//`LOG("Gremlin Animation Patch - found gremlin template" @ GremlinTemplate);
					//`LOG("Gremlin Animation Patch - now looking for" @ GremlinTemplate.CosmeticUnitTemplate);
				    CharMgr.FindDataTemplateAllDifficulties(name(GremlinTemplate.CosmeticUnitTemplate), DifficultyVariants2);

					foreach DifficultyVariants2(DifficultyVariant2)
    				{
        				CharTemplate = X2CharacterTemplate(DifficultyVariant2);
        				if (CharTemplate != none)
				        {
							//`LOG("Gremlin Animation Patch - patched animations onto" @ CharTemplate);
							CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("WotC_APA_GremlinAnims.AS_APA_Gremlin")));
				        }
				    }

				}
            }
		}
	}
}


// Handle all the many, many Localization tags!
static function ChainAbilityTag()
{
	local XComEngine						Engine;
	local X2AbilityTag_WOTC_APA_Class_Pack	NewAbilityTag;
	local X2AbilityTag						OldAbilityTag;
	local int idx;

	Engine = `XENGINE;

	OldAbilityTag = Engine.AbilityTag;
	
	NewAbilityTag = new class'X2AbilityTag_WOTC_APA_Class_Pack';
	NewAbilityTag.WrappedTag = OldAbilityTag;

	idx = Engine.LocalizeContext.LocalizeTags.Find(Engine.AbilityTag);
	Engine.AbilityTag = NewAbilityTag;
	Engine.LocalizeContext.LocalizeTags[idx] = NewAbilityTag;
}



static function bool IsModLoaded(name DLCName)
{
    local XComOnlineEventMgr    EventManager;
    local int                   Index;

    EventManager = `ONLINEEVENTMGR;

    for(Index = EventManager.GetNumDLC() - 1; Index >= 0; Index--)  
    {
        if(EventManager.GetDLCNames(Index) == DLCName)  
        {
            return true;
        }
    }
    return false;
}