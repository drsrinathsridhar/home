#!/bin/bash
# Sets the monitor DVI-I-1 as primary.
# [ 2013-May-16 ]: The primary is the 24" Dell monitor on the right.
# TODO: [ 2014-Jan-16 ]: New monitors are both the same size. Need to just swap them when this script is called.
xrandr --output DVI-I-1 --primary
