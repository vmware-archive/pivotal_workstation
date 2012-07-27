unless File.exists?(node["freeruler_app_path"])

  remote_file "#{Chef::Config[:file_cache_path]}/FreeRuler1.7b5.zip" do
    source node["freeruler_download_uri"]
    owner WS_USER
  end

  execute "unzip FreeRuler to /Applications" do
    command "unzip -o #{Chef::Config[:file_cache_path]}/FreeRuler1.7b5.zip -x __MACOSX* -d /Applications/"
    user WS_USER
    # This is required to unzip into Applications
    group "admin"
  end

  ruby_block "test to see if FreeRuler was installed" do
    block do
      raise "FreeRuler install failed" unless File.exists?(node["freeruler_app_path"])
    end
  end

end
