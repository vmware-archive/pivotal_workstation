##  This is very experimental and unsupported.

run_unless_marker_file_exists("text_mate_1_5_10") do
  execute "download text mate to temp dir" do
    command "curl -o /tmp/textmate.zip http://dl.macromates.com/TextMate_1.5.10_r1623.zip"
    user WS_USER
  end
  
  execute "extract text mate to /Applications" do
    command 'unzip -o  textmate.zip -x __MACOSX* -d /Applications/'
    user WS_USER
  end
  
  execute "link textmate" do
    command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
    not_if "test -e /usr/local/bin/mate"
  end
end
