# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "wasbook" do |wasbook|
    wasbook.vm.box = "wasbook"

    wasbook.vm.provider "virtualbox" do |vb|
      vb.name = "wasbook"
    end

    # 使用したイメージには既にネットワーク設定があり、auto_config=falseにしないとコンフリクトしてエラーになる
    # FYI: https://www.vagrantup.com/docs/networking/private_network.html#disable-auto-configuration
    wasbook.vm.network "private_network", ip: "192.168.56.101", auto_config: false

    wasbook.ssh.username = "wasbook"
    if !(ENV["WASBOOK_PASSWORD"].nil? || ENV["WASBOOK_PASSWORD"].empty?)
      wasbook.ssh.password = ENV["WASBOOK_PASSWORD"]
    end
  end
end
