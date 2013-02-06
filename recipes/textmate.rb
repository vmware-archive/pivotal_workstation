include_recipe "pivotal_workstation::user_owns_usr_local"

node.default["textmate"]["url"] = "http://download.macromates.com/TextMate_1.5.10.zip"
node.default["textmate"]["shasum"] = "325f061fb19f87ea61df672df619065ea34e2c88fba30c84635368ea0a40c406"
node.default["textmate"]["destination"] = "/Applications"
node.default["textmate"]["cmd_destination"] = "/usr/local/bin"

unless File.exists?("#{node["textmate"]["destination"]}/TextMate.app")
  directory Chef::Config[:file_cache_path] do
    action :create
    recursive true
  end

  remote_file "#{Chef::Config[:file_cache_path]}/textmate.zip" do
    source node["textmate"]["url"]
    checksum node["textmate"]["shasum"]
    owner WS_USER
  end

  execute "extract text mate to #{Regexp.escape(node["textmate"]["destination"])}" do
    command "unzip -o #{Chef::Config[:file_cache_path]}/textmate.zip -x __MACOSX* -d #{Regexp.escape(node["textmate"]["destination"])}"
    user WS_USER

    # This is required to unzip into Applications
    group "admin"
  end

  execute "link textmate" do
    command "ln -s #{Regexp.escape(node["textmate"]["destination"])}/TextMate.app/Contents/Resources/mate #{Regexp.escape(node["textmate"]["cmd_destination"])}/mate"
    not_if "test -e #{Regexp.escape(node["textmate"]["cmd_destination"])}/mate"
  end

  ruby_block "test to see if TextMate was installed" do
    block do
      raise "TextMate install failed" unless File.exists?("#{Regexp.escape(node["textmate"]["destination"])}/TextMate.app")
    end
  end
end

execute "link textmate" do
  command "ln -s #{Regexp.escape(node["textmate"]["destination"])}/TextMate.app/Contents/Resources/mate #{Regexp.escape(node["textmate"]["cmd_destination"])}/mate"
  not_if "test -e #{Regexp.escape(node["textmate"]["cmd_destination"])}/mate"
end
