webdriver_location = "http://selenium.googlecode.com/files/chromedriver_mac_13.0.775.0.zip"

run_unless_marker_file_exists("selenium_webdriver_13_0_775") do
  execute "download webdriver" do
    command "curl -o /tmp/webdriver.zip #{webdriver_location}"
    user WS_USER
  end
  
  execute "unzip" do
    command "unzip -o /tmp/webdriver.zip chromedriver -d /usr/bin/"
  end
end
