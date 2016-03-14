provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_domain" "macaco-maluco" {
  name = "macacomaluco.space"
  ip_address = "${digitalocean_floating_ip.macaco-maluco.ip_address}"
}

resource "digitalocean_record" "macaco-maluco" {
  domain = "${digitalocean_domain.macaco-maluco.name}"
  type = "A"
  name = "*"
  value = "${digitalocean_floating_ip.macaco-maluco.ip_address}"
}

resource "digitalocean_floating_ip" "macaco-maluco" {
  droplet_id = "${digitalocean_droplet.macaco-maluco.id}"
  region = "${digitalocean_droplet.macaco-maluco.region}"
}

resource "digitalocean_droplet" "macaco-maluco" {
  image = "coreos-stable"
  name = "macaco-maluco"
  region = "nyc2"
  size = "512mb"
  ssh_keys = [15143]
  ipv6 = true
  private_networking = true
}

output "floating_ip" {
  value = "${digitalocean_floating_ip.macaco-maluco.ip_address}"
}

output "droplet_ip" {
  value = "${digitalocean_droplet.macaco-maluco.ipv4_address}"
}
