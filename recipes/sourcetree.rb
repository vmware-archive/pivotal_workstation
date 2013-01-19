dmg_package "SourceTree" do
  volumes_dir "SourceTree"
  source "http://downloads.atlassian.com/software/sourcetree/SourceTree_1.5.7.dmg"
  checksum "3ee601004b1f7e492428f86b733c6aec"
  action :install
  owner WS_USER
end
