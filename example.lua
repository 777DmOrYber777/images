--[[
    jade.xyz UI Library - Test Script
    Включает тестовую первую секцию (Combat), Visuals (ESP) и Settings с настройкой размера иконки.
]]

local Jade
if isfile and isfile("Jade/Library.lua") then
    Jade = loadstring(readfile("Jade/Library.lua"))()
elseif isfile and isfile("Library.lua") then
    Jade = loadstring(readfile("Library.lua"))()
elseif loadfile then
    local ok, res = pcall(loadfile, "Jade/Library.lua")
    if ok and res then Jade = res() end
end

if not Jade then
    error("Не удалось найти Jade/Library.lua в папке workspace!")
end

-- Создание главного окна
local Window = Jade:Window({
    Name = "jade.xyz | Criminality",
    Icon = "https://raw.githubusercontent.com/777DmOrYber777/images/main/jade-xyz-icon-1024-removebg-preview.png",
    IconSize = 38 -- Увеличенный размер иконки по умолчанию
})

-- 1. ПЕРВАЯ ВКЛАДКА: Combat (теперь полностью заполнена тестовыми секциями!)
local Combat = Window:Tab({Name = "Combat", Icon = "swords"})

local AimbotSub = Combat:SubTab({Name = "Aimbot", Icon = "crosshair"})
local SilentAimSub = Combat:SubTab({Name = "Silent Aim", Icon = "zap"})

-- Секции для Aimbot
local AimMain = AimbotSub:Section({Name = "Main", Side = 1})
local AimEnabled = AimMain:Toggle({Name = "Enable Aimbot", Default = true, Flag = "aim_enabled"})
AimEnabled:Keybind({Default = Enum.KeyCode.E, Flag = "aim_key"})
AimMain:Toggle({Name = "Team Check", Default = true, Flag = "aim_team"})
AimMain:Toggle({Name = "Visible Check", Default = false, Flag = "aim_vis"})
AimMain:Dropdown({Name = "Target Part", Items = {"Head", "Torso", "Random"}, Default = "Head", Flag = "aim_part"})

local AimTuning = AimbotSub:Section({Name = "Tuning", Side = 2})
AimTuning:Slider({Name = "FOV Radius", Min = 10, Max = 360, Default = 120, Suffix = "°", Flag = "aim_fov"})
AimTuning:Slider({Name = "Smoothness", Min = 1, Max = 30, Default = 8, Flag = "aim_smooth"})
AimTuning:Button({Name = "Reset to Default", Callback = function()
    Jade:Notification({Name = "Tuning", Description = "Values restored!", Icon = "check", Duration = 3})
end})

-- Секции для Silent Aim
local SilentMain = SilentAimSub:Section({Name = "Silent Targeting", Side = 1})
SilentMain:Toggle({Name = "Silent Aim", Default = false, Flag = "silent_enabled"})
SilentMain:Slider({Name = "Hit Chance", Min = 0, Max = 100, Default = 100, Suffix = "%", Flag = "silent_chance"})

local SilentMisc = SilentAimSub:Section({Name = "Prediction", Side = 2})
SilentMisc:Toggle({Name = "Velocity Prediction", Default = true, Flag = "silent_pred"})
SilentMisc:Slider({Name = "Prediction Strength", Min = 1, Max = 5, Default = 1.5, Decimals = 0.1, Flag = "silent_strength"})


-- 2. ВТОРАЯ ВКЛАДКА: Visuals
local Visuals = Window:Tab({Name = "Visuals", Icon = "eye"})
local Esp = Visuals:SubTab({Name = "ESP", Icon = "scan-eye"})

local EspMain = Esp:Section({Name = "Players", Side = 1})
EspMain:Toggle({Name = "Enable ESP", Default = true, Flag = "esp_enabled"})
EspMain:Toggle({Name = "Boxes", Default = true, Flag = "esp_box"})
EspMain:Toggle({Name = "Names", Default = true, Flag = "esp_names"})
EspMain:Toggle({Name = "Health Bar", Default = true, Flag = "esp_health"})
EspMain:Toggle({Name = "Tracers", Default = false, Flag = "esp_tracers"})
EspMain:Slider({Name = "Distance", Min = 100, Max = 4000, Default = 1500, Suffix = "m", Flag = "esp_dist"})
EspMain:Dropdown({Name = "Box Fill", Items = {"None", "Full", "Gradient"}, Default = "None", Flag = "esp_fill"})

local ChamsSection = Esp:Section({Name = "Chams & Visuals", Side = 2})
ChamsSection:Toggle({Name = "Arms Chams", Default = false, Flag = "arms_chams"})
ChamsSection:Dropdown({Name = "Arms Mode", Items = {"Outline", "Glow", "Solid"}, Default = "Outline", Flag = "arms_mode"})
ChamsSection:Toggle({Name = "Gun Chams", Default = false, Flag = "gun_chams"})


-- 3. ТРЕТЬЯ ВКЛАДКА: Settings
local Settings = Window:Tab({Name = "Settings", Icon = "settings"})

local ConfigSub = Settings:SubTab({Name = "Config", Icon = "save"})
ConfigSub:ThemeConfig({})

local NotifSection = ConfigSub:Section({Name = "Notification Test", Side = 1})
NotifSection:Button({
    Name = "Send Test Notification",
    Callback = function()
        Jade:Notification({
            Title = "jade.xyz",
            Description = "Theme: " .. (Jade.CurrentThemeName or "Pitch Black"),
            Icon = "bell",
            Duration = 3.5
        })
    end
})

NotifSection:Button({
    Name = "Compact Notification (Single Line)",
    Callback = function()
        Jade:Notification({
            Title = "Silent Aim: Enabled",
            Icon = "check",
            Duration = 3
        })
    end
})


-- Watermark с логотипом
Window:Watermark({
    Name = "jade.xyz",
    Icon = "https://raw.githubusercontent.com/777DmOrYber777/images/main/jade-xyz-icon-1024-removebg-preview.png"
})

-- Уведомление при старте
Jade:Notification({
    Name = "jade.xyz",
    Description = "Loaded successfully! Enjoy.",
    Icon = "check",
    Duration = 5
})
