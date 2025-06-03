terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.77.0"
    }
  }

  backend "azurerm" {
    storage_account_name = var.backend_storage_account_name
    container_name       = var.backend_container_name
    key                  = var.backend_key
    access_key           = var.backend_access_key
  }
}

provider "azurerm" {
  subscription_id = var.subscription
  features {}
}

resource "azurerm_resource_group" "my_resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "my_vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
}

resource "azurerm_subnet" "my_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.my_resource_group.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

resource "azurerm_availability_set" "my_availability_set" {
  name                = var.availability_set_name
  location            = var.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
}

resource "azurerm_network_interface" "my_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = azurerm_resource_group.my_resource_group.name

  ip_configuration {
    name                          = var.nic_configuration_name
    subnet_id                     = azurerm_subnet.my_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "my_vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.my_resource_group.name
  availability_set_id   = azurerm_availability_set.my_availability_set.id
  network_interface_ids = [azurerm_network_interface.my_nic.id]

  vm_size                         = var.vm_size
  delete_os_disk_on_termination  = true

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name              = var.os_disk_name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.os_disk_type
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
