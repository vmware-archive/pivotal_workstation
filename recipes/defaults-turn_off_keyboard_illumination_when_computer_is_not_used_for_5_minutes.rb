pivotal_workstation_defaults "Turn off keyboard illumination when computer is not used for 5 minutes" do
  domain 'com.apple.BezelServices'
  key 'kDimTime'
  integer 300
end
