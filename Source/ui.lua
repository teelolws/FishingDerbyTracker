local addonName, addon = ...

local libEME = LibStub:GetLibrary("EditModeExpanded-1.0")

addon.ui = CreateFrame("Frame", "FishingDerbyTrackerUI")
local frame = addon.ui

frame:SetSize(200,300)
frame:SetPoint("LEFT", nil, "LEFT")

frame.eventText = frame:CreateFontString(nil, "OVERLAY", "GameTooltipTextSmall")
frame.eventText:SetPoint("TOPLEFT", frame, "TOPLEFT")
frame.eventText:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, -100)
frame.eventText:SetJustifyV("TOP")

function addon:UpdateEventUI(text)
    frame.eventText:SetText(text)
    if libEME:IsFrameMarkedHidden(frame) then return end
    frame:Show()
end

function addon:HideUI()
    frame:Hide()
end
