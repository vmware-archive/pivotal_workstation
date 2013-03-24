include_recipe "pivotal_workstation::homebrew"

unless brew_installed? "redis"
  brew "redis"

  directory "/Users/#{WS_USER}/Library/LaunchAgents" do
    owner WS_USER
    action :create
  end

  execute "copy redis plist to ~/Library/LaunchAgents" do
    command "cp `brew --prefix redis`/homebrew.mxcl.redis.plist #{WS_HOME}/Library/LaunchAgents/"
    user WS_USER
  end

  execute "load the redis plist into the mac daemon startup thing" do
    command "launchctl load -w #{WS_HOME}/Library/LaunchAgents/homebrew.mxcl.redis.plist"
    user WS_USER
  end
end
