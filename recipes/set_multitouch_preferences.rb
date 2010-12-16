execute "allow clicking by touch" do
  command "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking 1"
  user WS_USER
end

execute "allow dragging by touch" do
  command "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging 1"
  user WS_USER
end