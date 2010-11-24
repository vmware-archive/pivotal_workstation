homebrew_git_revision_hash  = version_string_for("homebrew")

run_unless_marker_file_exists(marker_version_string_for("homebrew")) do

  directory "/usr/local" do
    owner WS_USER
  end

  execute "your current user owns /usr/local" do
    command "chown -R #{WS_USER} /usr/local"
  end

  execute "install homebrew" do
    command "curl -Lsf http://github.com/mxcl/homebrew/tarball/#{homebrew_git_revision_hash} | tar xvz -C/usr/local --strip 1"
    user WS_USER
  end

  ruby_block "check homebrew" do
    block do
      result = `sudo -u #{WS_USER} brew --version`
      raise("brew not working: #{result}") unless result.strip.to_f >= 0.6
    end
  end

end

