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
cmderr=cd /d "%CMDER_ROOT%"
aliases=echo %CMDER_ROOT%\config\user_aliases.cmd
ps1=echo %CMDER_ROOT%\vendor\clink.lua (my_prompt method)

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

vimtutor=vim "C:/Program Files/Git/usr/share/vim/vim90/tutor/tutor"

python2=C:\Python27\python.exe $*
np="C:\Program Files\Notepad++\notepad++.exe" $*
office="C:\users\William.Stokes\Desktop\office.png"


