Vagrant.configure("2") do |config|
  # Define the VM name and provider
  config.vm.define "fedora_vm" do |fedora_vm|
    # Specify the libvirt provider (this will use KVM by default)
    fedora_vm.vm.provider :libvirt do |libvirt|
      libvirt.memory = 4096  # Set memory (MB)
      libvirt.cpus = 2       # Set CPU count
      libvirt.storage :file, size: '20G'  # Set disk size (20GB)
      libvirt.nic_model_type = "virtio"   # Use virtio for networking
    end

    # Set up the VM network (DHCP IP)
    fedora_vm.vm.network "private_network", type: "dhcp"

    # Define the ISO file for installation
    fedora_vm.vm.provider :libvirt do |libvirt|
      libvirt.iso_path = "/downloads/fedora.iso"  # Path to the Fedora ISO
      libvirt.boot_order = 'dvd'  # Boot from the DVD (ISO)
    end

    # Optional: You can also specify some additional VM settings if needed, such as
    # SSH settings or custom provisioning.
  end
end
