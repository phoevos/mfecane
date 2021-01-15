#!/bin/bash

# Transfer a file from local host to zybo.

# Move from local to portal
scp -r $1 g22@portal.microlab.ntua.gr:~/

# Move from portal to zybo
zscp -r g22@portal.microlab.ntua.gr:~/$1 root@zybo08:~/$2