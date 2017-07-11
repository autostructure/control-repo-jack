#class profile::nginx
class profile::nginx {
  include ::nginx,
  manage_repo => true,
  package_source => 'nginx-mainline',
}

nginx::resource::server {'192.168.0.122':
  www_root => '/opt/html/',
}
