raise "DiffMerge for Mac only" unless node["platform"] == "mac_os_x"

dmg_package "DiffMerge" do
  volumes_dir "DiffMerge 3.3.2.1139"
  source "http://download-us.sourcegear.com/DiffMerge/3.3.2/DiffMerge.3.3.2.1139.dmg"
  checksum "aa1579bd60d7c05eb055e8d898223d6cc4ac5d6c1998bbc641adc5a2760a4841"
  action :install
end

# Link the sample file from the diffmerge application directory
# for use as the diffmerge command-line script
link "/usr/local/bin/diffmerge" do
  to "/Applications/DiffMerge.app/Contents/Resources/diffmerge.sh"
end

# Configure git unless otherwise requested
diffmerge = node["diffmerge"] || {}
if (diffmerge["configure-git"] || 1) != 0

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
