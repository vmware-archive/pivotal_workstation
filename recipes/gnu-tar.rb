Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

if node["platform"] == "mac_os_x"
    brew "gnu-tar"
    link "/usr/bin/tar" do
        to "/usr/local/bin/gtar"
    end
end

