return unless node['platform'] == 'mac_os_x'

FORMULA = 'android-sdk'
HAXM_PKG = 'IntelHAXM_1.0.1'

brew FORMULA

execute "update Android SDK packages" do
  command 'android update sdk --no-ui'
  user WS_USER
end

SDK_ROOT = `brew --prefix #{FORMULA}`.strip

# Symlink to cache dir so dmg_package can load the file
link "#{Chef::Config[:file_cache_path]}/#{HAXM_PKG}.dmg" do
  to "#{SDK_ROOT}/extras/intel/Hardware_Accelerated_Execution_Manager/haxm-macosx_r02.dmg"
end

dmg_package HAXM_PKG do
  owner WS_USER
  type "mpkg"
  not_if "kextstat | grep 'com.intel.kext.intelhaxm'"
end

