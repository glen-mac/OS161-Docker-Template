# Terminal colours (after installing GNU coreutils)
NM="\[\033[0;38m\]" #means no background and white lines
HI="\[\033[0;37m\]" #change this for letter colors
HII="\[\033[0;31m\]" #change this for letter colors
SI="\[\033[0;33m\]" #this is for the current directory
IN="\[\033[0m\]"
export PS1="$NM[ $HI\u@$HII\h $SI\w$NM ]\$ $IN"

if [ "$TERM" != "dumb" ]; then
  export LS_OPTIONS='--color=auto'
  #eval `dircolors ~/.dir_colors`
fi

# Useful aliases
alias ls='ls $LS_OPTIONS -hF'
alias ll='ls $LS_OPTIONS -alhF'

export OS_ASS=ASST2
export OS_DIR=/root/os161-src 

# -r to rebuild the whole OS (if you added or removed files)
# -u to rebuild userland programs
oscompile() {                                                                   
  cd $OS_DIR     
  while getopts ":ru" opt; do
    case $opt in
      r)
        cd $OS_dir/kern/conf
        ./config $OS_ASS
        cd ../compile/$OS_ASS
        bmake depend
        ;;
      u)
        cd $OS_DIR
        bmake && bmake install
        ;;
    esac
  done
  cd $OS_DIR/kern/compile/$OS_ASS
  bmake && bmake install
  cd $OS_DIR     
}
