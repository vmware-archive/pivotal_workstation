include_recipe "pivotal_workstation::textmate"

pivotal_workstation_defaults "set save on losing focus" do
  domain '~/Library/Preferences/com.macromates.textmate'
  key 'OakSaveAllOnDeactivate'
  boolean true
end

pivotal_workstation_defaults "show line numbers" do
  domain '~/Library/Preferences/com.macromates.textmate'
  key 'OakTextViewLineNumbersEnabled'
  boolean true
end

gem_package("plist")

plist_file = "#{ENV['HOME']}/Library/Preferences/com.macromates.textmate.plist"
ruby_block "soft tabs & tabs stop of 2" do
  block do
    Gem.clear_paths
    require 'rubygems'
    require 'plist'
    require 'time'
    # FIXME:  if plist  doesn't exist, create it.
    `plutil -convert xml1 #{plist_file}`
    tmate_plist = Plist::parse_xml(plist_file)
    tmate_plist["OakTextViewLineNumbersEnabled"] = true
    tmate_plist["OakTextViewScopedSoftTabs"] =
      { "source.catch-all" =>
        { "softTabs" => false,
          "updated" => Time.parse("2011-07-14T18:59:17Z")
        },
        "source.plist" =>
        { "softTabs" => true,
          "updated" => Time.parse("0000-12-30T00:00:00Z")
        },
        "source.ruby" =>
        { "softTabs" => true,
          "updated" => Time.parse("0000-12-30T00:00:00Z")
        },
        "source.yaml" =>
        { "softTabs" => true,
          "updated" => Time.parse("0000-12-30T00:00:00Z")
        },
        "text.catch-all" =>
        { "softTabs" => false,
          "updated" => Time.parse("2011-07-14T18:59:17Z")
        },
        "text.plain" =>
        { "softTabs" => true,
          "updated" => Time.parse("0000-12-30T00:00:00Z")
        }
      }
    tmate_plist["OakTextViewScopedTabSize"] =
      { "source.catch-all" =>
        { "tabSize" => 4,
          "updated" => Time.parse("2011-07-14T18:59:17Z")
        },
        "source.plist" =>
        { "tabSize" => 2,
          "updated" => Time.parse("0000-12-30T00:00:00Z")
        },
        "source.ruby" =>
        { "tabSize" => 2,
          "updated" => Time.parse("0000-12-30T00:00:00Z")
        },
        "source.yaml" =>
        { "tabSize" => 2,
          "updated" => Time.parse("0000-12-30T00:00:00Z")
        },
        "text.catch-all" =>
        { "tabSize" => 4,
          "updated" => Time.parse("2011-07-14T18:59:17Z")
        },
        "text.plain" =>
        { "tabSize" => 2,
          "updated" => Time.parse("0000-12-30T00:00:00Z")
        }
      }
    puts Plist::Emit.dump(tmate_plist["OakTextViewScopedTabSize"])
    File.open(plist_file, "w") do |plist_handle|
      plist_handle.puts Plist::Emit.dump(tmate_plist)
    end
  end
end
