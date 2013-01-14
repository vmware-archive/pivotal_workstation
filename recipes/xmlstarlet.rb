if node["platform"] == "ubuntu"
    package "xmlstarlet"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "xmlstarlet"
    link "/usr/local/bin/xmlstarlet" do
        to "/usr/local/bin/xml"
    end
end
