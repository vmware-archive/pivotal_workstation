unless File.exists?("/Applications/SizeUp.app")

  remote_file "/tmp/sizeup.zip" do
    source node["sizeup_download_uri"]
    mode "0644"
  end

  # May not work if System Preferences is open while this is running
  file "/private/var/db/.AccessibilityAPIEnabled" do
    action :create_if_missing
    content "a"
    mode "0444"
  end

  execute "unzip sizeup" do
    command "unzip /tmp/sizeup.zip SizeUp.app/* -d /Applications/"
    user WS_USER
  end
end
