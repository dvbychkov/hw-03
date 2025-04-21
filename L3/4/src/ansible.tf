resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web[*],
    databases  = values(yandex_compute_instance.db)[*],
    storage    = [yandex_compute_instance.storage]
  })
  filename = "${path.module}/inventory.ini"
}

resource "null_resource" "web_hosts_provision" {
  count = var.web_provision ? 1 : 0
  
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.db,
    yandex_compute_instance.storage,
    local_file.ansible_inventory
  ]

  provisioner "local-exec" {
    command    = "eval $(ssh-agent) && ssh-add ~/.ssh/id_ed25519"
    on_failure = continue
  }

  provisioner "local-exec" {
    command     = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${path.module}/inventory.ini ${path.module}/test.yml"
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
}
