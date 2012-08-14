include_recipe "pivotal_workstation::user_owns_usr_local"

node.default["textmate"]["url"] = "http://download.macromates.com/TextMate_1.5.10.zip"
node.default["textmate"]["shasum"] = "325f061fb19f87ea61df672df619065ea34e2c88fba30c84635368ea0a40c406"

unless File.exists?("/Applications/TextMate.app")
  directory Chef::Config[:file_cache_path] do
    action :create
    recursive true
  end

  remote_file "#{Chef::Config[:file_cache_path]}/textmate.zip" do
    source node["textmate"]["url"]
    checksum node["textmate"]["shasum"]
    owner WS_USER
  end

  execute "extract text mate to /Applications" do
    command "unzip -o #{Chef::Config[:file_cache_path]}/textmate.zip -x __MACOSX* -d /Applications/"
    user WS_USER

    # This is required to unzip into Applications
    group "admin"
  end

  execute "link textmate" do
    command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
    not_if "test -e /usr/local/bin/mate"
  end

  ruby_block "test to see if TextMate was installed" do
    block do
      raise "TextMate install failed" unless File.exists?("/Applications/TextMate.app")
    end
  end
end

execute "link textmate" do
  command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
  not_if "test -e /usr/local/bin/mate"
end
