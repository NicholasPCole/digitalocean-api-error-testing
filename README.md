# DigitalOcean API connection reset testing

A collection of Terraform and Ansible scripts to try to reproduce errors accessing DigitalOcean's API.

## Usage

1. Copy `secrets.yaml.default` to `secrets.yaml`.
2. Optional but recommended: Use Ansible Vault to encrypt the file on disk.
3. Fill in the values for the Terraform API token, Python script API token, and SSH key numeric IDs. (Using a separate API token for Terraform helps avoid rate limiting when creating or destroying resources.)
4. Run `ansible-playbook install-canaries.yaml`.