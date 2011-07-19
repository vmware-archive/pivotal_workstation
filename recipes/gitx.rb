GITX_PATH = "/Applications/GitX.app"

unless File.exists?(GITX_PATH) 
  
  execute "download GitX to temp dir" do
    command %'/usr/bin/curl -o /tmp/gitx.zip #{node["gitx_download_location"]}'
    user WS_USER
  end

  execute "unzip gitx" do
    command "unzip /tmp/gitx.zip -d /tmp/"
    user WS_USER
  end

  execute "copy gitx to /Applications" do
    command "cp -rf /tmp/GitX.app #{GITX_PATH}"
    user WS_USER
  end

  ruby_block "test to see if GitX was installed" do
    block do
      raise "GitX was not installed" unless File.exists?(GITX_PATH)
    end
  end
end
