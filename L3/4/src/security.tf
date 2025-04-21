resource "yandex_vpc_security_group" "example" {
  name       = "example_dynamic"
  network_id = yandex_vpc_network.develop.id
  folder_id  = var.folder_id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      protocol       = ingress.value.protocol
      description    = ingress.value.description
      port           = try(ingress.value.port, null)
      from_port      = try(ingress.value.from_port, null)
      to_port        = try(ingress.value.to_port, null)
      v4_cidr_blocks = ingress.value.v4_cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.security_group_egress
    content {
      protocol       = egress.value.protocol
      description    = egress.value.description
      port           = try(egress.value.port, null)
      from_port      = try(egress.value.from_port, null)
      to_port        = try(egress.value.to_port, null)
      v4_cidr_blocks = egress.value.v4_cidr_blocks
    }
  }
}

resource "yandex_vpc_security_group" "ansible" {
  name       = "ansible-access"
  network_id = yandex_vpc_network.develop.id
  
  ingress {
    protocol       = "TCP"
    description    = "Ansible SSH access"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "ICMP"
    description    = "ICMP for connectivity tests"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
