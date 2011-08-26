include_recipe "pivotal_workstation::user_owns_usr_local"

unless File.exists?("/Applications/TextMate.app")
  execute "download text mate to temp dir" do
    command "curl -o /tmp/textmate.zip http://dl.macromates.com/TextMate_1.5.10_r1623.zip"
    user WS_USER
  end

  execute "extract text mate to /Applications" do
    command 'unzip -o /tmp/textmate.zip -x __MACOSX* -d /Applications/'
    user WS_USER
  end

  execute "link textmate" do
    command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
    not_if "test -e /usr/local/bin/mate"
  end

  ruby_block "test to see if TextMate was installed" do
    block do
      raise "TextMate install failed" unless File.exists?("/Applications/TextMate.app")
    end
  end
end

execute "link textmate" do
  command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
  not_if "test -e /usr/local/bin/mate"
end
