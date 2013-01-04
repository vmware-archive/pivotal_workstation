pivotal_workstation_defaults "Disable reply animations in Mail.app" do
  domain 'com.apple.mail'
  key 'DisableReplyAnimations'
  boolean true
end

pivotal_workstation_defaults "Disable send animations in Mail.app" do
  domain 'com.apple.mail'
  key 'DisableSendAnimations'
  boolean true
end
