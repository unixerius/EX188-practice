# Introduction

The original sample exam did not have questions for all topics on the EX188 exam (2023 and later). 

This document adds a few missing topics. 


# Extra tasks

## Task 8

This tasks builds on work you have already done in task 3.

Refactor your configuration in such a way that you create four Podman secrets:

* mysql_user: "duffman", from file ~/mysql_user
* mysql_password: "saysoyeah", from file ~/mysql_password
* mysql_root_password: "SQLp4ss", from file ~/mysql_root_password
* mysql_database: "beer", from file ~/mysql_database

Run the container in the background, with the following parameters:

* You will again use the image "mariadb" from the registry on registry.do180.lab.
* Give the container the name secretsdb.
* Publish port 3306 on external port 3307.
* The variables for database startup should be set as secret environment variables.
  * MYSQL_USER
  * MYSQL_PASSWORD
  * MYSQL_ROOT_PASSWORD
  * MYSQL_DATABASE

Once the container is up and running, prove that your settings are correctly applied.

Connect to your database as the root user and check for the existence of the beer database:

`echo "show databases;" | mysql -uduffman -psaysoyeah -h workstation -P 3307`

Run the command located in /sql/beer.sql to insert values into the database.

```
mysql -uroot -pSQLp4ss -h workstation -P 3307 < /sql/beer.sql
echo 'select * from types' | mysql -uduffman -psaysoyeah -h workstation -P 3307 beer
```


## Task 9

Create a Dockerfile which creates a container image with the following requirements. Store the Dockerfile as ~/task9.dockerfile.

* Based on centos:9.
* During the build, create a user account.
* "joe" must be the default user.
* Read an argument during build-time to override the name "joe".
* The container must run "whoami" to show the active user.

NOTE: Arguments are NOT passed during runtime of the container! They are passed during the container build. 

Create two container images using this Dockerfile, named hello-joe:1.0 and hello-lisa:1.0.

When run, they should respectively output "joe" and "lisa". 



## Task 10

**Note:**

> This task heavily leans on the Docker Samples project's _Voting App_. 

Use the incomplete Podman Stack file located in /dockerfiles/voting/docker-compose.yml. Use the comments in the file to guide you through the process of creating a Podman Stack with the following requirements:

* There are two networks: front-end (of type bridge) and back-end (of type internal).
* There is one volume: db-data

The Stack consists of five services:

* Using the "redis" image, named "redis", in network "front-end"
* Using the "postgres:9.4" image, named "db", in network "back-end", with volume "db-data" mounted on /var/postgres.
* The Postgres container needs to have two environment variables: POSTGRES_USER and POSTGRES_PASSWORD, both set to "postgres". 
* Using the "dockersamples/examplevotingapp_vote" image, named "vote", in networks "back-end" and in "front-end". 
* The "vote" container exposes port 80 on public port 5000. It depends on "redis". 
* Using the "dockersamples/examplevotingapp_result" image, named "result", in networks "back-end" and in "front-end". 
* The "vote" container exposes port 80 on public port 5001. It depends on "db". 
* Using the "dockersamples/examplevotingapp_worker" image, named "worker", in networks "back-end" and "front-end". 
* The "worker" container depends on both "db" and "redis". 


# Task 11

Mount the centos:9 container image on your host system. DO NOT run the container, mount it in your file system. 

Store the contents of /etc/os-release from the container image into ~/task11.txt.


# Task 12

Create the directory ~/mywebsite/. In it, create a file index.html, with the contents "Welcome to my website."

Download the official Apache httpd container. 

Explore the official Apache httpd container to find the correct directory for the "document root" where the default index.html is stored.

Run a container, based on this official Apache httpd container:

* In detached mode, in the background.
* With the name "mywebsite". 
* Expose port 80 on port 8888.
* Bind mount ~/mywebsite/ as the document root directory you found earlier.

Prove that the website works.


# Task 13

Download the official Apache httpd container. Run a container, based on this official Apache httpd container:

* In detached mode, in the background.
* With the name "runsalways". 
* Expose port 80 on port 9999.
* Ensure that the container will always restart; both if it gets killed and after a reboot. 
* Do NOT create a Systemd service for the container, use an alternative method.

Prove that the website works. Prove that it restarts if you kill the container. Prove that it restarts after a reboot.


# Task 14

Copy the directory /echo into your home directory.

Investigate the image "docker.io/library/python". Find the correct tag for the default "slim" version of the container based on Debian Trixie. Download this image.

In ~/echo, create a Dockerfile:

* Based on the Python image you found.
* Which runs the command python3 in a way that it will accept an argument.
* Where python3 runs as user "app" with uid:1000.

Build a container tagged "echo:1.0" using this Dockerfile.

Adjust file permissions, file ownership as well as SELinux file context on ~/echo/ and on ~/echo/udp_echo_server.py, so user "app" in the container may run it. 

DO NOT USE podman-run's automatic method of fixing SELinux and permissions. Do it manually!

Run a container based on "echo:1.0":

* In detached mode, in the background.
* With the name "echo". 
* Exposing port 5000 on port 5500, for UDP traffic.
* Bind mount ~/echo/ as /app.
* Running /app/udp_echo_server.py.

Prove that the container works by sending a string to port 5500 via UDP and then verifying the logs of container "echo".

To send text via UDP, you may use Bash with its network I/O redirection, via /dev/udp/workstation/5500.


# Task 15

**This is not on the exam objectives.**

Podman is all about pods, isn't it? This exercise was heavily inspired by chapter 4 of [Dan Walsh's Podman book](https://developers.redhat.com/e-books/podman-action).

Copy the directory /peapod to ~/peapod/. Make sure that ~/peapod/pop.sh is executable.

Create a pod:

- With the name "peapod".
- Which exposes port 80 on port 7777.
- Which does a bind mount of ~/peapod onto /usr/local/apache2/htdocs.

In the pod "peapod", create a container:

- Running docker.io/library/httpd 

In the pod "peapod", create a container:

- Running quay.io/centos/centos:9
- Which runs the script /usr/local/apache2/htdocs/pop.sh

Start the pod. Verify that the website is available at http://workstation:7777. Verify that the page changes every 10 seconds. 


# Task 16

**This is not on the exam objectives.**

The desired end-result is a systemd user-service (non-root) which restarts always and starts at boot. DO NOT use `podman generate`, but use the modern quadlet-based solution.

This container:
- Runs docker.io/louislam/uptime-kuma.
- Exposes port 3001 on host port 3001.
- Creates a volume named "kuma-data" on `/app/data`.
- Is named "kuma"

Validate by visiting http://workstation:3001/dashboard 


# Do you want more?

Would you like to do more practice tasks? The wonderful Lisenet has [a series of tasks for the old EX180 exam](https://www.lisenet.com/?s=ex180&submit=Search); you can skip all the OpenShift tasks. Lisenet also has a [great document with notes and practice tasks](https://github.com/lisenet/RHCA-study-notes/blob/master/EX180_study_notes.md).
