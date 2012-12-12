unless File.exists?("/Applications/Kaleidoscope.app")

  remote_file "#{Chef::Config[:file_cache_path]}/kaleidoscope.zip" do
    source "https://updates.blackpixel.com/latest-beta?app=ks"
    owner WS_USER
  end

  execute "unzip Kaleidoscope" do
    command "unzip #{Chef::Config[:file_cache_path]}/kaleidoscope.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy Kaleidoscope to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Kaleidoscope.app #{Regexp.escape("/Applications/Kaleidoscope.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if Kaleidoscope.app was installed" do
    block do
      raise "Kaleidoscope.app was not installed" unless File.exists?("/Applications/Kaleidoscope.app")
    end
  end

end



