require 'yaml'

# Load settings from servers.yml file.
configuration = YAML.load_file('configuration.yaml')

Vagrant.configure("2") do |config|
    configuration["servers"].each do |opts|
        config.vm.define opts["name"] do |config|
            config.vm.box = opts["box"]
            config.vm.box_version = opts["box_version"]
            config.vm.hostname = opts["name"]
            config.vm.network :private_network, ip: opts["eth1"]

            config.vm.provider "virtualbox" do |v|
                v.name = opts["name"]
            	v.customize ["modifyvm", :id, "--groups", "/K8s Development"]
                v.customize ["modifyvm", :id, "--memory", opts["mem"]]
                v.customize ["modifyvm", :id, "--cpus", opts["cpu"]]

            end

            config.vm.provision "shell", path: "configure_box.sh", privileged: true
            if opts["type"] == "master"
                config.vm.provision "shell", path: "configure_master.sh", privileged: true
                if configuration["dashboard"] == true
                    config.vm.provision "shell", path: "dashboard/configure_dashboard.sh", privileged: true
                end
            else
                config.vm.provision "shell", path: "configure_worker.sh", privileged: true
            end
        end
    end
end
