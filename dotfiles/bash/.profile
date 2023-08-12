# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set $PATH with ~/.path and /usr/bin/env with ~/.exports
for file in ~/.{path,exports}; do
    [ -r $file ] && [ -f $file ] && . $file
done
unset file

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
# =====
# REMEMBER: If you installed anything else that must be included in PATH or
# needs to export any env variable, be sure to add them to the files .path and
# .exports cited above instead of here
# =====
