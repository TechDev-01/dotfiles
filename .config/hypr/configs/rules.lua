-- Layer rules
hl.layer_rule({
  match = { 
    class = "swaync-control-center"
  },
  blur = true
})
hl.layer_rule({
  match = { 
    class = "swaync-control-center"
  },
  ignore_alpha = 0.5
})
hl.layer_rule({
  match = { 
    class = "swaync-notification-window"
  },
  blur = true
})
hl.layer_rule({
  match = { 
    class = "swaync-notification-window"
  },
  ignore_alpha = 0.5
})

-- Window Rules 
hl.window_rule({
  match = { 
    class = "kitty"
  },
  opacity = "0.95 0.90"
})
hl.window_rule({
  match = { 
    class = "waypaper"
  },
  float = true
})
hl.window_rule({
  match = { 
    class = "org.gnome.Nautilus"
  },
  float = true
})
hl.window_rule({
  match = { 
    class = "blueman-manager"
  },
  float = true
})
