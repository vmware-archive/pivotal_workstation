node.default["nginx_settings"]= {
  "server_name" => "localhost.local",
  "server_port" => 8080,
  "server_document_root"=> "/var/www/apps/example/current/public"
}

node.default["ssl_settings"]= {
  "common_name" => "*.local",
  "cert_path" => "/usr/local/etc/certificates",
  "ca_path" => "/usr/local/etc/certificates/demoCA"
}
