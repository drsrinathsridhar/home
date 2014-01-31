#!/bin/bash
# Sets the monitor DVI-D-0 as primary.
# [ 2013-May-16 ]: The primary is the 20" Dell monitor on the left.
# TODO: [ 2014-Jan-16 ]: New monitors are both the same size. Need to just swap them when this script is called.
xrandr --output DVI-D-0 --primary
