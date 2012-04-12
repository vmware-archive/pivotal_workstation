directory "#{WS_HOME}/.ssh" do
  action :create
  owner WS_USER
  group "staff"
  mode "0700"
end

file "#{WS_HOME}/.ssh/known_hosts" do
  action :create_if_missing
  owner WS_USER
  group "staff"
  mode "0644"
end

if !File.exist?("#{WS_HOME}/.ssh/known_hosts") || !File.read("#{WS_HOME}/.ssh/known_hosts").include?("github.com")
  if node["github_username"].nil? || node["github_password"].nil?
    require "tempfile"
    credentials_script = Tempfile.new("github_credentials")
    credentials_script << <<-RUBY
      value = gets
      puts value
    RUBY
    credentials_script.rewind
    print "Github Username: "
    node["github_username"] = `ruby #{credentials_script.path}`.strip
    print "Github Password: "
    node["github_password"] = `ruby #{credentials_script.path}`.strip
    credentials_script.close
  end
end

# If there is no github_project defined, we will use the name of the machine as the SSH key,
# therefore make sure we have a name first.
include_recipe "pivotal_workstation::rename_machine" unless node["github_project"]

execute "add github to knownhosts" do
  user WS_USER
  cwd "#{WS_HOME}/.ssh"
  command <<-SH
    (cat known_hosts | grep github.com) || \
    echo "github.com,207.97.227.239 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> known_hosts
  SH
end

execute "make sure .ssh/config is owned by the user" do
  only_if "test -e #{WS_HOME}/.ssh/config"
  command "chown #{WS_USER} #{WS_HOME}/.ssh/config"
end

execute "create SSH key pair for Github" do
  command "ssh-keygen -N '' -f #{WS_HOME}/.ssh/id_github_#{node["github_project"] || node['fqdn']}"
  user WS_USER
  not_if "test -e #{WS_HOME}/.ssh/id_github_#{node["github_project"] || node['fqdn']}"
end

execute "symlink Github key for git-project" do
  command "ln -nfs #{WS_HOME}/.ssh/id_github_{#{node["github_project"] || node['fqdn']},current}"
  user WS_USER
end

execute "symlink Github public key for git-project" do
  command "ln -nfs #{WS_HOME}/.ssh/id_github_{#{node["github_project"] || node['fqdn']},current}.pub"
  user WS_USER
end

execute "add Github configuration to .ssh/config" do
  config = "\n\nHost github.com\n  User git\n  IdentityFile #{WS_HOME}/.ssh/id_github_current"
  command "echo '#{config}' >> #{WS_HOME}/.ssh/config"
  not_if "grep 'id_github_current' #{WS_HOME}/.ssh/config"
  user WS_USER
end

# add ssh keys to github account if possible
if node["github_username"].to_s != "" && node["github_password"].to_s != ""
  github_name="#{WS_USER}@#{node['fqdn']}"
  curl_options = %[--retry 3 --retry-delay 5 --retry-max-time 30 --connect-timeout 5 --max-time 30 -u "#{node["github_username"]}:#{node["github_password"]}"]
  execute "upload ssh key to github if it does not already exist there" do
    not_if <<-SH
      curl #{curl_options} https://api.github.com/user/keys | grep "`cat #{WS_HOME}/.ssh/id_github_#{node["github_project"] || node["fqdn"]}.pub` | cut -f 2 -d ' '`"
    SH
    command <<-SH
    curl -X POST --verbose #{curl_options} \
         --data "{ \\"key\\": \\"`cat #{WS_HOME}/.ssh/id_github_#{node["github_project"] || node["fqdn"]}.pub`\\", \\"title\\": \\"#{github_name}\\" }" \
         https://api.github.com/user/keys
    SH
  end
  user WS_USER
else
  log "No GITHUB_USERNAME or GITHUB_PASSWORD provided, skipping steps to upload ssh keys to github.com"
end

