%w{Icons Backgrounds}.each do |dir|
  directory "#{WS_HOME}/Pictures/#{dir}" do
    mode "0755"
    owner WS_USER
    :recursive
  end
end

%w{blue green orange violet}.each do |color|
  filename="pivID_#{color}-1004x400.png"
  remote_file "#{WS_HOME}/Pictures/Backgrounds/#{filename}" do
    source "http://cheffiles.pivotallabs.com/#{filename}"
    :create_if_missing
  end
end

%w{BackToTheEdward.png}.each do |filename|
  remote_file "#{WS_HOME}/Pictures/Backgrounds/#{filename}" do
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
