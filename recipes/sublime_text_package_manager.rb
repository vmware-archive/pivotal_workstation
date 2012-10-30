package_dir = "#{WS_HOME}/Library/Application Support/Sublime Text 2/Installed Packages"
filename    = "Package Control.sublime-package"

execute "make sublimetext installed packages directory" do
  command "mkdir -p '#{package_dir}'"
  user WS_USER
  not_if { File.exists?(package_dir) }
end

remote_file "#{package_dir}/#{filename}" do
  source 'http://sublime.wbond.net/Package%20Control.sublime-package'
  owner WS_USER
  :create_if_missing
end