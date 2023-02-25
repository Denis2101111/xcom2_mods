
class X2Effect_WOTC_APA_SupportGrenadier extends X2Effect_Persistent implements(XMBEffectInterface);


function bool RapidDeploymentValidation(XComGameState_Ability AbilityState)
{
	local XComGameState_Item			SourceWeapon;
	local X2GrenadeTemplate				SourceWeaponAmmoTemplate;
	local name							AbilityName;

	SourceWeapon = AbilityState.GetSourceWeapon();
	AbilityName = AbilityState.GetMyTemplateName();
	
	if (class'X2Effect_WOTC_APA_RapidDeployment'.default.RAPID_DEPLOYMENT_VALID_ABILITIES.Find(AbilityName) != -1)
		return true;

	if (SourceWeapon == none)
		return false;

	if (class'X2Effect_WOTC_APA_RapidDeployment'.default.RAPID_DEPLOYMENT_VALID_GRENADE_ABILITIES.Find(AbilityName) != -1)
	{
		if (class'X2Effect_WOTC_APA_RapidDeployment'.default.RAPID_DEPLOYMENT_VALID_GRENADE_TYPES.Find(SourceWeapon.GetMyTemplateName()) != -1)
		{
			return true;
		}

		SourceWeaponAmmoTemplate = X2GrenadeTemplate(SourceWeapon.GetLoadedAmmoTemplate(AbilityState));
		if (SourceWeaponAmmoTemplate != none )
		{
			if (class'X2Effect_WOTC_APA_RapidDeployment'.default.RAPID_DEPLOYMENT_VALID_GRENADE_TYPES.Find(SourceWeaponAmmoTemplate.DataName) != -1)
			{
				return true;
	}	}	}

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

	if (Data.Id == 'GetConsumeAllPoints')
	{
		SourceUnit = XComGameState_Unit(Data.Data[0].o);
		AbilityState = XComGameState_Ability(Data.Data[1].o);
		EffectState = XComGameState_Effect(Data.Data[2].o);

		if (RapidDeploymentValidation(AbilityState))
		{
			Data.Data[3].i = 0;
			return true;

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
	EffectName="SupportGrenade_FreeAction"
	DuplicateResponse=eDupe_Ignore
}