# DigitalOcean API connection reset testing

A collection of Terraform and Ansible scripts to try to reproduce errors accessing DigitalOcean's API.

## Usage

Set up your local machine:

1. Copy `secrets.yaml.default` to `secrets.yaml`.
2. Optional but recommended: Use Ansible Vault to encrypt the secrets file on disk.
3. In `secrets.yaml`, fill in the values for the Terraform API token, Python script API token, and SSH key numeric IDs. (Using a separate API token for Terraform helps avoid rate limiting when creating or destroying resources.)

Set up the remote infrastructure:

1. Run `ansible-playbook install-site.yaml`.

Tags can be used to focus on or skip different tasks in the Ansible playbook. For example:

* `--skip-tags terraform` will skip applying the Terraform infrastructure.
* `--skip-tags elasticsearch-logging` will skip installing Journalbeat and Packetbeat for logging to Elasticsearch.
* `--tags canary-script` will only template the Python script.
* `--tags canary-systemd-units` will only template the systemd units for the Python script.
* `--tags beats-configuration` will only template the Journalbeat and Packetbeat configuration files.
