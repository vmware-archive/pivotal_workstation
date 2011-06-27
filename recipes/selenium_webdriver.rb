webdriver_location = "http://selenium.googlecode.com/files/chromedriver_mac_13.0.775.0.zip"

run_unless_marker_file_exists("selenium_webdriver_13_0_775_3") do
  execute "download webdriver" do
    command "curl -o /tmp/webdriver.zip #{webdriver_location}"
    user WS_USER
  end
  
  execute "unzip" do
    command "unzip -o /tmp/webdriver.zip chromedriver -d /usr/bin/"
  end
end

file "/usr/bin/chromedriver" do
  mode "0755"
end

execute "create chromium.app symlink" do
  command 'rm  -f "/Applications/Chromium.app" && ln -s "/Applications/Google Chrome.app" "/Applications/Chromium.app"'
end

execute "create contents symlink" do
  command 'rm -f "/Applications/Chromium.app/Contents/MacOS/Chromium" && ln -s "/Applications/Chromium.app/Contents/MacOS/Google Chrome" "/Applications/Chromium.app/Contents/MacOS/Chromium"'
end
