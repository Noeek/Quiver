WoW 1.12.1 addon.
Use `/Quiver` or `/qq` to open the configuration menu.

### Features
- [Auto Shot Castbar](#auto-shot-castbar)
- [Range Indicator](#range-indicator)
- [Tranq Shot Announcer](#tranq-shot-announcer)

### Auto Shot Castbar
- Based on [HSK](https://github.com/anstellaire/HunterSwissKnife).
- Fixed a bug where moving as shot fires breaks the reload bar
- TODO customize size and vertical position

### Range Indicator
- Based on [Egnar](https://github.com/Medeah/Egnar)
- Automatically locates action bar slots
- Warns you when abilities missing from action bar
- Persists size and position

Requires some raw spellbook abilities on your action bars (not macros). Hidden action bars work fine.

### Tranq Shot Announcer
- Based on [Xtranq](https://github.com/unknauwn/XTranqManager/tree/master)

It's deliberately less customizable than Xtranq, so disable this module and run Xtranq if that bothers you. I'm open to adding tranq rotation features, but I'm not a fan of how Xtranq does it. Perhaps letting one hunter configure the rotation for all? Feel free to request features.

## Planned Features
#### Trueshot Alarm
Power Auras works great for PvE, although it's not spec aware. I don't want a constant reminder to recast Trueshot Aura while it's not talented, and Quiver already has code implemented to monitor available spells on action bars.

#### Pet Pamper
Roid can't do everything for pets. Amarra made a pet utils addon with features like auto-find food when feeding pet. This might be a deep rabbit hole.

#### Macro Replacements
Every hunter needs aspect and trap macros. Mine are copy-pasted Roid macros, but HSK implements its own version of aspect overrides.

## Localization
The 1.12 client doesn't support spell lookups by spell ID, so Quiver finds your abilities by name. I use Wowhead to find the spell names for each locale, which should theoretically work (not tested) if Quiver has a locale file matching your client.

## Contributing
Open an issue or PM me on Discord:
- Code
- Translations
- Bug reports
