dmg_package "SourceTree" do
  volumes_dir "SourceTree"
  source "http://downloads.atlassian.com/software/sourcetree/SourceTree_1.5.7.1.dmg"
  checksum "cf4f758d3083c6275d7447eacb2d798870d8adddd7a45434e8346bc585ce6d3b"
  action :install
  owner WS_USER
end
