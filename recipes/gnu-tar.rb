if node["platform"] == "mac_os_x"
    include_recipe "pivotal_workstation::homebrew"
    brew_install "gnu-tar"
    link "/usr/bin/tar" do
        to "/usr/local/bin/gtar"
    end
end

