run_unless_marker_file_exists("size_up") do
  # The following doesn't work - it causes the checkbox to be enabled, but doesn't turn it on.
  # other people want this feature, leaving this in to remind me or someone else
  # to google for it in the future
  # execute "turn on Access for Assistive Devices" do
  #   command "touch /private/var/db/.AccessibilityAPIEnabled"
  # end
  
  execute "download size_up" do
    command "curl -o /tmp/sizeup.zip http://irradiatedsoftware.com/download/SizeUp.zip"
    user WS_USER
  end
  
  execute "unzip sizeup" do
    command "unzip /tmp/sizeup.zip SizeUp.app/* -d /Applications/"
    user WS_USER
  end
end
