# Introduction
This set of sample files started out as a direct clone of [the work by FWSquatch](https://github.com/FWSquatch/do180-practice). 

Their last update to the project was in March of 2021, with the sample exam environment based on CentOS 7. 

In this fork, I am updating the environment to match todays RHEL8-based EX188 exam.


## License

The original repository for the project did not include a license statement. 

For my fork of the project, I have taken the liberty of applying CC-BY-NC-SA-4.0. The original author [agreed that CC-BY-SA-4.0 is fine](https://github.com/FWSquatch/do180-practice/issues/1). I have added the stipulation that only non-commercial use is allowed.


# EX180 and EX188 Automated Practice Deployment
_Powered by Ansible and Vagrant_ 

Using the files in this project, you can quickly build a lab environment to learn with [this EX180 Practice Exam](./Assignments/Original.md)

Once you have finished those tasks, [continue with my own extra assignments](./Assignments/Extras.md)!


## Installation
1. Install vagrant and virtualbox.
2. Clone this repo: `git clone https://github.com/Unixerius/EX188-practice`
3. Change into the newly created directory: `cd EX188-practice`
4. Fire up the VMs: `vagrant up`

Both VMs will take 1024MB of RAM, so make sure you have (at least) 2GB of RAM to spare.


## Other Useful Information:
- `vagrant up` - Boots and provisions the environment
- `vagrant destroy -f` - Shuts down and **destroys** the environment
- `vagrant halt` - Shuts down the environment VMs (can be booted again with `vagrant up`)

The first time you run the "vagrant up" command, it will download the OS images for later use. In other words, it will take longest the first time around but will be faster when it is deployed again. You can run `vagrant destroy -f` to destroy your environment at anytime. **This will erase everything**. 


## Included systems:
- registry.do180.lab
- workstation.do180.lab


## System Details:
> workstation
- 192.168.88.4
- Gateway - 192.168.88.1
- DNS - 8.8.8.8
> registry
- 192.168.88.5
- Gateway - 192.168.88.1
- DNS - 8.8.8.8


## Accessing the systems

You can work with both VMs through SSH: 

1. Open a terminal window on your host OS.
2. "cd" into this Git repository.
3. Type "vagrant up" and wait for the VMs to be ready.
3. Type "vagrant ssh registry", or "vagrant ssh workstation" to login to the VM.
