backend_storage_account_name = "testericplancheweu001"
backend_container_name       = "testdeploy"
backend_key                  = "vm_deploy.tfstate"
backend_access_key           = "oR/BcttX3BFV40I1NnyKjP3VpYfNrGjO7LtRiTVxxxxxxx"

subscription                = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
resource_group_name         = "rg-ericplanche-sandbox-weu"
location                    = "West Europe"

vnet_name                   = "vnettestericplancheweu001"
vnet_address_space          = "10.0.0.0/16"
subnet_name                 = "subnettestericplancheweu001"
subnet_address_prefix       = "10.0.1.0/24"

availability_set_name       = "testericplancheweu001AS"

nic_name                    = "testericplancheweu001NIC"
nic_configuration_name      = "testericplancheweu001NIConf"

vm_name                     = "testericplancheweu001"
vm_size                     = "Standard_DS1_v2"
os_disk_name                = "testericplancheweu001OsDisk"
os_disk_type                = "Premium_LRS"

admin_username              = "adminuser"
admin_password              = "Password1234!"  # Consider using environment variables for this

image_publisher             = "Canonical"
image_offer                 = "0001-com-ubuntu-server-focal"
image_sku                   = "20_04-lts-gen2"
image_version               = "20.04.202209200"
