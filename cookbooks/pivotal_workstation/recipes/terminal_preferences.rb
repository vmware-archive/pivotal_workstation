execute "set terminal color scheme" do
  command "defaults write com.apple.Terminal 'Default Window Settings' -string Homebrew"
  user WS_USER
end

execute "set terminal color scheme" do
  command "defaults write com.apple.Terminal 'Startup Window Settings' -string Homebrew"
  user WS_USER
end