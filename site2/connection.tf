# Local Network Gateway for Site B (points to Site A's VPN Gateway)
resource "azurerm_local_network_gateway" "lng_b" {
  name           = "LNG-B"
  resource_group_name = "rg-vnet-b"
  location       = var.location
  gateway_address = var.gwA_public_ip  # Injected from Site A output
  address_space  = ["10.1.0.0/16"]
}

# VPN Connection from Site B to Site A
resource "azurerm_virtual_network_gateway_connection" "conn_b_to_a" {
  name                       = "B-to-A-Connection"
  location                   = var.location
  resource_group_name        = "rg-vnet-b"
  virtual_network_gateway_id = var.vpngw_b_id
  local_network_gateway_id   = azurerm_local_network_gateway.lng_b.id
  type                       = "IPSec"
  shared_key                 = "DemoSharedKey123"
}
