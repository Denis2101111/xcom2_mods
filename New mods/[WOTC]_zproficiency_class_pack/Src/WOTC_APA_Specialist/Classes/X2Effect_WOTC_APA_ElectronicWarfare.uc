
class X2Effect_WOTC_APA_ElectronicWarfare extends X2Effect_Persistent implements(XMBEffectInterface);

var name FreeFailsafeActivationsUnitName;

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local UnitValue					UnitValue;

	if(kAbility == none)
		return false;
	
	`LOG("ElectronicWarfare - PostAbilityCostPaid" @ kAbility.GetMyTemplateName());

	if (kAbility.GetMyTemplateName() != 'WOTC_APA_Failsafe')
		return false;

	SourceUnit.GetUnitValue(FreeFailsafeActivationsUnitName, UnitValue);	
	if (UnitValue.fValue < 1)
		return false;

	UnitValue.fValue = UnitValue.fValue - 1;
	SourceUnit.SetUnitFloatValue(FreeFailsafeActivationsUnitName, UnitValue.fValue, eCleanup_BeginTactical);
	
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
	local UnitValue						UnitValue;
	local X2AbilityCost_ActionPoints	ActionPointCost;
	local X2AbilityCost					Cost;
	local name							Type;

	`LOG("ElectronicWarfare - GetExtValue");

	if (Data.Id == 'GetActionPointCost')
	{
		SourceUnit = XComGameState_Unit(Data.Data[0].o);
		AbilityState = XComGameState_Ability(Data.Data[1].o);
		EffectState = XComGameState_Effect(Data.Data[2].o);

		`LOG("Checking for cost of" @ AbilityState.GetMyTemplateName());

		if (AbilityState.GetMyTemplateName() == 'WOTC_APA_Failsafe')
		{
			SourceUnit.GetUnitValue(FreeFailsafeActivationsUnitName, UnitValue);
			if (UnitValue.fValue >= 1)
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
	}	}	}	}	}	}	}

	return false;
}

DefaultProperties
{
	FreeFailsafeActivationsUnitName="WOTC_APA_FreeFailsafeActivations"
	DuplicateResponse=eDupe_Ignore
}