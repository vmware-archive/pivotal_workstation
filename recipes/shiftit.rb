include_recipe "pivotal_workstation::addloginitem"

unless File.exists?("/Applications/ShiftIt.app")
  remote_file "#{Chef::Config[:file_cache_path]}/ShiftIt.app.zip" do
    source "https://github.com/downloads/onsi/ShiftIt/ShiftIt.app.zip"
    mode "0644"
  end

  execute "unzip ShiftIt" do
    command "unzip #{Chef::Config[:file_cache_path]}/ShiftIt.app.zip ShiftIt.app/* -d /Applications/"
    user WS_USER
    group "admin"
  end

  # start up on login
  execute "Start ShiftIt automatically" do
    command "addloginitem /Applications/ShiftIt.app"
    user WS_USER
  end
end
