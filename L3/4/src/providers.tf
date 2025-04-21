terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.140.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
  required_version = "~> 1.8.4"
}

provider "yandex" {
  service_account_key_file = "${path.module}/key.json"
  cloud_id  = "b1ggid9nl12161umo6r8"
  folder_id = "b1grekf05a830gqkk35s"
  zone      = var.default_zone
}
