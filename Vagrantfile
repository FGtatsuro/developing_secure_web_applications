# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "wasbook" do |wasbook|
    wasbook.vm.box = "wasbook"

    wasbook.vm.provider "virtualbox" do |vb|
      vb.name = "wasbook"
    end

    wasbook.vm.synced_folder ".", "/vagrant", disabled: true

    # 使用したイメージには既にネットワーク設定があり、auto_config=falseにしないとコンフリクトしてエラーになる
    # FYI: https://www.vagrantup.com/docs/networking/private_network.html#disable-auto-configuration
    wasbook.vm.network "private_network", ip: "192.168.56.101", auto_config: false

    wasbook.ssh.username = "wasbook"
    # 初回の認証でSSH鍵が作成されるため、その後はコメントアウトしても良い
    wasbook.ssh.password = ENV["WASBOOK_PASSWORD"]
  end
end
