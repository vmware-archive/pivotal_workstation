# Disable Mountain Lion's Gatekeeper

execute "disable gatekeeper"   do
  command "spctl --master-disable"
end
