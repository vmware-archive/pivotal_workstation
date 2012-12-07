unless File.exists?("/Applications/Things.app")

  remote_file "#{Chef::Config[:file_cache_path]}/Things.zip" do
    source "http://culturedcode.com/things/download/"
    owner WS_USER
  end

  execute "unzip Things" do
    command "unzip #{Chef::Config[:file_cache_path]}/Things.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy Things to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Things.app #{Regexp.escape("/Applications/Things.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if Things.app was installed" do
    block do
      raise "Things.app was not installed" unless File.exists?("/Applications/Things.app")
    end
  end

end



