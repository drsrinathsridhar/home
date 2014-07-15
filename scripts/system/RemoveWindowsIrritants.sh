#!/bin/bash
# This script removes the $RECYCLE.BIN folder that (stupid) Windows 7 creates each time I login
# Script designed to be run once during startup of Ubuntu automatically/manually
# Tested in Ubuntu Jaunty/Windows 7 configuration
# Won't work when run multiple times (Fails if no folder found)
# Works only in the present hard disk cnfiguration (links are static)
# Doing this because the presence of that folder just irritates me
# Author: Srinath Sridhar. Written on March 9, 2010

# WARNING 1: Do not know what the implications are in Windows! Use at own risk
# WARNING 2: Deletes even if directory is non-empty

# Setup location of rm command
RMDIR=/bin/rm


$RMDIR -r /media/PERSTORAGE/"\$RECYCLE.BIN"
$RMDIR -r /media/SOFTDUMP/"\$RECYCLE.BIN"
# Not doing the following due to obvious reason
# $RMDIR -r /media/WINDOWS7/"$RECYCLE.BIN"
# OLD COMMENT # EXT partition. Windows 7 does not read
$RMDIR -r /media/MULTIMEDIA/"\$RECYCLE.BIN"
$RMDIR -r /media/PROSTORAGE/"\$RECYCLE.BIN"
$RMDIR -r /media/TEMPSTORAGE/"\$RECYCLE.BIN"
$RMDIR -r /media/WORKAREA/"\$RECYCLE.BIN"


