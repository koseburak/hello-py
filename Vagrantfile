IMAGE_NAME = "bento/ubuntu-16.04"
N = 1

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
    end

    config.vm.provision "file", source: "devops/k8s", destination: "/tmp/"
      
    config.vm.define "k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "192.168.50.10"
        master.vm.hostname = "k8s-master"
        master.vm.provision "ansible_local" do |ansible|
            ansible.playbook = "devops/ansible-playbooks/master-playbook.yml"
            ansible.extra_vars = { node_ip: "192.168.50.10", }
        end
        
    end

    (1..N).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.50.#{i + 10}"
            node.vm.hostname = "node-#{i}"
            node.vm.provision "ansible_local" do |ansible|
                ansible.playbook = "devops/ansible-playbooks/node-playbook.yml"
                ansible.extra_vars = { node_ip: "192.168.50.#{i + 10}", }
            end
        end
    end

end
