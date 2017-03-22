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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# added by Anaconda3 4.2.0 installer
export PATH="/home/ssridhar/opt/anaconda3/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ssridhar/opt/google-cloud-sdk/path.bash.inc' ]; then source '/home/ssridhar/opt/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ssridhar/opt/google-cloud-sdk/completion.bash.inc' ]; then source '/home/ssridhar/opt/google-cloud-sdk/completion.bash.inc'; fi
