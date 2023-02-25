
class X2AbilityMultiTarget_WOTC_APA_CQBRadius extends X2AbilityMultiTarget_Radius;


function AddUnitValueBonusRadius(name AbilityName, float BonusRadius)
{
	local XComGameState_Unit		UnitState;
	local UnitValue					UnitValue;
	local AbilityGrantedBonusRadius Bonus;

	//UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(self.OwnerStateObject.ObjectID));
	Bonus.RequiredAbility = AbilityName;
	Bonus.fBonusRadius = BonusRadius;
	AbilityBonusRadii.AddItem(Bonus);
}