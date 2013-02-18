dmg_package "Adium" do
  volumes_dir "Adium 1.5.4"
  source node["adium"]["source"]
  checksum node["adium"]["checksum"]
  action :install
  owner WS_USER
  destination node["adium"]["destination"]
end