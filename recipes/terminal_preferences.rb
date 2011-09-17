execute "set terminal color scheme" do
  command "defaults write com.apple.Terminal 'Startup Window Settings' -string #{node['terminal']['color_scheme']}"
  user WS_USER
end
