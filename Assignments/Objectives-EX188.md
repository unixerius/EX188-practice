# Exam objectives (2026)

[Red Hat publishes a clear list of objectives](https://www.redhat.com/en/services/training/ex188-red-hat-certified-specialist-containers-exam) for the EX188 exam. 

The table below maps the objectives to practice tasks in this repository and in the original EX180 practice test.


# Notes from Red Hat

> [!WARNING]  
> As with all Red Hat performance-based exams, configurations must persist after reboot without intervention. Even if you do not have root, or sudo access.

During the exam you may be required to work with one or more pre-written applications. You will not be required to modify application code however in some cases you may need to utilize supplied documentation in order to produce a new deployment of a given application.


## Training topics n on the exam

The accompanying training DO188 includes topics which are **not** on the EX188 exam. Training topics not on the exam:

* Red Hat OpenShift
* Kubernetes
* Podlets

The exam website mentions that:

> "This exam is based on RHEL9, podman v4.4 and OCP v4.14 [...]"

But the *exam objectives have no mention* at all of OCP (OpenShift Container Platform).


# The objectives in the practice test

## Implement images using Podman and Containerfile

| Objective                                | Assignments |
|------------------------------------------|-------------|
|Understand how to specify the container’s base image. | 6, 7, 9, 14 | 
|Understand how to add content to the container. | 6, 7, 9, 14 | 
|Understand how to configure the container’s run time environment including user id, working directory and running arbitrary commands. | 2, 3, 6, 7, 9, 14, 15 | 
|Understand when and how to expose ports from a Containerfile. | 6, 7, 10, 12, 13, 14, 15 |
|Understand how to pass environment variables and arguments to an image built from a Containerfile. | 3, 9 |
|Understand how to specify the command to be run in a custom image. | 6, 7, 9, 14, 15 |
|Understand container volumes including sharing host data with the container. | 2, 10, 12, 14, 15 |
|Understand the security and permissions requirements related to host and network access from the container. | 10, 12, 14, 15 |
|Understand container and image life cycles and how to manage them. | ALL |


## Manage images

| Objective                                | Assignments |
|------------------------------------------|-------------|
| Understand private registry security. | 1, 5, 6 |
| Interact with many different registries. | ALL |
| Understand and use image tags | ALL |
| Push and pull images from and to registries. | ALL |
| Back up an image with its layers and meta data vs. backup a container state. | 5 |


## Run containers locally using Podman

| Objective                                | Assignments |
|------------------------------------------|-------------|
| Run containers locally using Podman | ALL |
| Get container logs. | ALL |
| Listen to container events on the container host. | n.a. |
| Use Podman inspect. | ALL |
| Specifying environment parameters. | 3, 8 |
| Expose public applications. | ALL |
| Get application logs. | ALL |
| Inspect running applications. | ALL |


## Run multi-container applications with Podman

| Objective                                | Assignments |
|------------------------------------------|-------------|
| Create application stacks | 10, 15 |
| Understand container dependencies | 10 |
| Working with environment variables | 8, 10 |
| Working with secrets | 8 |
| Working with volumes | 10, 15 |
| Working with configuration | 10 |


## Troubleshoot containerized applications

| Objective                                | Assignments |
|------------------------------------------|-------------|
| Understand the description of application resources | ALL |
| Get application logs | ALL |
| Inspect running applications | ALL |
| Connecting to running containers | ALL |


## Not listed in the objectives, but important

| Objective                                | Assignments |
|------------------------------------------|-------------|
| Installing Podman Compose | 1, 10 |
| Deploy containers as a Systemd service. | 2 |
| Defining a user service (as opposed to system/root) in Systemd. | 2, 13 |
| Use Skopeo to interact with image repositories. | 4 |
| Working with secrets (without Compose). | 8 |
| Passing arguments and settings during the Build phase. | 9 |
| Using SEManage to set container_file_t context on files and volumes. | 14 |
| Know how to operate the firewall, if external access is required. | n.a. |
| Creating a pod with one, or more, containers. | 15 |
| Using Podlets for Systemd integration. | 16 |


