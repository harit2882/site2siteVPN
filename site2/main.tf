# Resource Group
resource "azurerm_resource_group" "rg_b" {
  name     = "rg-vnet-b"
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet_b" {
  name                = "VNet-B"
  resource_group_name = azurerm_resource_group.rg_b.name
  location            = var.location
  address_space       = ["10.2.0.0/16"]
}

# Gateway Subnet
resource "azurerm_subnet" "gw_subnet_b" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg_b.name
  virtual_network_name = azurerm_virtual_network.vnet_b.name
  address_prefixes     = ["10.2.255.0/27"]
}

# Public IP for VPN Gateway (Static + Standard)
resource "azurerm_public_ip" "gw_b_ip" {
  name              = "VPNGW-B-PIP"
  resource_group_name = azurerm_resource_group.rg_b.name
  location          = var.location
  allocation_method = "Static"
  sku               = "Standard"
}

# VPN Gateway
resource "azurerm_virtual_network_gateway" "vpngw_b" {
  name                = "VPNGW-B"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg_b.name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw1"

  ip_configuration {
    name                 = "vnetGatewayConfig"
    public_ip_address_id = azurerm_public_ip.gw_b_ip.id
    subnet_id            = azurerm_subnet.gw_subnet_b.id
  }
}
