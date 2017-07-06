# == Class: role::tomcat
#
class role::tomcat {
  include ::profile::base
  include ::profile::java
  include ::profile::tomcat

  Class['::profile::base']
  -> Class['::profile::java']
  -> Class['::profile::tomcat']
}
