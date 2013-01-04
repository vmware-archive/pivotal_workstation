pivotal_workstation_defaults "Disable press-and-hold for keys in favor of key repeat" do
  domain 'NSGlobalDomain'
  key 'ApplePressAndHoldEnabled'
  boolean false
end
