variable "vpc_name" {
  type        = string
  default     = "develop"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
}

variable "token" {
  type        = string
  description = "OAuth-token"
}

variable "cloud_id" {
  type        = string
  description = "Cloud ID"
}

variable "folder_id" {
  type        = string
  description = "Folder ID"
}
