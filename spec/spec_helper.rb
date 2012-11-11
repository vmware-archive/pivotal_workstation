require 'rspec'
require 'godot'
require 'lobot/sobo'

class FusionHelper
  def vmware_cmd
    "/Applications/VMware Fusion.app/Contents/Library/vmrun"
  end

  def vmware_vmx
    "/Users/pivotal/Documents/pivotal-workstation-ci.vmwarevm/pivotal-workstation-ci.vmx"
  end

  def start_vm
    system(vmware_cmd, "start", vmware_vmx)
  end

  def revert_to(snapshot)
    start_vm
    system(vmware_cmd, "revertToSnapshot", vmware_vmx, snapshot)
    start_vm
  end
end