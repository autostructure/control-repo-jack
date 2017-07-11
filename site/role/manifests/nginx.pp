#Class role::nginx
class role::nginx {
  include ::profile::base
  include ::profile::nginx

  Class['::profile::base']
  -> Class ['::profile::nginx']
}
