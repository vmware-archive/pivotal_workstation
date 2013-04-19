Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

pivotal_workstation_defaults "show hard drive on desktop" do
  domain 'com.apple.finder'
  key 'ShowHardDrivesOnDesktop'
  boolean true
end
