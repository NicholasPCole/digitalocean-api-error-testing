variable "api_token" {
  type        = "string"
  description = "Token used to connect to the DigitalOcean API."
}

variable "canary_count" {
  type        = "string"
  description = "Number of canaries to create in each region."
  default     = "5"
}

variable "canary_regions" {
  type        = "list"
  description = "Regions in which to create canaries."
  default     = ["nyc1", "sfo1", "nyc2", "ams2", "sgp1", "lon1", "nyc3", "ams3", "fra1", "tor1", "sfo2", "blr1"]
}

variable "droplet_ssh_keys" {
  type        = "list"
  description = "Numeric IDs of the SSH key(s) to insert from your account."
}

variable "whitelisted_ip_addresses" {
  type        = "list"
  description = "Whitelisted IP addresses to allow access to services like SSH."
}
