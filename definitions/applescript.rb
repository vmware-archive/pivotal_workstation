define :applescript do
  if params[:script]
    script = params[:script]
    name = params[:name]
  else
    script = params[:name]
    name = "applescript-#{Time.now.to_i}"
  end
  script.gsub!('"', '\\"')

  execute "applescript-" do
    only_if params[:only_if] if params[:only_if]
    not_if params[:not_if] if params[:not_if]
    command "osascript -e \"#{script}\""
    user params[:user] || WS_USER
  end
end

