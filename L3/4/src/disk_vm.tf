resource "yandex_compute_disk" "storage_disks" {
  count = 3
  name  = "storage-disk-${count.index}"
  type  = "network-hdd"
  zone  = var.default_zone
  size  = 1
}


resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v1"
  zone        = var.default_zone

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = 8 
    }
  }

  dynamic "secondary_disk" {
    for_each = toset(yandex_compute_disk.storage_disks[*].id)
    content {
      disk_id = secondary_disk.value
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }

  depends_on = [
    yandex_compute_disk.storage_disks
  ]
}
