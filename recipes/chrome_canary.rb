dmg_package "Google Chrome Canary" do
  dmg_name "GoogleChromeCanary"
  source "https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg"
  checksum "897988ba0b87c936992afedec56efa10a23307786913685ef9ad97f2c6629227"
  action :install
  owner WS_USER
end
