# Setup #

## Create your vagrant box ##

Install vagrant and then from this directory:

```
vagrant up
```

It'll download the base box and will perform all setup and then you can:

```
vagrant ssh
```

## Start the navyproject containers ##

Now you're inside the vagrant box, you'll need to log into the docker hub.
Entering unknown credentials will automatically create a new account:

```
docker login
```

Now start the navyproject containers. The first time this runs, it will take some time
as it downloads the images from the docker hub.

```
./start.sh
```

To connect to the navy cluster, use *.vagrant.navyproject.com which resolves to the ip address of your vagrant box, 192.168.33.10.

Visit http://radar.vagrant.navyproject.com:8000 in your browser

ssh to your vagrant box and run the integration test suite:

```
vagrant ssh
./run_tests.sh
```

Watch the output in the browser

View the source

Stop the navyproject containers

```
./stop.sh
```

## Work on the html / javascript ##

To work on the html / javascript etc, run the navyproject containers in dev mode. This will result in the
directory on your mac where the Vagrantfile resides becoming the document root for the reactclient container.
Any files you put here will be served up when you visit http://radar.vagrant.navyproject.com:8000, allowing you to work on them
freely. Replace the ./start.sh nodev step above with:

```
./start.sh dev
```
