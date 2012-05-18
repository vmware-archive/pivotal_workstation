cert_path = node["ssl_settings"]["cert_path"]
ca_path = node["ssl_settings"]["ca_path"]

run_unless_marker_file_exists("ssl_certificate") do
  ["/usr/local", "/usr/local/etc", cert_path, ca_path, "#{ca_path}/keys", "#{ca_path}/requests", "#{ca_path}/certs", "#{ca_path}/newcerts"].each do |dir|
    directory dir do
      recursive true
      owner WS_USER
    end
  end

  ["touch #{ca_path}/index.txt",
   "echo '01\n' > #{ca_path}/serial",
   "openssl genrsa -des3 -passout pass:password -out #{ca_path}/keys/ca.key 1024",
   "cd #{ca_path} && openssl req -new -x509 -days 1001 -key #{ca_path}/keys/ca.key -passin pass:password -out #{ca_path}/certs/ca.cert -subj '/CN=mydomain.com/OU=Org Unit/O=My Org Pty Ltd/L=Sydney/ST=NSW/C=AU/emailAddr=someone@example.com'",
  ].each do |ssl_cmd|
    execute ssl_cmd
  end

  execute "trust our CA" do
    command "security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain #{ca_path}/certs/ca.cert"
  end

  ["openssl genrsa 1024 > #{cert_path}/server.key",
   "openssl req -new -key #{cert_path}/server.key -out #{cert_path}/request.csr -subj '/CN=#{node["ssl_settings"]["common_name"]}/OU=Org Unit/O=My Org Pty Ltd/L=Sydney/ST=NSW/C=AU/emailAddr=someoneATexample.com'",
   "cd #{cert_path} && openssl ca -policy policy_anything -cert #{ca_path}/certs/ca.cert -batch -in #{cert_path}/request.csr -passin pass:password  -keyfile #{ca_path}/keys/ca.key -days 9999 -out #{cert_path}/signed.cert",
  ].each do |ssl_cmd|
    execute ssl_cmd
  end
end
