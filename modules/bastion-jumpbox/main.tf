# 1. Public IP for Azure Bastion Host
resource "azurerm_public_ip" "bastion" {
  name                = "pip-bastion-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# 2. Azure Bastion Host (provides secure RDP/SSH proxying over HTTPS)
resource "azurerm_bastion_host" "bastion" {
  name                = "bastion-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_bastion_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
  tags = var.tags
}

# 3. Private NIC for Jumpbox VM (No public IP assigned)
resource "azurerm_network_interface" "jumpbox" {
  name                = "nic-jumpbox-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_jumpbox_id
    private_ip_address_allocation = "Dynamic"
  }
  tags = var.tags
}

# 4. Private Jumpbox Virtual Machine
resource "azurerm_linux_virtual_machine" "jumpbox" {
  name                            = "vm-jumpbox"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = "Standard_B2s_v2"
  admin_username                  = "azureuser"
  admin_password                  = "P@ssw0rd@123"
  disable_password_authentication = false # Required to enable username/password login
  network_interface_ids = [
    azurerm_network_interface.jumpbox.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags = var.tags
}

# 5. Network Security Group for the Jumpbox
resource "azurerm_network_security_group" "jumpbox" {
  name                = "nsg-jumpbox-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# 6. NSG Rule: Allow SSH (Port 22) only from Azure Bastion Subnet
resource "azurerm_network_security_rule" "allow_bastion_ssh" {
  name                        = "AllowBastionSSH"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "10.0.19.0/26" # Address range of AzureBastionSubnet
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.jumpbox.name
}

# 7. Associate NSG with Jumpbox Subnet
resource "azurerm_subnet_network_security_group_association" "jumpbox" {
  subnet_id                 = var.subnet_jumpbox_id
  network_security_group_id = azurerm_network_security_group.jumpbox.id
}
