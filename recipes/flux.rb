unless File.exists?("/Applications/Flux.app")

  remote_file "#{Chef::Config[:file_cache_path]}/Flux.zip" do
    source node["flux_download_uri"]
    mode "0644"
  end

  execute "unzip flux" do
    command "unzip #{Chef::Config[:file_cache_path]}/Flux.zip Flux.app/* -d /Applications/"
    user WS_USER
    group "admin"
  end
end
