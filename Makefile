/usr/local/bin/VBoxManage:
	brew cask install virtualbox

/usr/local/bin/vagrant:
	brew cask install vagrant

.vagrant/plugins.json: /usr/local/bin/vagrant vagrant_plugin_requirements.txt
	cat vagrant_plugin_requirements.txt | xargs -I{} vagrant plugin install {} --local


wasbook.ova:
	curl $(OVA_DOWNLOAD_LINK) -o wasbook.ova

.virtualbox/wasbook/wasbook.vbox: /usr/local/bin/VBoxManage wasbook.ova
	VBoxManage import wasbook.ova --vsys 0 \
		--settingsfile `pwd`/.virtualbox/wasbook/wasbook.vbox \
		--basefolder `pwd`/.virtualbox \
		--unit 9 --ignore \
		--unit 10 --ignore \
		--unit 13 --ignore

# FYI: https://qiita.com/mt08/items/457e5cd64db5a888ae2e
wasbook.box: /usr/local/bin/VBoxManage /usr/local/bin/vagrant .virtualbox/wasbook/wasbook.vbox
	rm -f wasbook.box && vagrant package --base wasbook --output wasbook.box
	vagrant box add wasbook.box --force --name wasbook
	VBoxManage unregistervm wasbook

.sudoers_settings: wasbook.box .vagrant/plugins.json
	-WASBOOK_PASSWORD=$(WASBOOK_PASSWORD) /usr/local/bin/vagrant up wasbook
	vagrant ssh -c "echo '$(WASBOOK_PASSWORD)' | sudo -S sh -c \"echo 'wasbook ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wasbook\"" wasbook
	vagrant ssh -c "sudo chown root:root /etc/sudoers.d/wasbook && sudo chmod 440 /etc/sudoers.d/wasbook" wasbook
	/usr/local/bin/vagrant halt wasbook
	touch .sudoers_settings


.PHONY: start stop destroy ssh
start: .sudoers_settings dnsmasq/start
	WASBOOK_PASSWORD=$(WASBOOK_PASSWORD) /usr/local/bin/vagrant up wasbook

stop: dnsmasq/stop
	/usr/local/bin/vagrant halt wasbook

destroy:
	/usr/local/bin/vagrant destroy wasbook
	rm -f .sudoers_settings

ssh:
	/usr/local/bin/vagrant ssh wasbook


.PHONY: dnsmasq/start dnsmasq/stop
dnsmasq/start: /usr/local/bin/docker
	if [ -z "`docker ps | grep dnsmasq`" ]; then \
		docker run -d --name dnsmasq \
		-p 53:53/tcp -p 53:53/udp \
		--mount type=bind,source=`pwd`/dnsmasq,target=/home,readonly \
		--cap-add=NET_ADMIN \
		andyshinn/dnsmasq:2.78 \
		-H /home/hosts; \
	fi

dnsmasq/stop: /usr/local/bin/docker
	if [ -n "`docker ps | grep dnsmasq`" ]; then \
		docker rm -f dnsmasq; \
	fi
