provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_domain" "macaco-maluco" {
  name = "macacomaluco.space"
  ip_address = "${digitalocean_droplet.macaco-maluco.ipv4_address}"
}

resource "digitalocean_record" "macaco-maluco" {
  domain = "${digitalocean_domain.macaco-maluco.name}"
  type = "A"
  name = "*"
  value = "${digitalocean_droplet.macaco-maluco.ipv4_address}"
}

resource "digitalocean_droplet" "macaco-maluco" {
  image = "coreos-stable"
  name = "macaco-maluco"
  region = "nyc2"
  size = "512mb"
  ssh_keys = [15143]
}

output "ip" {
  value = "${digitalocean_droplet.macaco-maluco.ipv4_address}"
}
