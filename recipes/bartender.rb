unless File.exists?("/Applications/Bartender.app")

  remote_file "#{Chef::Config[:file_cache_path]}/Bartender.zip" do
    source "http://www.macbartender.com/Demo/Bartender.zip"
    owner WS_USER
  end

  execute "unzip Bartender" do
    command "unzip #{Chef::Config[:file_cache_path]}/Bartender.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy Bartender to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Bartender.app #{Regexp.escape("/Applications/Bartender.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if Bartender.app was installed" do
    block do
      raise "Bartender.app was not installed" unless File.exists?("/Applications/Bartender.app")
    end
  end

end



