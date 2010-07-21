include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ssl_certificate"

run_unless_marker_file_exists("nginx_7_67") do
  brew_install "nginx"
  
  template "/usr/local/etc/nginx/nginx.conf" do
    source "nginx.conf.erb"
    owner WS_USER
  end
  
  execute "reload nginx" do
    command "/usr/local/sbin/nginx -s reload"
  end
end

