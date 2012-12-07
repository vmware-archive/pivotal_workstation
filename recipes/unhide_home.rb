execute "remove home from auto_master" do
  command "cat /etc/auto_master | grep -v home > /tmp/am; mv /tmp/am /etc/auto_master"
end

execute "reload auto_master" do
  command "automount -vc"
end
