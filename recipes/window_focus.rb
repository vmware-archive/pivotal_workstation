Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

pivotal_workstation_defaults "turn on focus-follows-window for browsers, etc.." do
  domain 'org.x.X11'
  key 'wm_ffm'
  boolean true
end
