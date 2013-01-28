raise "DiffMerge for Mac only" unless node["platform"] == "mac_os_x"

dmg_package "DiffMerge" do
  volumes_dir "DiffMerge 3.3.2.1139"
  source "http://download-us.sourcegear.com/DiffMerge/3.3.2/DiffMerge.3.3.2.1139.dmg"
  action :install
end

# Link the sample file from the diffmerge application directory
# for use as the diffmerge command-line script
link "/usr/local/bin/diffmerge" do
  to "/Applications/DiffMerge.app/Contents/Resources/diffmerge.sh"
end

# Configure git unless otherwise requested
node["diffmerge"] ||= {}
node["diffmerge"]["configure-git"] ||= 1
if node["diffmerge"]["configure-git"] != 0

  [
    %q[git config --global diff.tool diffmerge],
    %q[git config --global difftool.diffmerge.cmd 'diffmerge "$LOCAL" "$REMOTE"'],
    %q[git config --global difftool.prompt false],
    %q[git config --global merge.tool diffmerge],
    %q[git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'],
    %q[git config --global mergetool.diffmerge.trustExitCode true],
  ].each do |cmd|
    execute cmd do
      command cmd
    end
  end

end
