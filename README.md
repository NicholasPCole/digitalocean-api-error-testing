# DigitalOcean API connection reset testing

A collection of Terraform and Ansible scripts to try to reproduce errors accessing DigitalOcean's API.

## Usage

1. Copy `secrets.yaml.default` to `secrets.yaml`.
2. Optional but recommended: Use Ansible Vault to encrypt the secrets file on disk.
3. In `secrets.yaml`, fill in the values for the Terraform API token, Python script API token, and SSH key numeric IDs. (Using a separate API token for Terraform helps avoid rate limiting when creating or destroying resources.)
4. Run `ansible-playbook prepare-local-machine.yaml` to generate the local configuration files for Terraform and Ansible.
5. Run `terraform apply` to create the Droplets.
6. Run `ansible-playbook install-canaries.yaml` to install the canaries on the Droplets.
7. Optional: Run `ansible-playbook install-journalbeat.yaml` to ship the logs to Elasticsearch for closer analysis.
8. Some time later: Run `ansible-playbook fetch-logs.yaml` to retrieve the API connection logs from each Droplet.
