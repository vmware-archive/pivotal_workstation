execute "Enable Assistive Devices" do
  command "echo 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled"
  user WS_USER
end
