resource "random_password" "each" {
  for_each = toset([
    for vm in concat(
      yandex_compute_instance.web[*].name,
      values(yandex_compute_instance.db)[*].name,
      [yandex_compute_instance.storage.name]
    ) : vm
  ])
  
  length  = 16
  special = true
}
