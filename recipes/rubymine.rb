include_recipe "pivotal_workstation::java"

rubymine_version="3.2.4"
pivotal_workstation_package "Rubymine #{rubymine_version}" do
  source "http://download.jetbrains.com/ruby/RubyMine-#{rubymine_version}.dmg"
  action :install
  checksum "5b670894397ae5dcb692bb2b2a7e3b01cedf2e50978879ea4fe1efaa348cbb9c"
end

# rubymine 4 should not need this
template "/Applications/RubyMine #{rubymine_version}.app/rb/testing/patch/bdd/teamcity/spec/runner/formatter/teamcity/formatter.rb" do
  source "rubymine-rspec-2-8-support.erb"
  owner WS_USER
  group "admin"
end
