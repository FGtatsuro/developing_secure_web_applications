/usr/local/bin/VBoxManage:
	brew cask install virtualbox

/usr/local/bin/vagrant:
	brew cask install vagrant


wasbook.ova:
	curl $(OVF_DOWNLOAD_LINK) -o wasbook.ova

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
