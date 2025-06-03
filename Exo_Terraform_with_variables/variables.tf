# Backend
variable "backend_storage_account_name" {}
variable "backend_container_name" {}
variable "backend_key" {}
variable "backend_access_key" {}

# Subscription
variable "subscription" {}

# RG, Location
variable "resource_group_name" {}
variable "location" {}

# VNet & Subnet
variable "vnet_name" {}
variable "vnet_address_space" {}
variable "subnet_name" {}
variable "subnet_address_prefix" {}

# Availability Set
variable "availability_set_name" {}

# NIC
variable "nic_name" {}
variable "nic_configuration_name" {}

# VM
variable "vm_name" {}
variable "vm_size" {}
variable "os_disk_name" {}
variable "os_disk_type" {}

# Admin credentials
variable "admin_username" {}
variable "admin_password" {}

# Image
variable "image_publisher" {}
variable "image_offer" {}
variable "image_sku" {}
variable "image_version" {}
