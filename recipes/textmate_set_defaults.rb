execute "set save on losing focus" do
  command "defaults write ~/Library/Preferences/com.macromates.textmate OakSaveAllOnDeactivate -bool TRUE"
  user WS_USER
end
