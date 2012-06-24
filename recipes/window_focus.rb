execute "turn on focus-follows-window for browsers, etc.." do
  command "defaults write org.x.X11 wm_ffm -bool true"
  user WS_USER
end
