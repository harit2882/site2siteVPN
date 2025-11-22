# Resource Group
resource "azurerm_resource_group" "rg_a" {
  name     = "rg-vnet-a"
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet_a" {
  name                = "VNet-A"
  resource_group_name = azurerm_resource_group.rg_a.name
  location            = var.location
  address_space       = ["10.1.0.0/16"]
}

# Gateway Subnet
resource "azurerm_subnet" "gw_subnet_a" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg_a.name
  virtual_network_name = azurerm_virtual_network.vnet_a.name
  address_prefixes     = ["10.1.255.0/27"]
}

# Public IP for VPN Gateway (Static + Standard)
resource "azurerm_public_ip" "gw_a_ip" {
  name              = "VPNGW-A-PIP"
  resource_group_name = azurerm_resource_group.rg_a.name
  location          = var.location
  allocation_method = "Static"
  sku               = "Standard"
}

# VPN Gateway
resource "azurerm_virtual_network_gateway" "vpngw_a" {
  name                = "VPNGW-A"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_a.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw1"

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.gw_a_ip.id
    subnet_id            = azurerm_subnet.gw_subnet_a.id
  }
}
