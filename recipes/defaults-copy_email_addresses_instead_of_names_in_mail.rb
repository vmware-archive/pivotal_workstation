pivotal_workstation_defaults "Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app" do
  domain 'com.apple.mail'
  key 'AddressesIncludeNameOnPasteboard'
  boolean false
end
