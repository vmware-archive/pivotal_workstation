#password_hash = node[:users][:operations][:password_hash] || "!NOLOGIN"
#password_hash = "!NOLOGIN"
require 'etc'

username="ops"

unless system("dscl . list /Users/ops")
  # Find the first available uid > 500 so it shows up in System Preferences
  uids = `dscl . -list /Users UniqueID`.split("\n").collect { |pair| pair.squeeze(" ").split(" ").last.to_i }
  uid = 501
  while ( uids.include?(uid) ) do
    uid += 1
  end

  user username do
    comment username.capitalize
    gid Etc.getgrnam("staff").gid
    uid uid
    home "/Users/#{username}"
    shell "/bin/bash"
    not_if "id #{username}"
  end

  #create the user's home directory
  directory "/Users/#{username}" do
    owner username
    group "staff"
    mode "0755"
    action :create
  end

  execute "defaults write  /var/db/dslocal/nodes/Default/users/#{username} ShadowHashData -array -data \"#{node["ops_user_password_hash"]}\""

  group "admin" do
    members [username]
    append true
  end
end