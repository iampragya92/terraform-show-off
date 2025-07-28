# to create resource group for todoapp

module "resource_group" {

  source              = "../modules/azurerm_resource_group"
  resource_group_name = "rg-todoapp"
  location            = "uksouth"
}



module "resource_group_india" {

  source              = "../modules/azurerm_resource_group"
  resource_group_name = "rg-india"
  location            = "centralindia"
}

#code to create virtual network for todoapp
module "vnet" {

  depends_on = [ module.resource_group ]
  source              = "../modules/azurerm_virtual_network"
  vnet_name           = "vnet-todoapp"
  resource_group_name = "rg-todoapp"
  location            = "uksouth"
  address_space       = ["10.0.0.0/16"]

}

# module to create frontend subnet
module "frontend_subnet" {
  depends_on = [ module.vnet ]
  source              = "../modules/azurerm_subnet"
  subnet_name         = "frontend-todoapp"
  resource_group_name = "rg-todoapp"
  vnet_name           = "vnet-todoapp"
  address_prefixes    = ["10.0.1.0/24"]
}


# module to create backend subnet
module "backend_subnet" {
  depends_on = [ module.vnet ]
  source              = "../modules/azurerm_subnet"
  subnet_name         = "backend-todoapp"
  resource_group_name = "rg-todoapp"
  vnet_name           = "vnet-todoapp"
  address_prefixes    = ["10.0.2.0/24"]
}


#module to create frontend vm 

module "frontend_vm" {

  depends_on = [ module.frontend_subnet ]

  source              = "../modules/azurerm_linux_virtual_machine"
  nic_name            = "frontend_vm_nic"
  location            = "uksouth"
  resource_group_name = "rg-todoapp"
  vm_name             = "frontend_vm"
  vm_size             = "StandardB1s"
  vm_admin_name       = "useradmin"
  admin_password      = "Redhat@123"
  image_publisher     = "Canonical"
  image_offer         = "0001-com-ubuntu-server-jammy"
  image_sku           = "22_04-lts"
  image_version       = "latest"
  vnet_name           = "vnet-todoapp"
  subnet_name         = "frontend-todoapp"

}


#create module for log analytics workspace 


module "log_analytics_workspace" {

  source = "../modules/azurerm_log_analytics_workspace"
  law_name = "my-log-analytics-workspace"
  location = "uksouth"
  resource_group_name = "rg-todoapp"
  
}