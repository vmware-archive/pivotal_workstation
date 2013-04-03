include_recipe "pivotal_workstation::user_owns_usr_local"

node.default["textmate"]["url"] = "http://download.macromates.com/TextMate_1.5.11_r1635.zip"
node.default["textmate"]["shasum"] = "33897ffcc743db6a9ac4bac7f440f9feb94e57aa788755b46eab37cf9c6efb6c"

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
