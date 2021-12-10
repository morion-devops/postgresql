# PostgreSQL

PosgtreSQL server in Master-slave mode (streaming replication). One master, one slave.
This database used in [cpu-load app](https://github.com/morion-devops/cpu-load).

# How to provisioning
1. Run `vagrant up` for create VMs.
1. Copy `group_vars/all.yaml.example` as `group_vars/all.yaml` and setup credentials.
1. Run `ansible-playbook playbook-install.yaml` for install postgres and configure replication
1. Run `ansible-playbook playbook-create-cpu-load.yaml` for create db, table and user for cpu-load app