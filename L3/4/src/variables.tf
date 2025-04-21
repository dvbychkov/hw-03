variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network name"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "Default availability zone"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "Default subnet CIDR block"
}

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "VM image family for web servers"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Availability zone for database VMs"
}

variable "token" {
  type        = string
  description = "Yandex Cloud OAuth-token"
  sensitive   = true
}

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
  sensitive   = true
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
  sensitive   = true
}

variable "web_provision" {
  type        = bool
  default     = true
  description = "Enable/disable Ansible provisioning for web servers"
}

variable "vms_ssh_public_root_key" {
  type        = string
  description = "SSH public key for VM access"
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI..."
}

variable "security_group_ingress" {
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [
    {
      protocol       = "TCP"
      description    = "Allow incoming SSH"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 22
    },
    {
      protocol       = "TCP"
      description    = "Allow incoming HTTP"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 80
    },
    {
      protocol       = "TCP"
      description    = "Allow incoming HTTPS"
      v4_cidr_blocks = ["0.0.0.0/0"]
      port           = 443
    },
    {
      protocol       = "ICMP"
      description    = "Allow ping for connectivity tests"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "security_group_egress" {
  type = list(object({
    protocol       = string
    description    = string
    v4_cidr_blocks = list(string)
    port           = optional(number)
    from_port      = optional(number)
    to_port        = optional(number)
  }))
  default = [{
    protocol       = "TCP"
    description    = "Allow all outgoing traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65365
  }]
}
