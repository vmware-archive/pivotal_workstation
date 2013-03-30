include_recipe "pivotal_workstation::virtualbox"

dmg_package "Vagrant" do
  dmg_name "Vagrant.dmg"
  source "http://files.vagrantup.com/packages/194948999371e9aee391d13845a0bdeb27e51ac0/Vagrant.dmg"
  checksum "eeb7746ac235dff82ff4c9fa32f82bed2b271527"
  action :install
  type "pkg"
  owner WS_USER
  package_id "com.vagrant.vagrant"
end
