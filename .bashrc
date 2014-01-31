# ~/.bashrc: executed by bash(1) for non-login shells. -*-sh-*-
# $Id: bashrc,v 1.1 2011/10/26 12:52:31 sbender Exp $ /mpietc/dotfiles/skel/bashrc
#
# PLEASE DO NOT EDIT!
# make your changes in ~/.bashrc_private instead
#

AUTOPATH="$HOME/.autopath.bash."`uname -s`
if [ -f $AUTOPATH ] ; then
    . $AUTOPATH
fi

if [ -f $HOME/.bashrc_private ] ; then 
    . $HOME/.bashrc_private
fi
