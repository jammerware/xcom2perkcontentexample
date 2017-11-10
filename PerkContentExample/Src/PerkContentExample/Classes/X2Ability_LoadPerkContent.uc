class X2Ability_LoadPerkContent extends X2Ability;

var name NAME_LOADPERKCONTENT;
var string ICON_LOADPERKCONTENT;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	Templates.AddItem(CreatePumpMeUp());
	return Templates;
}

private static function X2DataTemplate CreatePumpMeUp()
{
	local X2AbilityTemplate Template;
	local X2Effect_LoadPerkContent LoadPerkContentEffect;

	// general properties
	`CREATE_X2ABILITY_TEMPLATE(Template, default.NAME_LOADPERKCONTENT);
	Template.Hostility = eHostility_Neutral;
    Template.bIsPassive = true;

	// hud behavior
	Template.IconImage = default.ICON_LOADPERKCONTENT;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.bDisplayInUITacticalText = false;

	// targeting/hit chance
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;

	// triggering
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	
	// effects
	LoadPerkContentEffect = new class'X2Effect_LoadPerkContent';
	LoadPerkContentEffect.BuildPersistentEffect(1, true);
	LoadPerkContentEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), default.ICON_LOADPERKCONTENT, true);
	Template.AddTargetEffect(LoadPerkContentEffect);
	
	// game state and visualization
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bSkipFireAction = true;
	Template.bShowActivation = false;

	return Template;
}

DefaultProperties
{
	ICON_LOADPERKCONTENT="img:///UILibrary_PerkIcons.UIPerk_equip"
	NAME_LOADPERKCONTENT=PerkContentExample_Ability_LoadPerkContent
}