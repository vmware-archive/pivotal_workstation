#nailing homebrew to this revision, for no reason other than consistency
homebrew_git_revision_hash  = "6e5b83c3b0e94c0ee721d87eca64c0e9cbe5d163"
# Author: theunraveler <jake.b.bell@gmail.com>
# Date:   Tue May 25 13:53:31 2010 -0500


run_unless_marker_file_exists("homebrew-#{homebrew_git_revision_hash}") do
  
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

