include_recipe "homebrew"
include_recipe "pivotal_workstation::git"
package "tmux"

remote_file "#{WS_HOME}/.tmux.conf" do
  source node["tmux_conf_file_url"]
  mode "0644"
end

