local addonName, addon = ...

EventUtil.ContinueOnAddOnLoaded(addonName, function()

    local defaults = {
        global = {
            showCompleted = false,
            showEventInfo = true,
            hideZone = {
                ['*'] = false,
            },
            showType = 1,
        },
        profile = {
            eme = {},
        },
    }
        
    addon.db = LibStub("AceDB-3.0"):New("FishingDerbyTrackerDB", defaults)
        
    local options = {
        type = "group",
        args = {
            showCompleted = {
                type = "toggle",
                name = "Show Completed",
                set = function(info, v) addon.db.global.showCompleted = v addon:UpdateFilters() end,
                get = function() return addon.db.global.showCompleted end,
            },
            showEventInfo = {
                type = "toggle",
                name = "Show Event Info",
                set = function(info, v) addon.db.global.showEventInfo = v addon:UpdateFilters() end,
                get = function() return addon.db.global.showEventInfo end,
            },
            hideZoneIsleOfDorn = {
                type = "toggle",
                name = "Hide Zone Isle of Dorn",
                set = function(info, v) addon.db.global.hideZone[1] = v addon:UpdateFilters() end,
                get = function() return addon.db.global.hideZone[1] end,
            },
            hideZoneGlimmerogg = {
                type = "toggle",
                name = "Hide Zone Ringing Deeps",
                set = function(info, v) addon.db.global.hideZone[2] = v addon:UpdateFilters() end,
                get = function() return addon.db.global.hideZone[2] end,
            },
            hideZoneNal = {
                type = "toggle",
                name = "Hide Zone Hallowfall",
                set = function(info, v) addon.db.global.hideZone[3] = v addon:UpdateFilters() end,
                get = function() return addon.db.global.hideZone[3] end,
            },
            hideZoneLoamm = {
                type = "toggle",
                name = "Hide Zone Azjkahet",
                set = function(info, v) addon.db.global.hideZone[4] = v addon:UpdateFilters() end,
                get = function() return addon.db.global.hideZone[4] end,
            },
            hideZoneAberrus = {
                type = "toggle",
                name = "Hide Zone (Any)",
                set = function(info, v) addon.db.global.hideZone[5] = v addon:UpdateFilters() end,
                get = function() return addon.db.global.hideZone[5] end,
            },
            showType = {
                type = "select",
                name = "Show when:",
                values = {
                    [1] = "Quest Active",
                    [2] = "Buff Active",
                    [3] = "Always",
                },
                set = function(info, v) addon.db.global.showType = v addon:UpdateFilters() end,
                get = function() return addon.db.global.showType end,
                style = "radio",
            },
        },
    }

    LibStub("AceConfigRegistry-3.0"):ValidateOptionsTable(options, addonName)
    LibStub("AceConfig-3.0"):RegisterOptionsTable(addonName, options, {"wherethezaralek"})
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName)
end)
