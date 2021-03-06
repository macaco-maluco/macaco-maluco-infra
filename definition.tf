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

resource "digitalocean_record" "day-one-macaco-maluco" {
  domain = "${digitalocean_domain.macaco-maluco.name}"
  type = "CNAME"
  name = "day-one"
  value = "macaco-maluco.github.io."
}

resource "digitalocean_record" "thermalrunway-macaco-maluco" {
  domain = "${digitalocean_domain.macaco-maluco.name}"
  type = "CNAME"
  name = "thermalrunway"
  value = "eloquent-tereshkova-cadb7e.netlify.app."
}

resource "digitalocean_record" "peixe-macaco-maluco" {
  domain = "${digitalocean_domain.macaco-maluco.name}"
  type = "CNAME"
  name = "peixe"
  value = "macaco-maluco.github.io."
}

resource "digitalocean_record" "giftellers-macaco-maluco" {
  domain = "${digitalocean_domain.macaco-maluco.name}"
  type = "CNAME"
  name = "giftellers"
  value = "giftellers.firebaseapp.com."
}

resource "digitalocean_record" "sombrio-macaco-maluco" {
  domain = "${digitalocean_domain.macaco-maluco.name}"
  type = "CNAME"
  name = "sombrio"
  value = "sombrio.macacomaluco.space.herokudns.com."
}

resource "digitalocean_record" "giftellers-globalsign-macaco-maluco" {
  domain = "${digitalocean_domain.macaco-maluco.name}"
  type = "TXT"
  name = "@"
  value = "globalsign-domain-verification=-fxW38vCBctXeaqa0e3W9WR9aGP3FSS4BlqYMBg2lk"
}

resource "digitalocean_record" "giftellers-firebase-macaco-maluco" {
  domain = "${digitalocean_domain.macaco-maluco.name}"
  type = "TXT"
  name = "@"
  value = "firebase=giftellers"
}

resource "digitalocean_domain" "unbubble" {
  name = "unbubble.space"
  ip_address = "${digitalocean_floating_ip.macaco-maluco.ip_address}"
}

resource "digitalocean_floating_ip" "macaco-maluco" {
  droplet_id = "${digitalocean_droplet.macaco-maluco.id}"
  region = "${digitalocean_droplet.macaco-maluco.region}"
}

data "template_file" "user-data" {
  template = "${file("./cloud-init.yml")}"
  vars {
    tmdb_api_key = "${var.tmdb_api_key}"
  }
}

resource "digitalocean_droplet" "macaco-maluco" {
  image = "docker-20-04"
  name = "macaco-maluco"
  region = "nyc1"
  size = "s-1vcpu-1gb"
  ssh_keys = [30275495]
  ipv6 = true
  private_networking = true

  user_data = "${data.template_file.user-data.rendered}"
}

output "floating_ip" {
  value = "${digitalocean_floating_ip.macaco-maluco.ip_address}"
}

output "droplet_ip" {
  value = "${digitalocean_droplet.macaco-maluco.ipv4_address}"
}
