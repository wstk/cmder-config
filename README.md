# Custom configuration for `cmder`

Download cmder from [](https://cmder.app/). Install by unzipping the contents to a folder of your choice.

Set `CMDER_ROOT` to point to the root folder

```
setx CMDER_ROOT <path to your installed folder>
```

Run `apply.cmd` to copy the config files from this repo into the `CMDER_ROOT\config` folder where they will
overwrite the existing files.

Once copied the files are not linked. They can be customised within `CMDER_ROOT\config`. To re-update, simply pull any
changes to this repo and re run `apply.cmd`

## User-specific config

As this is intended to be a 'generic' repository, it does not contain user specific settings, but these can be added if required.

### `%CMDER_ROOT%\config\user_profile.cmd`

This file can be used to set environment variables or modify the search path for the console session.

For example, to add your own folder to the search path use

```
set PATH=%PATH%;C:\some\local\folder
```

If you had scripts or tools saved in `C:\some\local\folder` you could then execute them without having to specify the full path.


### `%CMDER_ROOT\config\user_aliases.cmd`

This file can be used to set useful aliases, that can shorten commonly used commands. 

Add aliases to each line in the following form

```
alias=command
```

Again, these can be user specific - for example to move to commonly used directories, or run custom tools or scripts. They can also be very useful in shortening commonly used git commands.

Here is a sample of useful aliases you may wish to implement

```
# Open Windows Explorer at the current directory
here=explorer .

# Switch to users home directory
me=cd /d %USERPROFILE%

# Some useful git commands. Note $* means "take all additional arguments"
gl=git log --oneline --decorate  -n 15 $*
gla=git log --oneline --all --graph --decorate --max-count=50 -n 30 $*
gs=git status
gk=gitk --all
gc=git commit $*
gf=git fetch 
gpl=git pull
gps=git push $*
gco=git checkout $*
gd=git diff $*
```

You can copy the above into your `user_aliases.cmd` file, and add to or edit as per your own requirements.

