docker run --rm -v /var/run/docker.sock:/var/run/docker.sock --link=etcd:etcd navyproject/integration_tests bundle exec rspec
