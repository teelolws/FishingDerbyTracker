local addonName, addon = ...

-- Set the base time for Saturday 00:00 UTC
local timeBase = 1725645600 -- Sat Sep 7 2024 00:00:00 UTC

-- Check the region and adjust the timeBase accordingly
local region = GetCurrentRegion()
if region == 3 then
    -- US region (+7 hours UTC)
    timeBase = timeBase + 7 * 3600
elseif region == 2 then
    -- KR or TW region (-8 hours UTC)
    timeBase = timeBase - 8 * 3600
end




local function formatName(text, completed)
    if completed then
        return "|cFF00FF00"..text.."|r"
    else
        return text
    end
end

local function formatHeader(text)
    return "|cFFFFA500"..text.."|r"
end

local function formatInfo(text)
    return " |cFFDCDCDC"..text.."|r"
end

function addon:UpdateFilters()
    local text = "" 
    local settings = addon.db.global

    for zoneIndex, zoneData in ipairs(addon.zones) do
        if not addon.db.global.hideZone[zoneIndex] then
            local zoneID = zoneData[1]
            local headerAdded
            for i = 2, #zoneData do
                local item = zoneData[i]
                local name, questID, info = item.name, item.quests[1], item.info
                local completed = C_QuestLog.IsQuestFlaggedCompleted(questID)
                if settings.showCompleted or (not completed) then
                    if not headerAdded then
                        headerAdded = true
                        text = text..formatHeader(C_Map.GetMapInfo(zoneID).name).."\n"
                    end
                    text = text..formatName(name, completed)
                    if settings.showEventInfo and info then
                        text = text..formatInfo(info)
                    end
                    text = text.."\n"
                end
            end
        end
    end
    
    addon:UpdateEventUI(text)
end
