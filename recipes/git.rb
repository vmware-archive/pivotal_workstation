unless system("git --version | grep 'git version' > /dev/null")
  include_recipe "homebrew"

  package "git"
end
