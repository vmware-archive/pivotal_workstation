pivotal_workstation_defaults "Make Safari’s search banners default to Contains instead of Starts With" do
  domain 'com.apple.Safari'
  key 'FindOnPageMatchesWordStartsOnly'
  boolean false
end
