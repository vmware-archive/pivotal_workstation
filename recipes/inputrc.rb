Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

inputrc_location = "#{WS_HOME}/.inputrc"

template inputrc_location do
  owner WS_USER
  source "inputrc.erb"
end
