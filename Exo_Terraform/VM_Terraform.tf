# Fichier main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.77.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "testericplancheweu001"
    container_name       = "testdeploy"
    key                  = "vm_deploy.tfstate"
    access_key           = "oR/BcttX3BFV40I1NnyKjP3VpYfNrGjO7LtRiTVmrmmouDcHiRXjM2TZYXEYWF9R7iuRN/POJox4+AStDFnWeg=="

  }
}

provider "azurerm" {
  subscription_id = var.subscription
  features {}
}

# Déclaration du groupe de ressources
resource "azurerm_resource_group" "my_resource_group" {
  name     = "rg-ericplanche-sandbox2-weu"
  location = "West Europe"
}

# Déclaration du réseau virtuel
resource "azurerm_virtual_network" "my_vnet" {
  name                = "vnettestericplancheweu001"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name
}

# Déclaration du sous-réseau
resource "azurerm_subnet" "my_subnet" {
  name                 = "subnettestericplancheweu001"
  resource_group_name  = azurerm_resource_group.my_resource_group.name
  virtual_network_name = azurerm_virtual_network.my_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Déclaration de la machine virtuelle
resource "azurerm_virtual_machine" "my_vm" {
  name                  = "testericplancheweu001"
  resource_group_name   = azurerm_resource_group.my_resource_group.name
  location              = azurerm_resource_group.my_resource_group.location
  availability_set_id   = azurerm_availability_set.my_availability_set.id
  network_interface_ids = [azurerm_network_interface.my_nic.id]

  vm_size              = "Standard_DS1_v2"
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "20.04.202209200"
  }

  storage_os_disk {
    name              = "testericplancheweu001OsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "testericplancheweu001"
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# Déclaration de l'ensemble de disponibilité (optionnel)
resource "azurerm_availability_set" "my_availability_set" {
  name                = "testericplancheweu001AS"
  resource_group_name = azurerm_resource_group.my_resource_group.name
  location            = azurerm_resource_group.my_resource_group.location

}

# Déclaration de l'interface réseau
resource "azurerm_network_interface" "my_nic" {
  name                = "testericplancheweu001NIC"
  location            = azurerm_resource_group.my_resource_group.location
  resource_group_name = azurerm_resource_group.my_resource_group.name

  ip_configuration {
    name                          = "testericplancheweu001NIConf"
    subnet_id                     = azurerm_subnet.my_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
