resource "yandex_compute_instance" "web" {
  count = 2
  name        = "web-${count.index + 1}"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 10
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id,yandex_vpc_security_group.ansible.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }

  depends_on = [yandex_compute_instance.db]
}
