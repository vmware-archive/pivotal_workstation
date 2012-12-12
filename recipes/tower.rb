unless File.exists?("/Applications/Tower.app")

  remote_file "#{Chef::Config[:file_cache_path]}/tower.zip" do
    source "http://www.git-tower.com/download"
    owner WS_USER
  end

  execute "unzip tower" do
    command "unzip #{Chef::Config[:file_cache_path]}/tower.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy tower to /Applications" do
    command "mv #{Chef::Config[:file_cache_path]}/Tower.app #{Regexp.escape("/Applications/Tower.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if Tower.app was installed" do
    block do
      raise "Tower.app was not installed" unless File.exists?("/Applications/Tower.app")
    end
  end

end



