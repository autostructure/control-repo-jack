#!/bin/bash
#
# Bootstrap the puppet agent installation
#
# This script will install the puppet agent with a trusted fact that matches the role given during provisioning
#
# This script does the following:
# - Takes a pp_role argument. This should be passed in as a parameter from the ARM template.
# - Makes the csr_attributes.yaml file with pp_role.
# - Connects to the Puppet Master and installs the agent. The Puppet Master will be hardcoded for now since it should not change.
# - Adds puppet commands to $PATH
# - Runs puppet agent -t. This generates a certificate with the trusted fact. It should be autosigned and start configuration immediately.
#

# Usage
if [ $# -eq 0 ]; then
  echo "Puppet Agent Bootstrap"
  echo "Usage: $0 <pp_role>"
  exit 1
fi

# Create /etc/puppetlabs/puppet/csr_attributes.yaml
echo "Creating /etc/puppetlabs/puppet/csr_attributes.yaml"
mkdir -p /etc/puppetlabs/puppet
echo "Adding trusted fact pp_role = $1"
touch /etc/puppetlabs/puppet/csr_attributes.yaml
echo "extension_requests:
  pp_role: $1" > /etc/puppetlabs/puppet/csr_attributes.yaml

# Connect to Puppet master
echo "Connecting to Puppet Master and installing Puppet Agent"
curl -k https://puppetmaster.tqhqlio544vudmnft5liynzthc.ax.internal.usgovcloudapp.net:8140/packages/current/install.bash | sudo bash

# Add Puppet commands to $PATH
echo "Adding /opt/puppetlabs/bin to \$PATH"
PATH=$PATH:/opt/puppetlabs/bin/

# First Puppet Run
echo "Executing first Puppet run"
puppet agent -t

