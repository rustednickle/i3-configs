# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

alias c "clear"
alias l "ls -ath"
alias gc "git checkout"
alias gb "git branch"
alias gst "git status"
alias stst "stg status"
alias str "stg refresh"
alias stpu "stg push"
alias stpo "stg pop"
alias sts "stg series"
alias stsh "stg show"
alias cdl "cd ~/Documents/linux/"
alias cdi "cd ~/Documents/ibm/tools"
alias du "ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias gl "git log --oneline"
alias scpp "sshpass -p abc123 scp"
alias lg1 "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"

function stsall
	stsh (stg series| awk -v LastLine=(sts |wc -l) -v first="f" -v last="l" '{if (NR==1) first=$2; if (NR==LastLine) last=$2;} END{print first".."last}')
end


function bso
	cat ~/bso_clear.sh.ecp | openssl aes-256-cbc -d | sed "s/fir02/$1/g" | /usr/bin/expect -
end

function hackernews
	curl getnews.tech/hacker-news
end

function sshp8
	set domain $argv1
	sshpass -p abc123 ssh root@$domain -o StrictHostKeyChecking=no UserKnownHostsFile=/dev/null -o LogLevel=quiet
	if [ $status -ne 0 ] 
		ssh-keygen -R $domain;
		sshpass -p abc123 ssh root@$domain -o StrictHostKeyChecking=no
	end
end

function gn
	curl getnews.tech/$1
end

function checkpatch
	scripts/checkpatch.pl --strict $argv
end

export CSCOPE_EDITOR=vim

. /home/lemon/.config/fish/path

alias llm "~/Documents/ibm/tools/lab_access.sh"

# Start X at login
# if status is-login
#     if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
#         exec startx -- -keeptty
#     end
# end
set PATH $PATH /var/lib/snapd/snap/bin /home/lemon/.local/bin
