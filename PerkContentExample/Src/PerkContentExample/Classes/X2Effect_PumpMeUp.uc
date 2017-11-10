class X2Effect_PumpMeUp extends X2Effect_ModifyStats;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local array<StatChange> StatChanges;
	local StatChange ShieldChange;
	local XComGameState_Unit DebugUnitState;

	ShieldChange.StatType = eStat_ShieldHP;
	ShieldChange.StatAmount = 3;
	ShieldChange.ModOp = MODOP_Addition;
	StatChanges.AddItem(ShieldChange);
	NewEffectState.StatChanges = StatChanges;

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);

	DebugUnitState = XComGameState_Unit(kNewTargetState);
	`LOG("PerkContentExample: Pump Me Up applied" @ self.EffectName @ DebugUnitState.GetFullName());
}

simulated function OnEffectRemoved(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState, bool bCleansed, XComGameState_Effect RemovedEffectState)
{
	super.OnEffectRemoved(ApplyEffectParameters, NewGameState, bCleansed, RemovedEffectState);
	`LOG("PerkContentExample: Pump Me Up removed");
}

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local XComGameState_Unit UnitState;
	local Object EffectObj;

	EventMgr = `XEVENTMGR;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	EffectObj = EffectGameState;

	EventMgr.RegisterForEvent(EffectObj, 'ShieldsExpended', EffectGameState.OnShieldsExpended, ELD_OnStateSubmitted, , UnitState);
}

DefaultProperties 
{
	DuplicateResponse=eDupe_Allow
	EffectName=PerkContentExample_Effect_PumpMeUp
}