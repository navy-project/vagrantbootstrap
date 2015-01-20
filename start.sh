#!/bin/bash -e

at() {
  echo "--" "$@"
  date +%H:%M:%S.%N &>> start.log
}

die() {
  at "Failure: $@"
  echo "Check 'start.log' for more information"
  exit 1
}

erl() {
  at "  ""$@"
  "$@" &>> start.log
  return $?
}

echo "Starting container_proxy"
erl docker run -d --name container_proxy -v /var/run/docker.sock:/tmp/docker.sock -p 172.17.42.1:8080:80 navyproject/container-proxy || \
  die "Could not start container_proxy"

echo "Starting host_proxy"
erl docker run -d --name host_proxy -v /var/run/docker.sock:/tmp/docker.sock -p 443:443 navyproject/host-proxy nginx || \
  die "Could not start host_proxy"

echo "Starting etcd"
erl docker run -d --name etcd navyproject/etcd || \
  die "Could not start etcd"

echo "Starting commodore"
erl docker run -d --name commodore --link=etcd:etcd navyproject/commodore || \
  die "Could not start commodore"

echo "Starting harbourmaster"
erl docker run -d -v /var/run/docker.sock:/var/run/docker.sock --link=etcd:etcd --name harbourmaster navyproject/harbourmaster || \
  die "Could not start harbourmaster"

echo "Starting coastguard"
erl docker run -d -v /var/run/docker.sock:/var/run/docker.sock --link=etcd:etcd --name coastguard navyproject/coastguard || \
  die "Could not start coastguard"

echo "Starting navyapi"
erl docker run -d --link=etcd:etcd --name navyapi -p 4040:4040 navyproject/navyapi || \
  die "Could not start navyapi"

echo "Starting navystreamwatcher"
erl docker run -d --name navystreamwatcher -p 4041:4041 navyproject/navystreamwatcher || \
  die "Could not start navystreamwatcher"
