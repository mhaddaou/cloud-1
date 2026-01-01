terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

# Get existing SSH key from DigitalOcean
data "digitalocean_ssh_key" "main" {
  name = var.ssh_key_name
}

# Create the droplet with 2 vCPUs
resource "digitalocean_droplet" "Cloud_1" {
  name   = var.droplet_name
  region = var.region
  size   = "s-2vcpu-2gb"
  image  = "ubuntu-22-04-x64"

  ssh_keys = [data.digitalocean_ssh_key.main.id]

  user_data = file("${path.module}/setup.sh")

  tags = ["Cloud_1" ]
}

output "droplet_ip" {
  description = "The public IP address of the droplet"
  value       = digitalocean_droplet.Cloud_1.ipv4_address
}

output "droplet_status" {
  description = "The status of the droplet"
  value       = digitalocean_droplet.Cloud_1.status
}
