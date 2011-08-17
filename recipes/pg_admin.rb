unless File.exists?(node["pg_admin_app_path"])

  remote_file "/tmp/pg_admin3.dmg" do
    source node["pg_admin_download_uri"]
    mode "0644" 
  end
  
  execute "mount pgAdmin3 dmg" do
    command "echo 'Y' | hdid /tmp/pg_admin3.dmg"
    user WS_USER
  end
  
  execute "copy pgAdmin3 to /Applications" do
    command "cp -rf /Volumes/pgAdmin3/pgAdmin3.app #{Regexp.escape(node["pg_admin_app_path"])}"
    user WS_USER
  end
  
  execute "unmount dmg" do
    command "hdiutil detach /Volumes/pgAdmin3"
    user WS_USER
  end

  ruby_block "test to see if pgAdmin3 was installed" do
    block do
      raise "pgAdmin3 install failed" unless File.exists?(node["pg_admin_app_path"])
    end
  end
end
