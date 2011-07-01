run_unless_marker_file_exists("enable_screen_sharing") do
  # using a marker file because this command resets the network connection
  
  execute "Enabling Screen Sharing for All Users" do
    command "/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -restart -agent -privs -all"
  end
end