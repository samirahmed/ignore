# Ignore

## Making adding your gitignores super simple

### Why? 

**Its the easiest way to fetch gitignores**

I got irritated making repos then manually fetching gitignores. So I made this.

### How to Install? 

```
> gem install ignore
> ignore update
```

### What Does It Do? 

#### 1. Add simple gitignores in one line

```
$ ignore ruby
```

This is will add github's ruby gitignore to a new or existing `.gitignore` in your current directory

#### 2. Easy updates from [github.com/github/gitignore](https://github.com/github/gitignore)

```
ignore update
```

#### 3. You can add your own gitignores to your ~/.ignores directory

```
cp .gitignore ~/.ignores/custom.gitignore
```

(Just make sure the file is in the `~/.ignores` folder and ends with `.gitignore`)

#### 4. Show you contents of a gitignore

```
ignore show ruby
```

#### 5. List all the possible gitignores available

```
ignore list
```

#### 6. Even comes with zsh autocompletion

just copy the zsh autocomplete function to wherever your autocomplete functions go (it depends on your config)

### Summary

| Command | What it Does |
|:-------:|--------------|
| **list** | Shows you all the gitignores in `~/.ignores` directory|
| **update**| Updates to sync with [github](https://github.com/github/gitignore)|
| **show <language>** | Prints contents of gitignore, best used with `less` command |
| **<language>** | Autogenerates or appends to current directory gitignore the specified languages .gitignore|
| **clean** | Empties your local `~/.ignores` folder |
| **help** | Shows you pretty much same table| 

### Make it Better

Heres the todo list, these are features that make it easier to use, but I havent got around to it yet

- Autoupdate
- better docs
- bash Autocompletion
- Custom remotes for your own gitignores (see the lib/ignore/storage.rb for this)

If you want to help - just fork, push and pull request!

Make issues for bugs or contact [@bazooka_sam](https://twitter.com/bazooka_sam)

