execute "set iterm default terminal settings" do
  command %$defaults write ~/Library/Preferences/net.sourceforge.iTerm Terminals -dict-add Default '{
        "Auto Close" = 1;
        Blink = 0;
        "Default Profile" = Yes;
        "Double Width" = 1;
        Encoding = 4;
        "Idle Char" = 0;
        Scrollback = 60000;
        "Send Idle Char" = 0;
        "Silence Bell" = 1;
        "Term Type" = xterm;
    }'
    $
  user WS_USER
end
  
execute "use the darm background" do
   command %$defaults write ~/Library/Preferences/net.sourceforge.iTerm Bookmarks -dict-add Entries  ' (
                {
            Data =             {
                Command = "login -fp #{WS_USER}";
                "Default Bookmark" = Yes;
                Description = "login -fp #{WS_USER}";
                "Display Profile" = "Dark Background";
                "Keyboard Profile" = Global;
                Name = Default;
                Shortcut = "";
                "Terminal Profile" = Default;
                "Working Directory" = "/Users/#{WS_USER}";
            };
            Entries =             (
            );
        }
    )'$
    user WS_USER
end

execute "set the colors" do
  command %$defaults write ~/Library/Preferences/net.sourceforge.iTerm Displays -dict-add "Dark Background" '{
        "Ansi 0 Color" =         {
            "Blue Component" = 0;
            "Green Component" = 0;
            "Red Component" = 0;
        };
        "Ansi 1 Color" =         {
            "Blue Component" = 0;
            "Green Component" = 0;
            "Red Component" = "0.7333333492279053";
        };
        "Ansi 10 Color" =         {
            "Blue Component" = "0.3333333432674408";
            "Green Component" = 1;
            "Red Component" = "0.3333333432674408";
        };
        "Ansi 11 Color" =         {
            "Blue Component" = "0.3333333432674408";
            "Green Component" = 1;
            "Red Component" = 1;
        };
        "Ansi 12 Color" =         {
            "Blue Component" = 1;
            "Green Component" = "0.3333333432674408";
            "Red Component" = "0.3333333432674408";
        };
        "Ansi 13 Color" =         {
            "Blue Component" = 1;
            "Green Component" = "0.3333333432674408";
            "Red Component" = 1;
        };
        "Ansi 14 Color" =         {
            "Blue Component" = 1;
            "Green Component" = 1;
            "Red Component" = "0.3333333432674408";
        };
        "Ansi 15 Color" =         {
            "Blue Component" = 1;
            "Green Component" = 1;
            "Red Component" = 1;
        };
        "Ansi 2 Color" =         {
            "Blue Component" = 0;
            "Green Component" = "0.7333333492279053";
            "Red Component" = 0;
        };
        "Ansi 3 Color" =         {
            "Blue Component" = 0;
            "Green Component" = "0.7333333492279053";
            "Red Component" = "0.7333333492279053";
        };
        "Ansi 4 Color" =         {
            "Blue Component" = "0.7333333492279053";
            "Green Component" = 0;
            "Red Component" = 0;
        };
        "Ansi 5 Color" =         {
            "Blue Component" = "0.7333333492279053";
            "Green Component" = 0;
            "Red Component" = "0.7333333492279053";
        };
        "Ansi 6 Color" =         {
            "Blue Component" = "0.7333333492279053";
            "Green Component" = "0.7333333492279053";
            "Red Component" = 0;
        };
        "Ansi 7 Color" =         {
            "Blue Component" = "0.7333333492279053";
            "Green Component" = "0.7333333492279053";
            "Red Component" = "0.7333333492279053";
        };
        "Ansi 8 Color" =         {
            "Blue Component" = "0.3333333432674408";
            "Green Component" = "0.3333333432674408";
            "Red Component" = "0.3333333432674408";
        };
        "Ansi 9 Color" =         {
            "Blue Component" = "0.3333333432674408";
            "Green Component" = "0.3333333432674408";
            "Red Component" = 1;
        };
        "Anti Alias" = 1;
        "Background Color" =         {
            "Blue Component" = 0;
            "Green Component" = 0;
            "Red Component" = 0;
        };
        "Bold Color" =         {
            "Blue Component" = "0.4901960784313725";
            "Green Component" = "0.4901960784313725";
            "Red Component" = 1;
        };
        Columns = 80;
        "Cursor Color" =         {
            "Blue Component" = "0.7333333492279053";
            "Green Component" = "0.7333333492279053";
            "Red Component" = "0.7333333492279053";
        };
        "Cursor Text Color" =         {
            "Blue Component" = 1;
            "Green Component" = 1;
            "Red Component" = 1;
        };
        "Disable Bold" = 0;
        Font = "Monaco 12";
        "Foreground Color" =         {
            "Blue Component" = "0.7333333492279053";
            "Green Component" = "0.7333333492279053";
            "Red Component" = "0.7333333492279053";
        };
        "Horizontal Character Spacing" = 1;
        NAFont = "Monaco 12";
        Rows = 24;
        "Selected Text Color" =         {
            "Blue Component" = 0;
            "Green Component" = 0;
            "Red Component" = 0;
        };
        "Selection Color" =         {
            "Blue Component" = 1;
            "Green Component" = "0.8353000283241272";
            "Red Component" = "0.7098000049591064";
        };
        Transparency = 0;
        "Vertical Character Spacing" = 1;
    }'$
    user WS_USER
  end