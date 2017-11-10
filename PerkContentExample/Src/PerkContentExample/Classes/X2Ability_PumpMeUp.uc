class X2Ability_PumpMeUp extends X2Ability;

var name NAME_PUMPMEUP;
var string ICON_PUMPMEUP;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	Templates.AddItem(CreatePumpMeUp());
	return Templates;
}

private static function X2DataTemplate CreatePumpMeUp()
{
	local X2AbilityTemplate Template;
	local X2Effect_PumpMeUp PumpMeUpEffect;

	// general properties
	`CREATE_X2ABILITY_TEMPLATE(Template, default.NAME_PUMPMEUP);
	Template.Hostility = eHostility_Defensive;

	// hud behavior
	Template.IconImage = default.ICON_PUMPMEUP;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.bDisplayInUITacticalText = false;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY;
	Template.bLimitTargetIcons = true;

	// cost
	Template.AbilityCosts.AddItem(default.FreeActionCost);

	// targeting/hit chance
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;

	// triggering
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	
	// effects
	PumpMeUpEffect = new class'X2Effect_PumpMeUp';
	PumpMeUpEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
	PumpMeUpEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), default.ICON_PUMPMEUP, true);
	Template.AddTargetEffect(PumpMeUpEffect);
	
	// game state and visualization
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;

	return Template;
}

DefaultProperties
{
	ICON_PUMPMEUP="img:///UILibrary_PerkIcons.UIPerk_adventshieldbearer_energyshield"
	NAME_PUMPMEUP=PerkContentExample_Ability_PumpMeUp
}