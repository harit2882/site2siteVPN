# Local Network Gateway for Site A (points to Site B's VPN Gateway)
resource "azurerm_local_network_gateway" "lng_a" {
  name           = "LNG-A"
  resource_group_name = "rg-vnet-a"
  location       = var.location
  gateway_address = var.gwB_public_ip  # Injected from Site B output
  address_space  = ["10.2.0.0/16"]
}

# VPN Connection from Site A to Site B
resource "azurerm_virtual_network_gateway_connection" "conn_a_to_b" {
  name                       = "A-to-B-Connection"
  location                   = var.location
  resource_group_name        = "rg-vnet-a"
  virtual_network_gateway_id = var.vpngw_a_id
  local_network_gateway_id   = azurerm_local_network_gateway.lng_a.id
  type                       = "IPSec"
  shared_key                 = "DemoSharedKey123"
}
