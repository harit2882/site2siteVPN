output "gwA_public_ip" {
  value = azurerm_public_ip.gw_a_ip.ip_address
}

output "vpngw_a_id" {
  value = azurerm_virtual_network_gateway.vpngw_a.id
}
