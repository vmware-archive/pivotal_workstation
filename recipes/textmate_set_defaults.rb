run_unless_marker_file_exists("textmate_set_defaults_0") do
  execute "set save on losing focus" do
    command "defaults write ~/Library/Preferences/com.macromates.textmate OakSaveAllOnDeactivate -bool TRUE"
    user WS_USER
  end
end