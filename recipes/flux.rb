remote_file "#{Chef::Config[:file_cache_path]}/Flux.zip" do
  source node["flux_download_uri"]
  checksum node["flux_download_checksum"]
  mode "0644"
  not_if { File.exists?("/Applications/Flux.app") }
end

execute "unzip flux" do
  command "unzip -q #{Chef::Config[:file_cache_path]}/Flux.zip Flux.app/* -d /Applications/"
  user WS_USER
  group "admin"
  not_if { File.exists?("/Applications/Flux.app") }
end
