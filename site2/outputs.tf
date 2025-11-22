output "gwB_public_ip" {
  value = azurerm_public_ip.gw_b_ip.ip_address
}

output "vpngw_b_id" {
  value = azurerm_virtual_network_gateway.vpngw_b.id
}
