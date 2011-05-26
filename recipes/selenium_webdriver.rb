webdriver_location = "http://selenium.googlecode.com/files/chromedriver_mac_12.0.712.0.zip"

run_unless_marker_file_exists("selenium_webdriver") do
  execute "download webdriver" do
    command "curl -o /tmp/webdriver.zip #{webdriver_location}"
    user WS_USER
  end
  
  execute "unzip" do
    command "unzip -f /tmp/webdriver.zip chromedriver -d /usr/bin/"
    user WS_USER
  end
end
