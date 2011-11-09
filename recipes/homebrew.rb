include_recipe "pivotal_workstation::user_owns_usr_local"
include_recipe "pivotal_workstation::bash_path_order"

homebrew_git_revision_hash  = version_string_for("homebrew")

# Do not be tempted to use the git-resource to check out
# homebrew directly into /usr/local; it will fail if
# it finds *anything* in /usr/local, and it will find 
# at least a bin directory because the user_owns_usr_local
# recipe creates it, and that's a pre-req.  Also, things like
# MacFuse, Audacity, and others tend to put things in /usr/local
if (`which brew`.empty?)
  git "/tmp/homebrew" do
    repository "https://github.com/mxcl/homebrew.git"
    revision homebrew_git_revision_hash
    destination "/tmp/homebrew"
    action :sync
    user WS_USER
  end

  execute "Copying homebrew's .git to /usr/local" do
    command "rsync -axSH /tmp/homebrew/ /usr/local/"
    user WS_USER
  end
end

ruby_block "Check that homebrew is running & working" do
  block do
    `brew --version`
    if $? != 0
      raise "Couldn't find brew"
    end
  end
end

directory "/usr/local/sbin" do
  owner WS_USER
end
