# This command complains that it's depricated.  But it works.

execute "turn on ssh" do
  command "systemsetup -setremotelogin on"
end