# Introduction
This set of sample files started out as a direct clone of [the work by FWSquatch](https://github.com/FWSquatch/do180-practice). 

Their last update to the project was in March of 2021, with the sample exam environment based on CentOS 7. 

In this fork, I originally updated the environment to match the RHEL8-based EX188 exam. And per March 2026, I'm updating it for RHEL9.


## License

The original repository for the project did not include a license statement. 

For my fork of the project, I have taken the liberty of applying CC-BY-NC-SA-4.0. The original author [agreed that CC-BY-SA-4.0 is fine](https://github.com/FWSquatch/do180-practice/issues/1). I have added the stipulation that only non-commercial use is allowed.


# EX180 and EX188 Automated Practice Deployment
_Powered by Ansible and Vagrant_ 

Using the files in this project, you can quickly build a lab environment to learn with [the original EX180 Practice Exam](./Assignments/Original-EX180.md). You can then complete your EX188 preparations by also doing [my added EX188 tasks](./Assignments/Additions-for-EX188.md).


## Installation
1. Install Vagrant and VirtualBox.
2. Clone this repo: `git clone https://github.com/Unixerius/EX188-practice`
3. Change into the newly created directory: `cd EX188-practice`
4. Fire up the VMs: `vagrant up`

Each of the VMs will take 2048MB of RAM, so make sure you have (at least) 4GB of RAM to spare.


## Other Useful Information:
- `vagrant up` - Boots and provisions the environment
- `vagrant destroy -f` - Shuts down and **destroys** the environment
- `vagrant halt` - Shuts down the environment VMs (can be booted again with `vagrant up`)

The first time you run the "vagrant up" command, it will download the OS images for later use. In other words, the first time you run this it will take the longest. Every time thereafter will be faster. You can run `vagrant destroy -f` to destroy your environment at anytime. **This will erase both VMs and your progress**. 


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
3. Type "vagrant ssh registry", or "vagrant ssh workstation" to login to the workstation VM.


## Compatibility

This lab was originally made only with x86_64 systems in mind. 

For now, it cannot yet be used on MacOS systems with Apple's ARM processors.


# Study notes

If you'd like my notes, which I took in 2023, they're in [Notes.md](./Notes.md).


# Training

If you'd like some training to prepare for the exam, there are many vendors who offer a short and acceptable EX188 prep course. If you want my opinion, take a short subscription with O'Reilly Online (or do a trial) and use [Sander van Vugt's EX188 course](https://www.oreilly.com/videos/red-hat-certified/9780135335956/).

You can also take a free month of LinkedIn Learning, [for the same course by Sander](https://www.linkedin.com/learning/red-hat-certified-specialist-in-containers-ex188-cert-prep).

Would you like to do more practice tasks? The wonderful Lisenet has [a series of tasks for the old EX180 exam](https://www.lisenet.com/?s=ex180&submit=Search); you can skip all the OpenShift tasks. Lisenet also has a [great document with notes and practice tasks](https://github.com/lisenet/RHCA-study-notes/blob/master/EX180_study_notes.md).
