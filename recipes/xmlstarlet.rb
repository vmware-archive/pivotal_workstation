Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

if node["platform"] != "mac_os_x"
    package "xmlstarlet"
else
    brew "xmlstarlet"
    link "/usr/local/bin/xmlstarlet" do
        to "/usr/local/bin/xml"
    end
end
