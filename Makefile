run:
	ansible-playbook -i inventory.yaml playbooks/go-packages.yaml  

settings-git:
	ansible-playbook -i inventory.yaml playbooks/git.yaml

install-go-%:
	#verbose
	ansible-playbook  -i inventory.yaml playbooks/go.yaml --limit $* --ask-become-pass

	make source-go
	
	echo "Restart shell to source ~/.bashrc"

install-brew-%:
	ansible-playbook -i inventory.yaml playbooks/brew.yaml --limit $* --ask-become-pass

install-brew-packages-%:
	ansible-playbook -i inventory.yaml playbooks/brew-packages.yaml --ask-become-pass


install-dep1:
	make install-conda
	echo "Restart shell to source ~/.bashrc"

install-dep2:
	make install-ansible
	make install-openssh

install-conda:
	mkdir -p ~/miniconda3
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
	bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
	rm ~/miniconda3/miniconda.sh
	
	make source-conda

source-conda:
	echo "source ~/miniconda3/bin/activate" >> ~/.bashrc

install-ansible:
	conda install conda-forge::ansible -y

install-openssh:
	sudo apt install openssh-server -y

install-go-migrate:
	brew install golang-migrate


install-proxmox:
	ansible-playbook -i inventory.yaml playbooks/ubuntu-vm.yaml --ask-become-pass
