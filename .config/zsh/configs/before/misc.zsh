# dirs
setopt auto_cd
setopt auto_pushd
setopt pushd_minus
setopt pushd_ignore_dups
setopt pushd_silent
#setopt cdable_vars
# DIRSTACKSIZE=10

## auto correction
setopt correct
# setopt correct_all
alias sudo='nocorrect sudo'
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'

# recognize comments
setopt interactivecomments
setopt long_list_jobs

# tab complete hidden files
setopt globdots

setopt print_exit_value

unsetopt flow_control
