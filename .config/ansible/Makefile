install: requirements

requirements:
	sudo ansible-galaxy install -r requirements.yml

install-docker:
	ansible-playbook -i hosts.ini playbooks/docker.yml

install-virtualbox:
	ansible-playbook -i hosts.ini playbooks/virtualbox.yml

install-go:
	ansible-playbook -i hosts.ini playbooks/go.yml
