local addonName, addon = ...

local libEME = LibStub:GetLibrary("EditModeExpanded-1.0")

local validZones = {
    [2339] = true,
    [2214] = true,
    [2215] = true,
    [2248] = true,
    [2255] = true,
}

local questIDs = {
    [82778] = true,
    [83529] = true,
    [83530] = true,
    [83531] = true,
    [83532] = true,
}

-- https://www.wowhead.com/spell=456024/derby-dasher
local spellID = 456024

local function isOnQuest()
    for questID in pairs(questIDs) do
        if C_QuestLog.IsOnQuest(questID) or C_UnitAuras.GetPlayerAuraBySpellID(spellID) then
            return true
        end
    end
    return false
end

local listener = CreateFrame("Frame")
listener:RegisterEvent("PLAYER_ENTERING_WORLD")
listener:RegisterEvent("ZONE_CHANGED_NEW_AREA")
listener:RegisterEvent("QUEST_ACCEPTED")
listener:RegisterEvent("QUEST_LOG_UPDATE")
listener:RegisterEvent("ADDON_LOADED")
listener:SetScript("OnEvent", function(self, event, ...)
    if (event == "PLAYER_ENTERING_WORLD") or (event == "ZONE_CHANGED_NEW_AREA") or (event == "QUEST_ACCEPTED") or (event == "QUEST_LOG_UPDATE") then
        local mapID = C_Map.GetBestMapForUnit("player")
        if not validZones[mapID] then addon:HideUI() return end
        if not isOnQuest() then addon:HideUI() return end
        addon:UpdateFilters()
    elseif event == "ADDON_LOADED" then
        local text = ...
        if text == addonName then
            listener:UnregisterEvent("ADDON_LOADED")
            libEME:RegisterFrame(FishingDerbyTrackerUI, "Fishing Derby", addon.db.profile.eme)
            libEME:RegisterResizable(FishingDerbyTrackerUI)
            libEME:HideByDefault(FishingDerbyTrackerUI)
            libEME:RegisterHideable(FishingDerbyTrackerUI)
            libEME:RegisterToggleInCombat(FishingDerbyTrackerUI)
        end
    end
end)
