#Documentation
class profile::java {
  include ::java

  #Make sure Java is up-to-date so that is compatible with Tomcat, which requires Java 6 or higher
  class { 'java' :
  package => 'java-1.8.0-openjdk-devel',
  }
}
