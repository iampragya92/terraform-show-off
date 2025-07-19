# to create resource group for todoapp

module "resource_group" {

    source = "../modules/azurerm_resource_group"
    resource_group_name = "rg-todoapp"
    location = "uksouth"
}

#code to create virtual network for todoapp
module "vnet" {
    source = "../modules/azurerm_virtual_network"
    vnet_name = "vnet-todoapp"
    resource_group_name = "rg-todoapp"
    location = "uksouth"
    address_space = ["10.0.0.0/16"]
  
}

# module to create frontend subnet
module "subnet" {
    source = "../modules/azurerm_subnet"
    subnet_name = "frontend-todoapp"
    resource_group_name = "rg-todoapp"
    vnet_name = "vnet-todoapp"
    address_prefixes = ["10.0.1.0/24"]
}


# module to create backend subnet
module "subnet" {
    source = "../modules/azurerm_subnet"
    subnet_name = "backend-todoapp"
    resource_group_name = "rg-todoapp"
    vnet_name = "vnet-todoapp"
    address_prefixes = ["10.0.2.0/24"]
}