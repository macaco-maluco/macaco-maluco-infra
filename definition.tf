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

resource "template_file" "user-data" {
  template = "${file("./cloud-config.yaml")}"
  vars {
    tmdb_api_key = "${var.tmdb_api_key}"
  }
}

resource "digitalocean_droplet" "macaco-maluco" {
  image = "coreos-stable"
  name = "macaco-maluco"
  region = "nyc2"
  size = "512mb"
  ssh_keys = [15143, 1762125]
  ipv6 = true
  private_networking = true

  user_data = "${template_file.user-data.rendered}"
}

output "floating_ip" {
  value = "${digitalocean_floating_ip.macaco-maluco.ip_address}"
}

output "droplet_ip" {
  value = "${digitalocean_droplet.macaco-maluco.ipv4_address}"
}
