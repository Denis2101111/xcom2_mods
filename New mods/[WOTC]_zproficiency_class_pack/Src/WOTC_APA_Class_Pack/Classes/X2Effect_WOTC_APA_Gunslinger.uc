
class X2Effect_WOTC_APA_Gunslinger extends X2Effect_Persistent implements(XMBEffectInterface);


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

	if (Data.Id == 'GetActionPointCost')
	{
		SourceUnit = XComGameState_Unit(Data.Data[0].o);
		AbilityState = XComGameState_Ability(Data.Data[1].o);
		EffectState = XComGameState_Effect(Data.Data[2].o);

		if (AbilityState.GetMyTemplateName() == 'PistolOverwatch')
		{
			if (SourceUnit.ActionPoints.Find(class'X2CharacterTemplateManager'.default.MoveActionPoint) != -1 || SourceUnit.ActionPoints.Find(class'X2CharacterTemplateManager'.default.MomentumActionPoint) != -1)
			{
				Data.Data[3].i = 0;
				return true;
	}	}	}

	return false;
}



DefaultProperties
{
	DuplicateResponse=eDupe_Ignore
}