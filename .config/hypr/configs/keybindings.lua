local term = "kitty"
local firefox = "firefox"
local fileManager = "nautilus"
local menu = "rofi -show drun"
local brave = "brave"
local wallpaper = "waypaper"
local blueman = "blueman-manager"
local screenshot = "hyprshot -m window -o ~/Imágenes/screenshots"
local regionScreen = "hyprshot -m region -o ~/Imágenes/screenshots"

local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(firefox))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(brave))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(wallpaper))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(blueman))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(regionScreen))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(screenshot))

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Move focus with mainMod + l,h,j,k
hl.bind(mainMod .. " + l",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move windows with maindMod + h,l,j,k
hl.bind(mainMod .. " + l", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + h", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.window.swap({ direction = "down" }))

-- Resize windows with mainMod + and arrow keys
--[[ hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ 10, 0 }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ -10, 0 }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ 0, -10 }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ 0, 10 })) ]]

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })