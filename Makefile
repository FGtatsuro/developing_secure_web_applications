/usr/local/bin/VBoxManage:
	brew cask install virtualbox


wasbook.ova:
	curl $(OVF_DOWNLOAD_LINK) -o wasbook.ova

.virtualbox/wasbook/wasbook.vbox: /usr/local/bin/VBoxManage wasbook.ova
	VBoxManage import wasbook.ova --vsys 0 \
		--settingsfile `pwd`/.virtualbox/wasbook/wasbook.vbox \
		--basefolder `pwd`/.virtualbox \
		--unit 9 --ignore \
		--unit 10 --ignore \
		--unit 13 --ignore
