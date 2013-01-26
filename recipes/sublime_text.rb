require 'uri'

# Isolate platform-dependent information in a class
class Chef::Recipe
  class Sublime

    def self.extension (node)
      if node["platform"] != "mac_os_x"
        " x64.tar.bz2"
      else
        ".dmg"
      end
    end

    def self.basename (node)
      "Sublime Text #{node['sublime_text'][:version]}"
    end

    def self.filename (node)
      "#{self.basename(node)}#{self.extension(node)}"
    end

    def self.config_dir_array (node)
      if node["platform"] != "mac_os_x"
        ["#{WS_HOME}", ".config", "sublime-text-2"]
      else
        ["#{WS_HOME}/Library/Application Support", "Sublime Text 2"]
      end
    end

    def self.dstdir (node)
      if node["platform"] != "mac_os_x"
        "/opt/subl"
      else
        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin"
      end
    end

    def self.dstfile (node)
      if node["platform"] != "mac_os_x"
        "#{Sublime::dstdir(node)}/sublime_text"
      else
        "#{Sublime::dstdir(node)}/subl"
      end
    end

    def self.owner (node)
      if node["platform"] != "mac_os_x"
        'root'
      else
        WS_USER
      end
    end

    def self.download_url (node)
      URI.escape "#{node['sublime_text'][:download_url]}/#{self.filename(node)}"
    end

  end
end

# Create directory where Sublime is installed
directory Sublime::dstdir(node) do
  owner Sublime::owner(node)
end

# Unpack and install
if node["platform"] != "mac_os_x"

  execute "Download Sublime Text 2" do
    command "curl -L #{Sublime::download_url(node)} -o '/tmp/#{Sublime::filename(node)}'"
    not_if {
      File.exist?("/tmp/#{Sublime::filename(node)}") ||
       File.exist?("#{Sublime::dstdir(node)}/sublime_text")
    }
  end

  execute "Unpack Sublime Text 2" do
    command "tar --strip-components=1 -C '#{Sublime::dstdir(node)}' -xjf '/tmp/#{Sublime::filename(node)}'"
    not_if { File.exist?("#{Sublime::dstdir(node)}/sublime_text") }
  end

else

  dmg_package "Sublime Text 2" do
    dmg_name URI.escape(Sublime::basename(node))
    source Sublime::download_url(node)
    checksum "b5f91ee4f62d36c0490c021d5fb134b9e7cb3936"
    owner Sublime::owner(node)
  end

end


link "/usr/local/bin/subl" do
  to Sublime::dstfile(node)
end


# Create shortcut
template "/usr/local/bin/e" do
  mode '0755'
  source "sublime_text.sh"
  owner Sublime::owner(node)
  action :create_if_missing
end


# Install packages list in attributes
packages_dir_array = Sublime::config_dir_array(node) << "Packages"

recursive_directories packages_dir_array do
  owner WS_USER
end

node["sublime_text_packages"].each do |package|
  pivotal_workstation_sublime_package package["name"] do
    source package["source"]
    destination File.join(packages_dir_array)
    owner WS_USER
  end
end


# Configure user settings
settings_dir_array = packages_dir_array.dup << "User"

recursive_directories settings_dir_array do
  owner WS_USER
end

template File.expand_path("Preferences.sublime-settings", File.join(settings_dir_array)) do
  source "sublime_text-Preferences.sublime-settings.erb"
  owner WS_USER
  action :create_if_missing
end


# Install Package Control, the essential Sublime Text plugin
pkgcontrol_dir_array = Sublime::config_dir_array(node) << "Installed Packages"

recursive_directories pkgcontrol_dir_array do
  owner WS_USER
end

remote_file "#{File.join pkgcontrol_dir_array}/Package Control.sublime-package" do
  source 'http://sublime.wbond.net/Package%20Control.sublime-package'
  owner WS_USER
  :create_if_missing
end
