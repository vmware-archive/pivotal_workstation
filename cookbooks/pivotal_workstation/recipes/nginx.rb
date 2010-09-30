include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ssl_certificate"

run_unless_marker_file_exists("nginx_7_67") do
  brew_install "nginx"
  
  template "/usr/local/etc/nginx/nginx.conf" do
    source "nginx.conf.erb"
    owner WS_USER
  end
  
  execute "stop nginx, don't worry if it can't" do
    command "/usr/local/sbin/nginx -s stop || true"
  end
  
  execute "start nginx" do
    command "/usr/local/sbin/nginx"
  end

  execute "test that the self signed cert is accepted as valid" do
    command "curl https://localhost/"
  end

end

