_G = _G or getfenv()
_G.Quiver_Modules = {
	Quiver_Module_AutoShotCastbar,
	Quiver_Module_Castbar,
	Quiver_Module_RangeIndicator,
	Quiver_Module_TranqAnnouncer,
}

local savedVariablesRestore = function()
	Quiver_Store = Quiver_Store or {}
	Quiver_Store.IsLockedFrames = Quiver_Store.IsLockedFrames == true
	Quiver_Store.ModuleEnabled = Quiver_Store.ModuleEnabled or {}
	Quiver_Store.ModuleStore = Quiver_Store.ModuleStore or {}
	Quiver_Store.FrameMeta = Quiver_Store.FrameMeta or {}
	for _k, v in _G.Quiver_Modules do
		Quiver_Store.ModuleEnabled[v.Id] = Quiver_Store.ModuleEnabled[v.Id] ~= false
		Quiver_Store.ModuleStore[v.Id] = Quiver_Store.ModuleStore[v.Id] or {}
		Quiver_Store.FrameMeta[v.Id] = Quiver_Store.FrameMeta[v.Id] or {}
		v.OnRestoreSavedVariables(Quiver_Store.ModuleStore[v.Id])
		v.OnInitFrames(Quiver_Store.FrameMeta[v.Id], { IsReset=false })
	end
end
local savedVariablesPersist = function()
	for _k, v in _G.Quiver_Modules do
		Quiver_Store.ModuleStore[v.Id] = v.OnPersistSavedVariables()
		Quiver_Store.FrameMeta[v.Id] = Quiver_Store.FrameMeta[v.Id]
	end
end

local init = function()
	SLASH_QUIVER1 = "/qq"
	SLASH_QUIVER2 = "/quiver"
	_, cl = UnitClass("player")
	if cl == "HUNTER" then
		savedVariablesRestore()
		local frameConfigMenu = Quiver_ConfigMenu_Create()
		SlashCmdList["QUIVER"] = function(_args, _box) frameConfigMenu:Show() end
		for _k, v in _G.Quiver_Modules do
			if Quiver_Store.ModuleEnabled[v.Id] then v.OnEnable() end
		end
	else
		SlashCmdList["QUIVER"] = function(_args, _box)
			DEFAULT_CHAT_FRAME:AddMessage("Quiver is for hunters", 1, 0, 0)
		end
	end
end

local loadPlugins = function()
	if pfUI ~= nil and pfUI.RegisterModule ~= nil then
		pfUI:RegisterModule("quiver_turtle_trueshot", Quiver_Module_pfUITurtleTrueshot)
		pfUI:RegisterModule("quiver_turtle_mounts_auto_dismount", Quiver_Module_pfUITurtleMountsAutoDismount)
	end
end

--[[
https://wowpedia.fandom.com/wiki/AddOn_loading_process
All of these events fire on login and UI reload. The sooner we initialize, the fewer
other addons (action bars, chat windows) will be available. We don't need to clutter chat
until the user interacts with Quiver, and we don't pre-cache action bars.
Therefore, we load as soon as possible.
Quiver comes alphabetically after pfUI, so our pfUI modules work, but it's
safer to use a later event to avoid depending on arbitrary names.

ADDON_LOADED Fires each time any addon loads, but can't yet print to pfUI's chat menu
PLAYER_LOGIN Fires once, but can't yet read talent tree
PLAYER_ENTERING_WORLD fires on every load screen
SPELLS_CHANGED fires every time the spellbook changes
]]
local frame = CreateFrame("Frame", nil)
frame:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function()
	if event == "ADDON_LOADED" and arg1 == "Quiver" then init()
	elseif event == "PLAYER_LOGIN" then loadPlugins()
	elseif event == "PLAYER_LOGOUT" then savedVariablesPersist()
	elseif event == "ACTIONBAR_SLOT_CHANGED" then Quiver_Lib_ActionBar_ValidateCache(arg1)
	end
end)
