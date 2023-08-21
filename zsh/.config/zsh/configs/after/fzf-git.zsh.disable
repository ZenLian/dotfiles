#!/usr/bin/env bash
# https://github.com/wfxr/forgit

export FZF_GIT_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:-} --height=80% --ansi"
export FZF_GIT_PREVIEW_CONTEXT=2
export FZF_GIT_FULL_CONTEXT=10

export FZF_GIT_PAGER="$(git config core.pager || echo 'bat --color=always -p -ldiff')"
# export FZF_GIT_SHOW_PAGER="$(git config pager.show || echo "$FZF_GIT_PAGER")"
# export FZF_GIT_DIFF_PAGER="$(git config pager.diff || echo "$FZF_GIT_PAGER")"

fzfgit_extract_sha='sed -nE "s/[^a-f0-9]*([a-f0-9]+).*/\1/p"'
fzfgit::inside_work_tree() { git rev-parse --is-inside-work-tree >/dev/null; }
fzfgit::previous_commit() {
    # "SHA~" is invalid when the commit is the first commit, but we can use "--root" instead
    if [[ "$(git rev-parse "$1")" == "$(git rev-list --max-parents=0 HEAD)" ]]; then
        echo "--root"
    else
        echo "$1~"
    fi
}

# git log
fgl() {
    fzfgit::inside_work_tree || return 0
    local files=$(sed -nE 's/.*-- (.*)/\1/p' <<< "$*")
    local log_format='%C(auto)%h%d %s %C(black)%C(bold)%cr%Creset'
    local git_cmd="git log --color=always --format='$log_format' $*"
    local preview_cmd="echo {} | $fzfgit_extract_sha | xargs -I% git show --color=always -U$FZF_GIT_PREVIEW_CONTEXT % -- $files | $FZF_GIT_PAGER"
    local enter_cmd="echo {} | $fzfgit_extract_sha | xargs -I% git show --color=always -U$FZF_GIT_FULL_CONTEXT % -- $files | $FZF_GIT_PAGER"
    # TODO: ctrl-y Copy full SHA
    local opts=" \
        $FZF_GIT_DEFAULT_OPTS \
        +s +m --tiebreak=index \
        --bind='enter:execute($enter_cmd)' \
        --bind='ctrl-y:execute-silent(echo -n {} | $fzfgit_extract_sha | ${FZF_COPY_CMD:-xclip})' \
        --preview='$preview_cmd' \
        "
    eval "$git_cmd" | FZF_DEFAULT_OPTS="$opts" $(fzfcmd)
    ret=$?
    # exit successfully on 130 (ctrl-c/esc)
    [[ $ret == 130 ]] && return 0
    return $ret
}

# git status(stage/unstage)
fgs() {
    fzfgit::inside_work_tree || return 0
    # TODO: handle space separated file name
    local stage_action='selected={+-1} && for f in ${(Q)selected}; do git add $f; done'
    local unstage_action='selected={+-1} && for f in ${(Q)selected}; do git restore --staged $f; done'
    local git_cmd='git -c color.status=always -c status.relativePaths=true status -su'
    local preview_cmd=" \
        file={-1} && \
        if [[ \$file =~ '^\\?\\?' ]]; then \
            git diff --color=always --no-index -- /dev/null \$file | $FZF_GIT_PAGER | sed '2 s/added:/untracked:/'; \
        else \
            git diff --color=always -- \$file | $FZF_GIT_PAGER; \
        fi"
    local opts=" \
        $FZF_GIT_DEFAULT_OPTS \
        -0 -m --nth 2..,.. \
        --preview=\"$preview_cmd\" \
        --bind='alt-s:execute-silent($stage_action)+reload($git_cmd)' \
        --bind='alt-u:execute-silent($unstage_action)+reload($git_cmd)' \
        --bind='ctrl-y:execute-silent(echo -n {})+reload($git_cmd)' \
    "
    local selected=$(eval "${git_cmd}" | FZF_DEFAULT_OPTS="$opts" $(fzfcmd))
    # [[ -n $selected ]] && $EDITOR ${=selected}
    echo ${=selected}
}

#
