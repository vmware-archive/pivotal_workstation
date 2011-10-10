include_recipe "pivotal_workstation::bash_profile"
GIT_COMP_PATH = "#{WS_HOME}/.bash_profile_includes/git-completion.sh"
GIT_COMP_SRC  = "http://repo.or.cz/w/git.git/blob_plain/HEAD:/contrib/completion/git-completion.bash"

unless File.exists?(GIT_COMP_PATH)
  remote_file GIT_COMP_PATH do
    source GIT_COMP_SRC
    owner WS_USER
  end

  ruby_block "test to see if git-completion was installed" do
    block do
      raise "git-completion was not installed" unless File.exists?(GIT_COMP_PATH)
    end
  end
end
