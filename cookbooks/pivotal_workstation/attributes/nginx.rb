node.default["nginx_settings"]= {
  "server_name" => "localhost.local",
  "server_port" => 8888,
  "server_document_root"=> "/var/www/apps/example/current/public"
}

node.default["ssl_settings"]= {
  "common_name" => "localhost",
  "cert_path" => "/usr/local/etc/certificates",
  "ca_path" => "/usr/local/etc/certificates/demoCA"
}