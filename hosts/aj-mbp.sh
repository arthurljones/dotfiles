## Commands specific to my MacBook Pro
##

#Use the GNU coreutils where possible
echo "Using GNU coreutils"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

#SDK stuff
export SENCHA_CMD_3_0_0="/Users/aj/bin/Sencha/Cmd/6.0.2.14"
export ANDROID_SDK_HOME=/Users/aj/workspace/lib/android-sdk
export PATH="$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$PATH"
export PATH="/Users/aj/bin/Sencha/Cmd/6.0.2.14/..:$PATH"

#Ruby Version Manager
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting
[[ -f $HOME/.rvm/scripts/rvm ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
