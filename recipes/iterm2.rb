unless File.exists?(node["iterm2_app_path"])

  remote_file "#{Chef::Config[:file_cache_path]}/iTerm2.zip" do
    source node["iterm2_download_url"]
    owner WS_USER
    checksum node["iterm2_checksum"]
  end

  execute "unzip iterm2" do
    command "unzip #{Chef::Config[:file_cache_path]}/iTerm2.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy iterm2 to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/iTerm.app #{Regexp.escape(node["iterm2_app_path"])}"
    user WS_USER
    group "admin"
  end

  cookbook_file "/Users/#{WS_USER}/Library/Preferences/com.googlecode.iterm2.plist" do
    source "com.googlecode.iterm2.plist"
    user WS_USER
    mode "0600"
  end

end
