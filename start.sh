#!/bin/bash -e

function usage() {
    echo "Usage: $0 dev|nodev"
    echo ""
    echo "Starts all the containers needed to run the integration tests"
    echo ""
    echo "Options:"
    echo "  dev   : the radar container's document root will be /vagrant (allowing you to work from the dir from where you ran vagrant ssh)"
    echo "  nodev : the radar container's document root will be inside the container (meaning you can't modify the files)"
    echo ""
    exit 1
}

case "$1" in
  dev)
    dev=true
    ;;
  nodev)
    dev=false
    ;;
  *)
    usage
    ;;
esac

docker run -d --name container_proxy -v /var/run/docker.sock:/tmp/docker.sock -p 172.17.42.1:8080:80 navyproject/container-proxy
docker run -d --name host_proxy -v /var/run/docker.sock:/tmp/docker.sock -p 443:443 navyproject/host-proxy nginx
docker run -d --name etcd navyproject/etcd
docker run -d --name commodore --link=etcd:etcd navyproject/commodore
docker run -d -v /var/run/docker.sock:/var/run/docker.sock --link=etcd:etcd --name harbourmaster navyproject/harbourmaster
docker run -d -v /var/run/docker.sock:/var/run/docker.sock --link=etcd:etcd --name coastguard navyproject/coastguard
docker run -d --link=etcd:etcd --name navyapi -p 4040:4040 navyproject/navyapi
docker run -d --name navystreamwatcher -p 4041:4041 navyproject/navystreamwatcher
if [ $dev = true ]
then
  docker run -d --name radar -p 8000:8000 -v /vagrant:/var/reactclient navyproject/radar
else
  docker run -d --name radar -p 8000:8000 navyproject/radar
fi
