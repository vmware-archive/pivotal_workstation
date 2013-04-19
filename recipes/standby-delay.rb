Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

# http://www.ewal.net/2012/09/09/slow-wake-for-macbook-pro-retina/
# "Fixing" Slow Wake for MacBook Pro w/ Retina Display and MacBook Air

execute "pmset -a standbydelay 86400"
