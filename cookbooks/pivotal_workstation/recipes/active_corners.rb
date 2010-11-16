active_corner_value_to_int = {
  :all_windows => 2,
  :dashboard => 7
}

corners = {
  :tl => :all_windows,
  :tr => :dashboard
}

corners.each do |corner, value|
  execute "#{corner} right #{value}" do
    command "defaults write com.apple.dock wvous-#{corner}-corner -int #{active_corner_value_to_int[value]}"
    user WS_USER
  end
  execute "#{corner} modifier" do
    command "defaults write com.apple.dock wvous-#{corner}-modifier -int 0"
    user WS_USER
  end
end

execute "relaunch dock" do
  command "killall Dock"
end