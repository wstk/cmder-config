# Custom configuration for `cmder`

Download cmder from [](https://cmder.app/). Install by unzipping the contents to a folder of your choice.

Set `CMDER_ROOT` to point to the root folder

```
setx CMDER_ROOT=<path to your installed folder>
```

Run `apply-config.cmd` to copy the config files from this repo into the `CMDER_ROOT\config` folder where they will
overwrite the existing files.

Once copied the files are not linked. They can be customised within `CMDER_ROOT\config`. To re-update, simply pull any
changes to this repo and re run `apply-config.cmd`
