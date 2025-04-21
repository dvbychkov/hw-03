terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

provider "yandex" {
  service_account_key_file = "${path.module}/key.json"
  cloud_id  = "b1ggid9nl12161umo6r8"
  folder_id = "b1grekf05a830gqkk35s"
  zone      = var.default_zone
}
