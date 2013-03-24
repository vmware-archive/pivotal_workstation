include_recipe "pivotal_workstation::homebrew"

execute "tap the josegonzalez repo" do
    command "brew tap josegonzalez/php"
    not_if { system("brew tap | grep 'josegonzalez' > /dev/null 2>&1") }
end

execute "tap the dupes repo" do
    command "brew tap homebrew/dupes"
    not_if { system("brew tap | grep 'dupes' > /dev/null 2>&1") }
end

brew "php54", {:brew_args => "--with-mysql --with-pgsql"}

brew "php54-apc"
brew "php54-memcached"
brew "php54-inclued"
brew "php54-http"
brew "php54-xdebug"
brew "php54-intl"
brew "php54-yaml"
brew "php54-imagick"
brew "php54-solr"
brew "php54-twig"
