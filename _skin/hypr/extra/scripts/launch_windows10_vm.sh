#!/bin/bash

# Start windows 10

virsh start win10 &
#
while [[ $(virsh domstate win10) != "running" ]]; do
  sleep 1
done
# wait 5 sec to make sure windows 10 have started

# Launch Windows 10 in full-screen
virt-viewer --full-screen win10
