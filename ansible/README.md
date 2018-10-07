How to manage dotfiles with Ansible
===================================

This folder includes Ansible playbooks and roles for various parts of my workstation.
Supported operating systems include Fedora 28 or later and RHEL/CentOS 7.
The Ansible playbooks here fully automate the installation of all dotfiles.
They also install and configure other software used in my environment.


## Expectations

To use the Ansible infrastructure here, some things will always be assumed:

1. You must execute `ansible-playbook` commands from this directory (`ansible/`)
2. `inventory/inventory` and `inventory/group_vars/all` are customized to your needs


## Provision Fedora workstation

```bash
ansible-playbook-3 -l desktop playbooks/fedora-workstation.yml
```


## Provision RHEL/CentOS 7 workstation

```bash
ansible-playbook -l desktop playbooks/rhel-workstation.yml
```


## Provision CentOS 7 headless servers

_Coming soon._
This will not work yet.

```bash
ansible-playbook-3 -l servers-centos playbooks/centos-server.yml
```
