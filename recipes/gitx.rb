GITX_PATH = "/Applications/GitX.app"
GITX_LINK = "/usr/local/bin/gitx"
include_recipe "pivotal_workstation::user_owns_usr_local"

unless File.exists?(GITX_PATH)

  remote_file "/tmp/gitx.zip" do
    source node["gitx_download_location"]
    owner WS_USER
  end

  execute "unzip gitx" do
    command "unzip /tmp/gitx.zip -d /tmp/"
    user WS_USER
  end

  execute "copy gitx to /Applications" do
    command "mv /tmp/GitX.app #{GITX_PATH}"
    user WS_USER
  end

  ruby_block "test to see if GitX.app was installed" do
    block do
      raise "GitX.app was not installed" unless File.exists?(GITX_PATH)
    end
  end
end

unless File.exists?(GITX_LINK)
  # ln -s /Applications/GitX.app/Contents/Resources/gitx /usr/local/bin/gitx
  link "/usr/local/bin/gitx" do
    to "/Applications/GitX.app/Contents/Resources/gitx"
  end

  ruby_block "test to see if gitx link was installed" do
    block do
      raise "gitx link was not installed" unless File.exists?(GITX_PATH)
    end
  end
end
