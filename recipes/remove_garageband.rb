# This is obviously a destructive recipe.

run_unless_marker_file_exists("removing garage band") do
  execute "Deleting Garage Band Support Files" do
    command "rm -rf /Library/Application\ Support/GarageBand"
  end
  
  execute "Deleting Garage Band Application" do
    command "rm -rf /Applications/GarageBand.app"
  end
end