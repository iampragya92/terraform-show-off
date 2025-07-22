resource "azurerm_network_interface" "nic" {
    name = var.nic_name 
    location = var.location
    resource_group_name = var.resource_group_name

     ip_configuration {
      
      name =  "internal"
      subnet_id = data.azurerm_subnet.frontend_subnet.id
      private_ip_address_allocation = "dynamic"

    }


  
}




data "azurerm_subnet" "frontend_subnet" {

     name = var.subnet_name
     virtual_network_name = var.vnet_name
     resource_group_name = var.resource_group_name

    }

resource "azurerm_linux_virtual_machine" "frontend_vm" {
  
  name = var.vm_name
  location = var.location
  resource_group_name = var.resource_group_name
  size = var.vm_size
  network_interface_ids = [azurerm_network_interface.nic.id]
  admin_username = var.vm_admin_name
  admin_password = var.admin_password
  disable_password_authentication = false

  os_disk {
    storage_account_type = "Standard_LRS"
    caching = "ReadWrite"
  }
  

  source_image_reference {
    
    publisher = var.image_publisher
    offer = var.image_offer
    sku = var.image_sku
    version = var.image_version

  }
 
   

}