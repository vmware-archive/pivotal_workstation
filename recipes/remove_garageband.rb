# This is obviously a destructive recipe.

directory "/Library/Application\ Support/GarageBand" do
  action :delete
  recursive true
end

directory "/Applications/GarageBand.app" do
  action :delete
  recursive true
end