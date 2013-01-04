pivotal_workstation_defaults "Check for software updates daily, not just once per week" do
  domain 'com.apple.SoftwareUpdate'
  key 'ScheduleFrequency'
  integer 1
end
