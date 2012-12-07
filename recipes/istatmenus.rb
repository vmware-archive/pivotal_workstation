unless File.exists?("/Applications/iStat Menus.app")

  remote_file "#{Chef::Config[:file_cache_path]}/istatmenus.zip" do
    source "http://s3.amazonaws.com/bjango/files/istatmenus4/istatmenus4.02.zip"
    owner WS_USER
  end

  execute "unzip iStat Menus" do
    command "unzip #{Chef::Config[:file_cache_path]}/istatmenus.zip -d #{Chef::Config[:file_cache_path]}/"
    user WS_USER
  end

  execute "copy iStat Menus to /Applications" do
    command "mv #{Regexp.escape("#{Chef::Config[:file_cache_path]}/iStat Menus.app")} #{Regexp.escape("/Applications/iStat Menus.app")}"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if iStat Menus.app was installed" do
    block do
      raise "iStat Menus.app was not installed" unless File.exists?("/Applications/iStat Menus.app")
    end
  end

end



