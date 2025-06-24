# notez

This is a simple repo to organize your TODOs.
* It will copy over yesterday's todos into todays list. 
* Open a given day's list running `notez` in the terminal, after installing the script in your `bashrc`. 
* If you add the crontab entry, it will commit and upload all your todo files to github.

Clone this repo into some location (examples below use `~/rtmp`)
``
$ mkdir -p ~/rtmp
$ cd ~/rtmp
$ git clone ...this repo...
```

Add this to your `~/.bashrc`, it will allow you to run `notez` to open the right file daily
```bash
notez() {
  local dir=~/rtmp/notez
  local today=$(date +%d%m%y)
  local file="$dir/$today.md"
  local prev=$(date -d "yesterday" +%d%m%y)
  local prevfile="$dir/$prev.md"

  mkdir -p "$dir"

  if [[ ! -f "$file" ]]; then
    {
      # if yesterday’s note exists, copy everything from its ## TODO section onward
      if [[ -f "$prevfile" ]]; then
        sed -n '/^## TODO/,$p' "$prevfile"
      else
        echo "## TODOs"
	echo ""
      fi
    } > "$file"
  fi

  ${EDITOR:-vim} "$file"
}
```

And add this to your cron (run `crontab -e`), it will back your notes up to github daily
```
5 9 * * * ~/rtmp/notez/daily_commit.sh >> ~/rtmp/notez/cron.log 2>&1
```

