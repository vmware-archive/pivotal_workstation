unless File.exists?("/Applications/" + node["libreoffice_basename"])

  remote_file "/tmp/libreoffice.dmg" do
    source node["libreoffice_download_uri"]
    mode "0644" 
  end
  
  execute "mount libreoffice dmg" do
    command "hdid /tmp/libreoffice.dmg"
    user WS_USER
  end

  execute "copy LibreOffice to /Applications" do
    command "cp -rf #{Regexp.escape(node["libreoffice_dmg_mnt"]+ "/" + node["libreoffice_basename"])} /Applications/"
    user WS_USER
  end

  execute "unmount dmg" do
    command "hdiutil detach #{Regexp.escape(node["libreoffice_dmg_mnt"])}"
    user WS_USER
  end

  ruby_block "test to see if LibreOffice was installed" do
    block do
      raise "LibreOffice install failed" unless File.exists?("/Applications/" + node["libreoffice_basename"])
    end
  end
end
