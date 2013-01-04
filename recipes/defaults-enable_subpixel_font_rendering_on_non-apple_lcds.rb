pivotal_workstation_defaults "Enable subpixel font rendering on non-Apple LCDs" do
  domain 'NSGlobalDomain'
  key 'AppleFontSmoothing'
  integer 2
end
