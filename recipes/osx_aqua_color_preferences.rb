Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

aqua_color_variant_blue = 1
aqua_color_variant_graphite = 6

pivotal_workstation_defaults "Set aqua appearance color variant" do
  domain "/Users/#{WS_USER}/Library/Preferences/.GlobalPreferences"
  key "AppleAquaColorVariant"
  integer aqua_color_variant_graphite
end
