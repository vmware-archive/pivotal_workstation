include_recipe "pivotal_workstation::user_owns_usr_local"

zip_app_install(:app => "textmate", :uri => "http://dl.macromates.com/TextMate_1.5.10_r1631.zip")

execute "link textmate" do
  command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
  not_if "test -e /usr/local/bin/mate"
end