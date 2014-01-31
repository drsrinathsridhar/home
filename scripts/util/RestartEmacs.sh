#!/bin/bash
emacsclient -e "(kill-emacs)"
# Restart emacs daemon
emacs-24.3 --daemon &
wait

# Open a client
emacsclient -c &
