# Getting started

In this tutorial you will learn how to do the following things:
* Setting up the navy environment
* Provision a multi-container application
* De-provision a multi-container application

## Create your vagrant box

[Install vagrant](https://www.vagrantup.com/) and then from this directory:

```
$ vagrant up
```

It'll download the base box and will perform all setup and then you can:

```
$ vagrant ssh
```

## Start the navyproject containers

Now start the navyproject containers. The first time this runs, it will take some time
as it downloads the images from the docker hub.

```
$ ./start.sh
```

## Provision your first application

### Download the CLI (admiral)

Navy provides you with a CLI called `admiral` to manage your containers. You can
[download the binary](https://github.com/navy-project/admiral/releases) for your platform from the GitHub repository.

For more information about how to use admiral please refer to the [README](https://github.com/navy-project/admiral).

### Deploy a multi-container application (convoy)

Admiral allows you to easily deploy a multi-container application by providing it with
a configuration file called `manifest.yml`.

The `manifest.yml` file allows you to define all the containers you wish to deploy
and its dependencies. Please refer to the [manifest specification](#) for more information.

Now please download the example `manifest.yml` to deploy our example application (drinking game):

```
$ curl -O https://gist.githubusercontent.com/Tobscher/2f2e8973f5d9520f448c/raw/b49b3886f701b9980f6e90d8a6d0bbc29485639a/manifest.yml
```

Run the following command to instruct navy to provision your containers:

```
$ admiral launch demo manifest.yml
```

The command above will do the following:
* Provisions a new multi-container environment with the name `demo`
* Registers your application to be accessible at https://demo.vagrant.navyproject.com

Now check the status of your deployment via:

```
$ admiral status demo
OK
```

Once the status of your deployment is `OK` you can access your application at https://game-demo.vagrant.navyproject.com.

Congratulations! You just deployed your test application.

### Stop your deployment

You have probably played our drinking game for quite a while now. If you don't need
your deployment anymore run the following command to de-provision your application:

```
$ admiral destroy demo
```

Check the status:

```
$ admiral status demo
NOT_FOUND
```

## How to stop the navyproject containers

All navyproject containers can be stopped by executing the stop script:

```
$ ./stop.sh
```
