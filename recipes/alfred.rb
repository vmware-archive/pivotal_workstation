pivotal_workstation_package "Alfred" do
  volumes_dir "Alfred.app"
  source "http://cachefly.alfredapp.com/alfred_1.3_249.dmg"
  checksum "2f6924d537e35997075bd411199edcfdf19a21f607b613932c0c60df8a09e7c9"
  action :install
end
