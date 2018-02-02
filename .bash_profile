###############
#    PROMPT   #
###############

function parse_git_dirty {
        status=`git status 2>&1 | tee`
        dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
        untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
        ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
        newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
        renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
        deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
        bits=''
        if [ "${renamed}" == "0" ]; then
                bits="♻️${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
                bits="🏎️${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
                bits="🆕${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
                bits="🕵${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
                bits="❌${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
                bits="🔥${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
                echo "${bits}"
        else
                echo ""
        fi
}

export PS1="\[\e[36m\]\[\e[33m\]\W\[\e[m\] \[\e[32m\]\`parse_git_branch\`\[\e[m\] \$ "

###############
#     GIT     #
###############

alias fetch="git fetch --all --prune"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gh="file_changed"
alias gl="git log"
alias glo="git log --oneline"
alias gr="git checkout"
alias gs="git status"
alias stage="git diff --staged"
alias pruner="git prune --expire=now; git reflog expire --expire-unreachable=now --rewrite --all"

###############
#    UPDATE   #
###############

alias pull="git pull upstream"
alias push="git push origin"
alias pick="git cherry-pick"

##############
#  FUNCTION  #
##############

gri(){
        git rebase -i HEAD~$1
}

file_changed(){
        git diff $1 $2  --name-only | sed 's/^/\.\//' 
}

###############
#   GENERAL   #
###############

alias profile="sudo vim ~/.bash_profile"
