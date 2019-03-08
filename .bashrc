# DO NOT MODIFY THIS FILE! Your changes will be overwritten!
# For user-customization, please edit ~/.bashrc.user
#
# $ROOT$
#
# CSD-CF miles 2003-01-24

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

#if [ "x$SHLVL" != "x1" ]; then # We're not a login shell
        for i in /afs/cs/etc/profile.d/*.sh; do
                if [ -r "$i" ]; then
                        . $i
                fi
        done
#fi


# Source user modifications
if [ -f ${HOME}/.bashrc.user ]; then
        . ${HOME}/.bashrc.user
fi

# added by Anaconda3 4.4.0 installer
export PATH="/home/ssrinath/local/anaconda3/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ssrinath/google-cloud-sdk/path.bash.inc' ]; then . '/home/ssrinath/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ssrinath/google-cloud-sdk/completion.bash.inc' ]; then . '/home/ssrinath/google-cloud-sdk/completion.bash.inc'; fi
