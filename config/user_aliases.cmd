;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here

ls=ls --show-control-chars -F --color $*
ll=ls --color -l $*
pwd=cd
clear=cls
clc=cls
history=cat -n "%CMDER_ROOT%\config\.history"
unalias=alias /d $1

here=explorer .
me=cd /d %USERPROFILE%
~=cd /d %USERPROFILE%
dev=cd /d C:\dev

grep=grep --color=auto $*

gl=git log --oneline --decorate  -n 15 $*
gla=git log --oneline --all --graph --decorate --max-count=50 -n 30 $*
gs=git status
gitk=gitk --all
gc=git commit $*
gf=git fetch
gpl=git pull
gps=git push $*
gco=git checkout $*
gd=git diff $*




