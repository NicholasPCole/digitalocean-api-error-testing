provider "digitalocean" {
  token = "${var.digitalocean_api_token}"
}

resource "digitalocean_droplet" "canaries" {
  image    = "ubuntu-18-04-x64"
  name     = "api-canary-${random_string.canaries.*.result[count.index]}"
  region   = "${var.canary_regions[count.index / var.canary_count]}"
  size     = "s-1vcpu-1gb"
  ssh_keys = "${var.droplet_ssh_keys}"
  tags     = ["${digitalocean_tag.canaries.id}"]

  #user_data = "${var.ubuntu_user_data}"
  count = "${length(var.canary_regions) * var.canary_count}"
}

resource "digitalocean_tag" "canaries" {
  name = "api-canaries"
}

resource "random_string" "canaries" {
  length  = 12
  special = false
  upper   = false
  count   = "${length(var.canary_regions) * var.canary_count}"
}
