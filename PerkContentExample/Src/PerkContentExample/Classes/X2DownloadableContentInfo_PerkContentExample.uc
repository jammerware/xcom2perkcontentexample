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
    local XComContentManager Content;

    CharacterTemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

    // this is just demoey code that adds our fictional ability to every soldier class so you can see the VFX in action
    foreach CharacterTemplateManager.IterateTemplates(Template, None)
    {
        CharacterTemplateManager.FindDataTemplateAllDifficulties(Template.DataName, DataTemplates);
        foreach DataTemplates(TemplateIterator)
        {
            CharTemplate = X2CharacterTemplate(TemplateIterator);

			if (CharTemplate.bIsSoldier)
			{
				CharTemplate.Abilities.AddItem(class'X2Ability_PumpMeUp'.default.NAME_PUMPMEUP);
                `LOG("PerkContentExample: added pump me up to template" @ CharTemplate.name);
			}
        }
    }

    // THIS is the important part - we need to force the content manager to build its perk cache and
    // then manually load our modded ones
    // 
    // note that if your mod requires the community highlander, it has a helper that you can use to do this for you.
    // see https://github.com/X2CommunityCore/X2WOTCCommunityHighlander/issues/123
    Content = `CONTENT;
    Content.BuildPerkPackageCache();
    Content.CachePerkContent(class'X2Ability_PumpMeUp'.default.NAME_PUMPMEUP);
}