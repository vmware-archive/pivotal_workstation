if node["platform"] == "mac_os_x"
    brew "gnu-tar"
    link "/usr/bin/tar" do
        to "/usr/local/bin/gtar"
    end
end

