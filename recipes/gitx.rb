include_recipe "pivotal_workstation::user_owns_usr_local"

GITX_PATH = "/Applications/GitX.app"
GITX_LINK = "/usr/local/bin/gitx"
GITX_LINK_SRC = "/Applications/GitX.app/Contents/Resources/gitx"

unless File.exists?(GITX_PATH)

  remote_file "/tmp/gitx.zip" do
    source node["gitx_download_location"]
    owner WS_USER
  end

  directory "/tmp/GitX.app" do
    action :delete
    recursive true
  end

  execute "unzip gitx" do
    command "unzip /tmp/gitx.zip -d /tmp/"
    user WS_USER
  end

  execute "copy gitx to /Applications" do
    command "rsync -a /tmp/GitX.app /Applications"
    user WS_USER
    group "admin"
  end

  ruby_block "test to see if GitX.app was installed" do
    block do
      raise "GitX.app was not installed" unless File.exists?(GITX_PATH)
    end
  end
end


unless File.exists?(GITX_LINK)
  ruby_block "Check for existence of #{GITX_LINK_SRC}." do
    block do
      raise "#{GITX_LINK_SRC} doesn't exist!  Can't create symbolic link!" unless File.exists?(GITX_LINK_SRC)
    end
  end

  # ln -s /Applications/GitX.app/Contents/Resources/gitx /usr/local/bin/gitx
  link GITX_LINK do
    to GITX_LINK_SRC
  end

  ruby_block "test to see if gitx link was installed" do
    block do
      raise "gitx link was not installed" unless File.exists?(GITX_LINK)
    end
  end
end

