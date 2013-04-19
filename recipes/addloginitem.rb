Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

include_recipe "pivotal_workstation::user_owns_usr_local"

addloginitem_path="/usr/local/bin/addloginitem"

unless File.exists?(addloginitem_path)

  remote_file addloginitem_path do
    source "https://github.com/downloads/pivotalexperimental/addLoginItem/addLoginItem"
    mode '0755'
    owner WS_USER
  end

  ruby_block "test to see if addloginitem was installed" do
    block do
      raise "#{addloginitem_path} was not installed" unless File.exists?(addloginitem_path)
    end
  end

end
