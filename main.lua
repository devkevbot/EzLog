local addonName = "EzLog"
local f = CreateFrame("Frame")

function f:OnEvent(event, ...)
  self[event](self, event, ...)
end

local function msgWithAddonName(msg)
  return string.format("%s: %s", addonName, msg)
end

function f:PLAYER_ENTERING_WORLD(event, ...)
  local inInstance, instanceType = IsInInstance()
  if (not inInstance or instanceType ~= 'raid') then
    return
  end

  local trackingRaidMapIDs = {
    [2522] = true -- Vault of the Incarnates (Dragonflight)
  }

  local name, type, difficultyIndex, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapId = GetInstanceInfo()
  if (not trackingRaidMapIDs[instanceMapId]) then
    return
  end

  if (LoggingCombat()) then
    print(msgWithAddonName("combat logging already started"));
  else
    print(msgWithAddonName("starting combat logging"));
    LoggingCombat(1);
  end
end

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", f.OnEvent)
