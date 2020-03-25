# Dev Environment Cheatsheet

## Dotfiles - Thoughtbot

I'm using the [Thoughtbot Dotfiles](https://github.com/thoughtbot/dotfiles) with
a few local overrides (TODO: share dotfiles-local). Thanks to
[Greg](https://github.com/glhewett) as usual, for turning me on to Thoughtbot.
More instructions are on the repo page, as well as the readme for the local
overrides.

### Installation of Thoughtbot Dotfiles on Linux

Clone the [Thoughtbot Dotfiles repo](https://github.com/thoughtbot/dotfiles), and then install rcm:

```bash
git clone git://github.com/thoughtbot/dotfiles.git ~/dotfiles
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt-get update
sudo apt-get install rcm
env RCRC=$HOME/dotfiles/rcrc rcup
```

Now `rcup` can be run without the environment variable set.


## Console/Shell

### fzf

- Trigger fzf and place the result at the command line: `C-t`
- Change directory to the result of fzf: `M-c` (`Alt-c`)
- Change directory to the result of fzf: `cd **<tab>`
- Search command history with fzf: `C-r`

## Password Manager

[KeepassXC](https://keepassxc.org/) on Ubuntu, soon to be on Mac and Windows
(when needed)


## I3 Window Manager

*TODO*


## Tmux

- I'm currently running:
  - [Tmux v3.0a](https://github.com/tmux/tmux/releases/tag/3.0a) on Ubuntu Linux
  - An outdated Tmux 2.3 on Mac (need to update)
- [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)

### Prefix

I map my prefix/leader to `C-a` for easier typing.

### Help, key bindings
```
<prefix> ?
```

### Resource config files
```
tmux source ~/.tmux.conf
```
```
<prefix> :source ~/.tmux.conf
```

### New Session with `<name>`
```
tmux new -s <name>
```
```
:new -s <name>
```

### Rename a session
```
<prefix> $
```

### Kill a session
```
tmux kill-session -t <name>
```

### Detach from a session
```
<prefix> d
```

### List sessions
```
tmux ls
```
Switch sessions quickly and visually with:
```
<prefix> s
```

### Selecting text

Hold shift and select text to copy from the terminal.

### Tmux Plugin Manager

Using [tpm](https://github.com/tmux-plugins/tpm)

#### Install plugins and refresh

```
<prefix> I
```


## Vim

### System clipboard access (linux)

Check for the proper compile flags:
```
vim --version | grep clipboard
```

You should have `+clipboard` and `+xterm_clipboard`. If not then install another
vim, I used `vim-gnome`:

```
sudo apt install vim-gnome
```

Now you should have `+clipboard` and `+xterm_clipboard`. More info on the [Vim
Tips Wiki](https://vim.fandom.com/wiki/Accessing_the_system_clipboard).


```
set clipboard=unnamed
set clipboard=unnamedplus
```

Use `"+y` to yank to the system clipboard.


### Edit commands

Edit the previous file: `:e#`


### CtrlP and FZF

To get CtrlP fuzzy file open working, I installed fzf from github:

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
 ~/.fzf/install
```
And then edit the dotfiles to move the insertions into the local overrides.

Find files:
```
:Files [path]
```
Find Git files:
```
:GFiles [path]
```
Find in buffers:
```
:Buffers
```

To find text in files - [Ripgrep](https://github.com/BurntSushi/ripgrep):
```
:Rg [pattern]
```


## Find command - Ripgrep

Use [Ripgrep](https://github.com/BurntSushi/ripgrep):
```zsh
rg <pattern>
```
```zsh
rg -i <case-insensitive pattern>
```

