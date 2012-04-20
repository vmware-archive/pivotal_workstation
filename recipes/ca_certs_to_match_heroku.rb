["/usr/lib/ssl", "/usr/lib/ssl/certs/"].each do |dir|
  directory dir do
    owner WS_USER
  end
end

cookbook_file "/usr/lib/ssl/certs/ca-certificates.crt" do
  source "cacert.pem"
  mode "0444"
end
