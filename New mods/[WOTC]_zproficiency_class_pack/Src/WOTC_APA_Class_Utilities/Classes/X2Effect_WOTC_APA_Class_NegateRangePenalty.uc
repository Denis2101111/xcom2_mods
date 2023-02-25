class X2Effect_WOTC_APA_Class_NegateRangePenalty extends X2Effect_Persistent;

var float				RangePenaltyPercentNegated;
var bool				bLimitToSquadSightRange;
var bool				bSkipWeaponRangeModifier;

var array<name>			RequiredEffectNames;
var array<name>			ExcludedAbilityNames;


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local XComGameState_Item	SourceWeapon;
	local X2WeaponTemplate		WeaponTemplate;
	local ShotModifierInfo		ShotInfo;
    local int					i, Tiles, NormalRange, SquadsightMod;
	local float					WeaponModifier, SquadsightModifier;
	local array<int>			RangeTable;
	local bool					bLog, bEffectCheck;

	bLog = class'WOTC_APA_LogToggle'.default.bDEBUG_LOGGING;

	if(AbilityState != none)
	{
		if (ExcludedAbilityNames.Find(AbilityState.GetMyTemplateName()) != Index_None)
		{
			// Excluding Ability used, don't apply effect
			return;
		}

		SourceWeapon = AbilityState.GetSourceWeapon();    
		if (SourceWeapon != none)
		{
			if (RequiredEffectNames.length == 0)
			{
				bEffectCheck = true;
			}
			else
			{
				for (i = 0; i < RequiredEffectNames.Length; ++i)
				{
					if (Attacker.AffectedByEffectNames.Find(RequiredEffectNames[i]) != Index_None)
					{
						bEffectCheck = true;
						break;
			}	}	}

			if (bEffectCheck)
			{
				WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
				RangeTable = WeaponTemplate.RangeAccuracy;
				Tiles = Attacker.TileDistanceBetween(Target);
				NormalRange = `UNITSTOTILES(`METERSTOUNITS(Attacker.GetVisibilityRadius()));

				`LOG("Reduce Range Penalties:" @ Attacker.GetFullName() @ "is attacking" @ Target.GetFullName(), bLog);
				`LOG("Reduce Range Penalties: Distance between Attacker and Target:" @ Tiles @ "Normal visibility range for Attacker is:" @ NormalRange, bLog);

				if (Tiles >= NormalRange || !bLimitToSquadSightRange)
				{
					if (!bSkipWeaponRangeModifier)
					{
						if (Tiles < RangeTable.Length)
						{
							if (RangeTable[Tiles] < 0)
							{
								WeaponModifier = -RangeTable[Tiles];
								`LOG("Reduce Range Penalties: Penalty from weapon range table is:" @ -WeaponModifier, bLog);

						}	}
						else // Use last value
						{
							if (RangeTable[RangeTable.Length - 1] < 0)
							{
								WeaponModifier = -RangeTable[RangeTable.Length - 1];
								`LOG("Reduce Range Penalties: Penalty from weapon range table is:" @ -WeaponModifier, bLog);
					}	}	}


					// Adjust tiles down to Squadsight range
					Tiles -= NormalRange;
					SquadsightMod = -class'X2AbilityToHitCalc_StandardAim'.default.SQUADSIGHT_DISTANCE_MOD;
					if (Tiles >= 0)
					{
						SquadsightModifier = MAX(SquadsightMod * Tiles, SquadsightMod);
						`LOG("Reduce Range Penalties: Attack is" @ Tiles @ "outside normal visibilty range (Squadsight)", bLog);
						`LOG("Reduce Range Penalties: Penalty from squadsight is" @ -SquadsightModifier, bLog);
					}

					WeaponModifier += SquadsightModifier;
			
					`LOG("Reduce Range Penalties: Total aim penalty due to range is:" @ -WeaponModifier, bLog);
					`LOG("Reduce Range Penalties: Penalty negated multiplier is:" @ RangePenaltyPercentNegated, bLog);

					WeaponModifier *= RangePenaltyPercentNegated;
				
					if (int(WeaponModifier) != 0)
					{
						ShotInfo.Value = int(WeaponModifier);
						ShotInfo.ModType = eHit_Success;
						ShotInfo.Reason = FriendlyName;
						ShotModifiers.AddItem(ShotInfo);
}	}	}	}	}	}