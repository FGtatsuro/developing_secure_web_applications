# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "wasbook" do |wasbook|
    wasbook.vm.box = "wasbook"

    wasbook.vm.provider "virtualbox" do |vb|
      vb.name = "wasbook"
    end

    wasbook.vm.synced_folder ".", "/vagrant", disabled: true

    wasbook.ssh.username = "wasbook"
    # 初回の認証でSSH鍵が作成されるため、その後はコメントアウトしても良い
    wasbook.ssh.password = ENV["WASBOOK_PASSWORD"]
  end
end
