class X2DownloadableContentInfo_PerkContentExample extends X2DownloadableContentInfo;

/// <summary>
/// Called when all base game templates are loaded
/// </summary>
static event OnPostTemplatesCreated()
{
    local X2CharacterTemplateManager CharacterTemplateManager;
    local X2CharacterTemplate CharTemplate;
    local array<X2DataTemplate> DataTemplates;
    local X2DataTemplate Template, TemplateIterator;

    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    foreach CharacterTemplateManager.IterateTemplates(Template, None)
    {
        CharacterTemplateManager.FindDataTemplateAllDifficulties(Template.DataName, DataTemplates);
        foreach DataTemplates(TemplateIterator)
        {
            CharTemplate = X2CharacterTemplate(TemplateIterator);

			if (CharTemplate.bIsSoldier)
			{
                CharTemplate.Abilities.AddItem(class'X2Ability_LoadPerkContent'.default.NAME_LOADPERKCONTENT);
                `LOG("PerkContentExample: added Load Perk Content to template" @ CharTemplate.name);
				CharTemplate.Abilities.AddItem(class'X2Ability_PumpMeUp'.default.NAME_PUMPMEUP);
                `LOG("PerkContentExample: added pump me up to template" @ CharTemplate.name);
			}
        }
    }
}

exec function PCE_ToggleCustomDebugOutput() {
    class'UIDebugStateMachines'.static.GetThisScreen().ToggleVisible();
}
 
exec function PCE_PrintPerkContentsForXCom() {
    class'UIDebugStateMachines'.static.PrintOutPerkContentsForXComUnits();
}
 
exec function PCE_PrintLoadedPerkContents() {
    class'UIDebugStateMachines'.static.PrintOutLoadedPerkContents();
}
 
exec function PCE_TryForceAppendAbilityPerks(name AbilityName) {
    class'UIDebugStateMachines'.static.TryForceAppendAbilityPerks(AbilityName);
}
 
exec function PCE_TryForceCachePerkContent(name AbilityName) {
    class'UIDebugStateMachines'.static.TryForceCachePerkContent(AbilityName);
}
 
exec function PCE_TryForceBuildPerkContentCache() {
    class'UIDebugStateMachines'.static.TryForceBuildPerkContentCache();
}
 
exec function PCE_ForceLoadPerkOnToUnit(name AbilityName) {
    class'UIDebugStateMachines'.static.TryForceBuildPerkContentCache();
    class'UIDebugStateMachines'.static.TryForceCachePerkContent(AbilityName);
    class'UIDebugStateMachines'.static.TryForceAppendAbilityPerks(AbilityName);
}