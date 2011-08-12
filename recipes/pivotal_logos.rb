%w{Icons BackgroundsPrimary BackgroundsSecondary}.each do |dir|
  directory "#{WS_HOME}/Pictures/#{dir}" do
    mode "0755"
    owner WS_USER
    :recursive
  end
end

%w{blue green orange violet}.each do |color|
  filename="pivID_#{color}-1004x400.png"
  remote_file "#{WS_HOME}/Pictures/BackgroundsPrimary/#{filename}" do
    source "http://cheffiles.pivotallabs.com/#{filename}"
    :create_if_missing
  end
end

%w{BackToTheEdward.png}.each do |filename|
  remote_file "#{WS_HOME}/Pictures/BackgroundsSecondary/#{filename}" do
    source "http://cheffiles.pivotallabs.com/#{filename}"
    :create_if_missing
  end
end

%w{Pivot.jpeg Pivotal\ Tracker.png}.each do |filename|
  remote_file "#{WS_HOME}/Pictures/Icons/#{filename}" do
    filename = filename.gsub(" ","%20")
    source "http://cheffiles.pivotallabs.com/#{filename}"
    :create_if_missing
  end
end

ruby_block "install the pivotal tracker picture" do
  block do
    `dscl . delete /Users/#{WS_USER} JPEGPhoto`
    `dscl . create /Users/#{WS_USER} Picture "#{WS_HOME}/Pictures/Icons/Pivotal Tracker.png"`
  end
end

gem_package("plist")

ruby_block "install the pivotal backgrounds" do
  block do
    `dscl . delete /Users/#{WS_USER} JPEGPhoto`
    `dscl . create /Users/#{WS_USER} Picture "#{WS_HOME}/Pictures/Icons/Pivotal Tracker.png"`

    Gem.clear_paths
    require 'rubygems'

    require 'plist'
    # FIXME:  if plist  doesn't exist, create it.
    plist_file = "#{ENV['HOME']}/Library/Preferences/com.apple.desktop.plist"
    `plutil -convert xml1 #{plist_file}`
    desktop_plist = Plist::parse_xml(plist_file)
    desktop_plist["Background"] =
      { "default" =>
        { "BackgroundColor" =
            [ 0.0, 0.250980406999588, 0.501960813999176 ],
          "Change" => "TimeInterval",
          "ChangePath" => "/Users/pivotal/Pictures/BackgroundsPrimary",
          "ChangeTime" => 5.0,
          "DSKDesktopPrefPane" => {
            "UserFolderPaths" = [
              "/Users/pivotal/Pictures/BackgroundsPrimary",
              "/Users/pivotal/Pictures/BackgroundsSecondary"
            ]
          }
          "DrawBackgroundColor" => true,
          "LastName" => "pivID_orange-1004x400.png",
          "NewChangePath" => "~/Pictures/BackgroundsPrimary",
          "NoImage" => false,
          "Placement" => "Centered",
          "Random" => false,
        },
      }
  end
end


