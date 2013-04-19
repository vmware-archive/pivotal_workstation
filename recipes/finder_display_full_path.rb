Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

pivotal_workstation_defaults "set finder to display full path in title bar" do
  domain 'com.apple.finder'
  key '_FXShowPosixPathInTitle'
  boolean true
end
