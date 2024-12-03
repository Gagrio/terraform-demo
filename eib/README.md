### This is an example of using EIB to create an image that can be used by Terraform to spin up VMs with libvirt.
#### Please use this only if you can already push the SLE Micro base image to the machine you are building from (which needs to be in the same arch as the target VM).
#### Otherwise you can use the cloud-init option of the libvirt terraform provider to spin up a VM with the desired OS and configuration.
