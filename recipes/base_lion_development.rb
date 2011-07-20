include_recipe "pivotal_workstation::git_scripts"
include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::gitx"
include_recipe "pivotal_workstation::turn_on_ssh"
include_recipe "pivotal_workstation::enable_screen_sharing"
include_recipe "pivotal_workstation::postgres"
include_recipe "pivotal_workstation::gem_no_rdoc_no_ri"
#include_recipe "pivotal_workstation::mysql"  # broken
