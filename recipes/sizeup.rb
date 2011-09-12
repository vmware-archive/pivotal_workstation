unless File.exists?("/Applications/SizeUp.app")

  remote_file "/tmp/sizeup.zip" do
    source node["sizeup_download_uri"]
    mode "0644"
  end

  # The following doesn't work - it causes the checkbox to be enabled, but doesn't turn it on.
  # other people want this feature, leaving this in to remind me or someone else
  # to google for it in the future
  # execute "turn on Access for Assistive Devices" do
  #   command "touch /private/var/db/.AccessibilityAPIEnabled"
  # end

  execute "unzip sizeup" do
    command "unzip /tmp/sizeup.zip SizeUp.app/* -d /Applications/"
    user WS_USER
  end
end
