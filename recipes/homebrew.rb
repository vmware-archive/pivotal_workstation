include_recipe "pivotal_workstation::user_owns_usr_local"

homebrew_git_revision_hash  = version_string_for("homebrew")

git "/usr/local/" do
  repository "https://github.com/mxcl/homebrew.git"
  revision homebrew_git_revision_hash
  action :sync
  user WS_USER
end

ruby_block "Check that homebrew is running & working" do
  block do
    `brew --version`
    if $? != 0
      raise "Couldn't find brew"
    end
  end
end
