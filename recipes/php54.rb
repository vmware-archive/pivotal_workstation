include_recipe "pivotal_workstation::homebrew"

execute "tap the josegonzalez repo" do
    command "brew tap josegonzalez/php"
    not_if { system("brew tap | grep 'josegonzalez' > /dev/null 2>&1") }
end

execute "tap the dupes repo" do
    command "brew tap homebrew/dupes"
    not_if { system("brew tap | grep 'dupes' > /dev/null 2>&1") }
end

brew_install "php54", {:brew_args => "--with-mysql --with-pgsql"}

brew_install "php54-apc"
brew_install "php54-memcached"
brew_install "php54-inclued"
brew_install "php54-http"
brew_install "php54-xdebug"
brew_install "php54-intl"
brew_install "php54-yaml"
brew_install "php54-imagick"
brew_install "php54-solr"
brew_install "php54-twig"
