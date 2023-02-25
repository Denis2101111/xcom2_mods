
class X2Effect_WOTC_APA_PrepForEntry extends X2Effect_Persistent implements(XMBEffectInterface) config (WOTC_APA_AssaultSkills);

var config array<name> PREP_FOR_ENTRY_VALID_ABILITIES;


function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	
	if (kAbility == none)
		return false;

	if (PrepForEntryValidation(kAbility))
	{
		EffectState.RemoveEffect(NewGameState, NewGameState);
		return false;
	}
	return false;
}


function bool PrepForEntryValidation(XComGameState_Ability AbilityState)
{
	local XComGameState_Item			SourceWeapon;
	local X2WeaponTemplate				SourceWeaponAmmoTemplate;
	local name							AbilityName;

	SourceWeapon = AbilityState.GetSourceWeapon();
	AbilityName = AbilityState.GetMyTemplateName();

	if (default.PREP_FOR_ENTRY_VALID_ABILITIES.Find(AbilityName) != -1)
		return true;

	return false;
}


// XMB Action Point Interface


function bool GetTagValue(name Tag, XComGameState_Ability AbilityState, out string TagValue);
function bool GetExtModifiers(name Type, XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, optional ShotBreakdown ShotBreakdown, optional out array<ShotModifierInfo> ShotModifiers);

function bool GetExtValue(LWTuple Data)
{
	local XComGameState_Unit			SourceUnit;
	local XComGameState_Ability			AbilityState;
	local XComGameState_Effect			EffectState;
	local X2AbilityCost_ActionPoints	ActionPointCost;
	local X2AbilityCost					Cost;
	local name							Type;

	if (Data.Id == 'GetActionPointCost' || Data.Id == 'GetConsumeAllPoints')
	{
		SourceUnit = XComGameState_Unit(Data.Data[0].o);
		AbilityState = XComGameState_Ability(Data.Data[1].o);
		EffectState = XComGameState_Effect(Data.Data[2].o);

		if (PrepForEntryValidation(AbilityState))
		{
			foreach AbilityState.GetMyTemplate().AbilityCosts(Cost)
			{
				ActionPointCost = X2AbilityCost_ActionPoints(Cost);
				if (ActionPointCost != none)
				{
					foreach SourceUnit.ActionPoints(Type)
					{
						if (ActionPointCost.AllowedTypes.Find(Type) != -1)
						{
							Data.Data[3].i = 0;
							return true;
	}	}	}	}	}	}	

	return false;
}

DefaultProperties
{
	DuplicateResponse=eDupe_Ignore
}