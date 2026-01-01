variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
  
}

variable "ssh_key_name" {
  description = "Name of the SSH key in DigitalOcean"
  type        = string
  default     = "my-ssh-key"
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "fra1"
}

variable "droplet_name" {
  description = "Name of the droplet"
  type        = string
  default     = "future-Billionaires"
}
