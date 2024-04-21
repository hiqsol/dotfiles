install: requirements

requirements:
	ansible-galaxy install -r requirements.yml

docker:
	ansible-playbook -i hosts.ini playbooks/docker.yml

syncthing:
	ansible-playbook -i hosts.ini playbooks/syncthing.yml

virtualbox:
	ansible-playbook -i hosts.ini playbooks/virtualbox.yml

go:
	ansible-playbook -i hosts.ini playbooks/go.yml

vagrant:
	ansible-playbook -i hosts.ini playbooks/vagrant.yml

google-cloud-cli:
	ansible-playbook -i hosts.ini playbooks/google-cloud-cli.yml
