# fixme: This should be re-factored once package.rb has a mechanism
# for installing pkg files without mounting a dmg
ruby_block "Install Flycut" do
  block do
    system("cd #{Chef::Config[:file_cache_path]}/ && curl -OL https://github.com/downloads/TermiT/Flycut/flycut1.5.pkg")
    system("installer -allowUntrusted -package  #{Chef::Config[:file_cache_path]}/flycut1.5.pkg -target /")
  end
  not_if {File.exists?("/Applications/Flycut.app")}
end

# start up on login
execute "Start Flycut automatically" do
  command "defaults write loginwindow AutoLaunchedApplicationDictionary -array-add '{ \"Path\" = \"/Applications/Flycut.app\"; \"Hide\" = 0; }'"
  user WS_USER
end

ruby_block "test that Flycut install worked" do
  block do
    raise "Flycut install failed!" if ! File.exists?("/Applications/Flycut.app")
  end
end
