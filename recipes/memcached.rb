unless brew_installed? "memcached"
  brew "memcached"

  directory "/Users/#{WS_USER}/Library/LaunchAgents" do
    owner WS_USER
    action :create
  end

  execute "copy memcached plist to ~/Library/LaunchAgents" do
    command "cp `brew --prefix memcached`/homebrew.mxcl.memcached.plist #{WS_HOME}/Library/LaunchAgents/"
    user WS_USER
  end

  execute "load the memcached plist into the mac daemon startup thing" do
    command "launchctl load -w #{WS_HOME}/Library/LaunchAgents/homebrew.mxcl.memcached.plist"
    user WS_USER
  end
end
