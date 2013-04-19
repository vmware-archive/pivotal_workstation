Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

execute "set the root user shell to bash" do
  command "dscl . -create /Users/root UserShell /bin/bash"
end

link "/root" do
    to "/var/root"
end
