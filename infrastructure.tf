provider "digitalocean" {
  token = "${var.api_token}"
}

resource "digitalocean_droplet" "bare_ipv4" {
  image    = "ubuntu-18-04-x64"
  name     = "bare-ipv4"
  region   = "${var.canary_regions[count.index / var.canary_count]}"
  size     = "s-1vcpu-1gb"
  ssh_keys = "${var.droplet_ssh_keys}"
  tags     = ["${digitalocean_tag.canaries.id}", "${digitalocean_tag.bare_ipv4.id}"]
  count    = "${length(var.canary_regions) * var.canary_count}"
}

resource "digitalocean_droplet" "ipv4_cloud_firewall" {
  image    = "ubuntu-18-04-x64"
  name     = "ipv4-cloud-firewall"
  region   = "${var.canary_regions[count.index / var.canary_count]}"
  size     = "s-1vcpu-1gb"
  ssh_keys = "${var.droplet_ssh_keys}"
  tags     = ["${digitalocean_tag.canaries.id}", "${digitalocean_tag.ipv4_cloud_firewall.id}"]
  count    = "${length(var.canary_regions) * var.canary_count}"
}

resource "digitalocean_firewall" "ipv4_cloud_firewall" {
  name = "ipv4-cloud-firewall"
  tags = ["${digitalocean_tag.ipv4_cloud_firewall.id}"]

  inbound_rule = [
    {
      protocol         = "icmp"
      source_addresses = ["0.0.0.0/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = "${var.whitelisted_ip_addresses}"
    },
  ]

  outbound_rule = [
    {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0"]
    },
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0"]
    },
    {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0"]
    },
  ]
}

resource "digitalocean_tag" "canaries" {
  name = "api-canaries"
}

resource "digitalocean_tag" "bare_ipv4" {
  name = "bare-ipv4"
}

resource "digitalocean_tag" "ipv4_cloud_firewall" {
  name = "ipv4-cloud-firewall"
}
