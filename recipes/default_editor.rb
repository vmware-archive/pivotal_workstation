include_recipe "pivotal_workstation::textmate"

# This sets TextMate to be the default editor for
# .xml, .rb, .erb, .plain-text, .yml, .yaml
#ls_handler_role_all="com.macromates.textmate"
ls_handler_role_all="com.macromates.textmate"
gem_package("plist")

plist_file = "#{ENV['HOME']}/Library/Preferences/com.apple.LaunchServices.plist"
ruby_block "Set the default editor" do
  block do
    Gem.clear_paths
    require 'rubygems'
    require 'plist'
    `plutil -convert xml1 #{plist_file}`
    ls_handler_plist = Plist::parse_xml(plist_file)
    new_ls_handlers = [
      { "LSHandlerContentType" => "public.plain-text",
        "LSHandlerRoleAll" => ls_handler_role_all
      },
      { "LSHandlerContentType" => "public.ruby-script",
        "LSHandlerRoleAll" => ls_handler_role_all
      },
      { "LSHandlerContentType" => "org.vim.yaml-file",
        "LSHandlerRoleAll" => ls_handler_role_all
      },
      { "LSHandlerContentType" => "public.xml",
        "LSHandlerRoleAll" => ls_handler_role_all
      }
    ]
    # I go through the old_ls_handlers and remove all
    # the ones that we're going to replace.
    new_ls_handlers.each do |new_hash|
      new_hash.each do |new_key,new_value|
        if new_key == "LSHandlerContentType"
          ls_handler_plist["LSHandlers"].each do |old_hash|
            old_hash.each do |old_key,old_value|
              if new_value == old_value and new_key == old_key
                ls_handler_plist["LSHandlers"].delete(old_hash)
              end
            end
          end
        end
      end
    end
    ls_handler_plist["LSHandlers"] = ls_handler_plist["LSHandlers"] + new_ls_handlers
    File.open(plist_file, "w") do |plist_handle|
      plist_handle.puts Plist::Emit.dump(ls_handler_plist)
    end
    # rebuild the launch services database; this took 6 hours to figure out.
    `su #{WS_USER} -c "/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user"`
    # restart the Finder with the new icons
    `killall Finder`
  end
end
