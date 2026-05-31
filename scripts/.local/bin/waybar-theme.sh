#!/bin/bash

# Waybar config
THEME_DIR="$HOME/.config/waybar/themes/"
WAYBAR_CSS="$HOME/.config/waybar/style.css"
WAYBAR_CONFIG="$HOME/.config/waybar/config.jsonc"

# Hyprland config
H_THEME_DIR="$HOME/.config/hypr/themes/"
ACTIVE_THEME="$HOME/.config/hypr/configs/look.lua"

# Hyprlock config
HLOCK_THEME_DIR="$HOME/.config/hypr/themes/"
HLOCK_ACTIVE_THEME="$HOME/.config/hypr/hyprlock.conf"

# Kitty config
K_THEME_DIR="$HOME/.config/kitty/themes/"
K_ACTIVE_THEME="$HOME/.config/kitty/current-theme.conf"

# SwayNC
S_THEME_DIR="$HOME/.config/swaync/themes/"
S_CURRENT="$HOME/.config/swaync/current"
S_CONFIG="$HOME/.config/swaync/config.json"

# Neovim theme
NVIM_CONFIG="$HOME/.config/nvim/lua/chadrc.lua"

# Yazi
CURRENT_YAZI_THEME="$HOME/.config/yazi/theme.toml"
YAZI_THEMES="$HOME/.config/yazi/flavors/"

# Rofi
CURRENT_ROFI_THEME="$HOME/.config/rofi/config.rasi"
ROFI_THEMES_DIR="$HOME/.config/rofi/themes/"

Help() {
  echo "Simple script to change the waybar theme."
  echo 
  echo "Syntax: waybar-theme [-l|h|t]"
  echo "Options:"
  echo "l     List the availiable themes"
  echo "t     Set the theme"
  echo "h     Print this help"
  echo
}

ShowThemes() {
 ls "$THEME_DIR"
}

applyTheme () {
  src="$1"
  dst="$2"
  ln -sf "$src" "$dst"
}

gtk_theme() {
  local theme="$1"

  case "$theme" in
    gruvbox) 
      gtk_name="Colloid-Dark-Gruvbox"
    ;;
    catppuccin) 
      gtk_name="catppuccin-mocha-lavender-standard+default"
    ;;
    kanagawa)
      gtk_name="Kanagawa-Grey-Dark"
    ;;
    *)
      echo "Invalid GTK Theme"
      return 1 
      ;;
  esac
  
  gsettings set org.gnome.desktop.interface gtk-theme "$gtk_name"
}

spotify_theme() {
local theme="$1"
  case "$theme" in
    gruvbox) 
      spot_theme="gruvbox"
    ;;
    catppuccin)
      spot_theme="catppuccinMocha"
    ;;
    kanagawa) 
      spot_theme="kanagawa"
    ;;
    *) 
      echo "Error. Invalid Theme" 
      return 1
    ;;
  esac
  spicetify config color_scheme "$spot_theme"
  spicetify apply
}

btop_theme() {
  local theme="$1"

  case "$theme" in
    gruvbox)
      btop_theme="gruvbox"
      ;;
    catppuccin)
      btop_theme="catppuccin_mocha"
      ;;
    *)
      echo "btop: tema desconocido: $theme"
      return 1
      ;;
  esac

  sed -i 's/^color_theme *= *.*/color_theme = "'"$btop_theme"'"/' ~/.config/btop/btop.conf
}

theme=""

while getopts ":hlt:" option; do
  case "$option" in
    h) 
      Help
      exit;;
    l)
      ShowThemes
      exit;;
    t)
      theme="$OPTARG"
      ;;
    :)
      echo "Error: The option -$OPTARG requires an argument."
      exit 1;;
    \?)
      echo "Error: Invalid option. Use -h to see valid options."
      exit 1;;
  esac 
done

if [[ -z "$theme" ]]; then
  echo "Error: You must specify a theme with -t"
  exit 1
fi

if [[ ! -d "$THEME_DIR/$theme" ]]; then
  echo "Error: Invalid theme. Use -l to see availiable themes"
  exit 1
fi

waybar_theme="$THEME_DIR/$theme/style.css"
waybar_cfg="$THEME_DIR/$theme/config.jsonc"
hypr_theme="$H_THEME_DIR/$theme/look.lua"
hlock_theme="$HLOCK_THEME_DIR/$theme/hyprlock.conf"
kitty_theme="$K_THEME_DIR/$theme/config.conf"
swaync_theme="$S_THEME_DIR/$theme/config.json"
yazi_theme="$YAZI_THEMES/$theme/theme.toml"
rofi_theme="$ROFI_THEMES_DIR/$theme/config.rasi"
wall_dir="$H_THEME_DIR/$theme/wallpapers"

if [[ -f "$NVIM_CONFIG" ]]; then
  sed -i 's/^\([[:space:]]*theme = \)".*"/\1"'"$theme"'"/' "$NVIM_CONFIG"

  nohup nvim --headless \
    -c "lua require('base46').load_all_highlights()" \
    -c "qa" \
    >/dev/null 2>&1 &
fi

if [[ -d "$wall_dir" ]]; then
  wallpaper=$(find "$wall_dir" -type f | fzf \
  --preview 'chafa --size=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES} {}' \
  --preview-window=right:60%)

  awww img "$wallpaper" --transition-type wipe \
    --transition-duration 2.4 \
    --transition-fps 60 
fi

applyTheme "$waybar_theme" "$WAYBAR_CSS"
applyTheme "$waybar_cfg" "$WAYBAR_CONFIG"
applyTheme "$hypr_theme" "$ACTIVE_THEME"
applyTheme "$hlock_theme" "$HLOCK_ACTIVE_THEME"
applyTheme "$kitty_theme" "$K_ACTIVE_THEME"
applyTheme "$yazi_theme" "$CURRENT_YAZI_THEME"
applyTheme "$rofi_theme" "$CURRENT_ROFI_THEME"
ln -sfn "$S_THEME_DIR/$theme" "$S_CURRENT"
gtk_theme "$theme"
spotify_theme "$theme"
btop_theme "$theme"

# Reloads
sh -c 'killall waybar 2>/dev/null; waybar 2>/dev/null &'
hyprctl reload
killall -SIGUSR1 kitty
killall swaync 2>/dev/null
swaync >/dev/null 2>&1 &
