# Source

Based on [a short Q&A with FWSquatch](https://github.com/FWSquatch/do180-practice/pull/6#issuecomment-4276739818) the original practice assignments were made by them, using a different account. This is why I now feel safe to include the assignments directly in this repo.

Per 2026, I knew of both a Google Doc and a Github repo which served identical content.

* [https://github.com/khamidziyo/sampleexam180](https://github.com/khamidziyo/sampleexam180)
* [Google Docs EX180 sample exam](https://docs.google.com/document/d/e/2PACX-1vS-91bm_QXLo4oRy94wB0FPxzNk-yAhCs9gE2ljU9xjTGGtHmCXdc7TVBalhr59bl49-qZDJuSP0bDL/pub)

## Additional content

The original exam does not cover all the EX188 objectives. In this repository you will find another text file with eight more assignments. 


## Walkthrough

You will find my versions of the solutions inside [the Solutions folder](../Solutions/) in this repository. 

[Ziyo Notes wrote a nice walkthrough](https://ziyonotes.uz/ex180-sample) that shows you how each assignment could be completed.


# EX180 Practice Exam

> [!WARNING]
> As with all Red Hat performance-based exams, configurations must persist after reboot without intervention. Even if you do not have root, or sudo access.

## Task 1

Install podman on the workstation machine and add registry:5000 as an insecure registry. Also make sure that podman searches this registry before trying any others.


## Task 2

Pull the latest httpd image from the registry.do180.lab registry and run it as root it in the background with the following parameters:

-  Publish container port 80 on host port 8080
-  Attach the /web directory as a volume that maps to /usr/local/apache2/htdocs
-  Give the container the name reg-httpd
-  Make the container start as a service called reg-httpd.service.

## Task 3

Pull the latest version of the mariadb image from the registry on registry.do180.lab. Run a container in the background with the following parameters:

-   Give the container the name of testql
-   Publish port 3306.
-   Set the following environment variables:

-   MYSQL_USER: duffman
-   MYSQL_PASSWORD: saysoyeah
-   MYSQL_ROOT_PASSWORD: SQLp4ss
-   MYSQL_DATABASE: beer

Connect to your database as the root user and check for the existence of the beer database:

    `echo “show databases;” | mysql -uduffman -h 192.168.88.4 -psaysoyeah`

Run the command located in /sql/beer.sql to insert values into the database.

    `mysql -uroot -h 192.168.88.4 -pSQLp4ss < /sql/beer.sql`

## Task 4

Use skopeo to find all of the tags associated with httpd on the registry.do180.lab server. Create and run a container with the following parameters:

-   Use an httpd image from registry.do180.lab that is NOT tagged with latest
-   Publish port 80 on 8008
-   Give the container the name alp-httpd
-   Run the container in detached mode

## Task 5

Do the following with your newly created alp-httpd container:

-   Execute an interactive shell (/bin/sh) in the alp-httpd container
-   Change the text in /usr/local/apache2/htdocs/index.html from “It works!” to “It Twerks!”
-   Use curl to test your changes.
-   Commit the container to an image named registry:5000/httpd:twerks.
-   Push your new image to the registry server (you can check this by visiting [http://registry.do180.lab](http://registry.do180.lab) 
-   Kill your alp-httpd container and run a new one based on the twerks image using port 8008. Name it tw-httpd.

## Task 6

Use the incomplete file located at /dockerfiles/nginx/Dockerfile to create a new image. It must meet these requirements:

-   Pull from almalinux:9
-   Install nginx
-   Publish port 80 to the outside world
-   Copy index.html and duffman.png into /usr/share/nginx/html directory
-   Run the command nginx -g daemon off

Tag this image as quay.io/YOURUSERNAME/duff-nginx:1.0 and push it to your quay.io account.

Run a container in detached mode named duffman that publishes port 80 to 8989. Test it with curl localhost:8989.

## Task 7

Use the incomplete files located in /dockerfiles/mosquitto/Dockerfile to create a new image. Use the comments in the Dockerfile to guide you through creating an image that meets the following requirements:

-   Use the almalinux:9 base image
-   Add your maintainer info
-   Create a user named duffman
-   Install epel-release and mosquitto (epel-release must be installed first)
-   Create a /colors directory using colors.tar
-   Move skeeter.sh over to /skeeter.sh
-   Make skeeter.sh executable
-   Allows connections to port 1883
-   Switch to the duffman user
-   Run the skeeter.sh script

Build your image with a tag of skeeter:1.0. Run a container in detached mode named mosquitto-1 that publishes port 1883 on port 11883.

You can test your container by running

    `mosquitto_sub -h 127.0.0.1 -p 11883 -t “#”`

If your container is working correctly, every 3 seconds you will see:

    ```
    Fri Mar 19 15:03:10 UTC 2021 (a timestamp)
    purple (a random color)
    duffman (the user running the script)
    ```

