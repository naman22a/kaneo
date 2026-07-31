data "cloudflare_zone" "main" {
  filter = {
    name = "namanarora.xyz"
  }
}

resource "cloudflare_dns_record" "kaneo" {
  zone_id = data.cloudflare_zone.main.zone_id

  name    = terraform.workspace == "prd" ? "kaneo" : "staging-kaneo"
  type    = "A"
  content = module.ec2.public_ips["worker-ubuntu"]

  ttl     = 1
  proxied = false
}
