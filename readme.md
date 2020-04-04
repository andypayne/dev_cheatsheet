# Dev Environment Cheatsheet

* [Dotfiles - Thoughtbot](#dotfiles---thoughtbot)
  + [Installation of Thoughtbot Dotfiles on Linux](#installation-of-thoughtbot-dotfiles-on-linux)
* [Console/Shell](#consoleshell)
  + [fzf](#fzf)
* [Password Manager](#password-manager)
* [I3 Window Manager](#i3-window-manager)
* [Ubuntu](#ubuntu)
  + [Screenhots](#screenhots)
    - [To take a screenshot of a window:](#to-take-a-screenshot-of-a-window)
    - [To take a screenshot of a selectable region:](#to-take-a-screenshot-of-a-selectable-region)
* [Tmux](#tmux)
  + [Prefix](#prefix)
  + [Help, key bindings](#help-key-bindings)
  + [Resource config files](#resource-config-files)
  + [New Session with ``](#new-session-with-)
  + [Rename a session](#rename-a-session)
  + [Kill a session](#kill-a-session)
  + [Detach from a session](#detach-from-a-session)
  + [List sessions](#list-sessions)
  + [Selecting text](#selecting-text)
  + [Scroll through the terminal](#scroll-through-the-terminal)
  + [Copy/Paste in panes with tmux buffers](#copypaste-in-panes-with-tmux-buffers)
  + [Tmux Plugin Manager](#tmux-plugin-manager)
    - [Install plugins and refresh](#install-plugins-and-refresh)
  + [Panes in Tmux](#panes-in-tmux)
    - [Split pane horizontally](#split-pane-horizontally)
    - [Split pane vertically](#split-pane-vertically)
    - [Navigate panes (with vim mapping)](#navigate-panes-with-vim-mapping)
    - [Zoom into or out of a pane](#zoom-into-or-out-of-a-pane)
    - [Convert a pane to a window](#convert-a-pane-to-a-window)
    - [Close the current pane](#close-the-current-pane)
* [Vim](#vim)
  + [System clipboard access (linux)](#system-clipboard-access-linux)
  + [Edit commands](#edit-commands)
  + [CtrlP and FZF](#ctrlp-and-fzf)
* [Find command - Ripgrep](#find-command---ripgrep)
  + [Show only filenames whose contents match the pattern](#show-only-filenames-whose-contents-match-the-pattern)


## Dotfiles - Thoughtbot

I'm using the [Thoughtbot Dotfiles](https://github.com/thoughtbot/dotfiles) with
a few [local overrides](https://github.com/andypayne/dotfiles-local). Thanks to
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


## Ubuntu

### Screenhots

[Ubuntu Screenshots and
Screencasts](https://help.ubuntu.com/stable/ubuntu-help/screen-shot-record.html)

#### To take a screenshot of a window:
```
Prt Scrn
```

#### To take a screenshot of a selectable region:
```
Shift + Prt Scrn
```


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


### Scroll through the terminal
Enable scroll/copy mode:
```
<prefix> [
```
Then use normal navigation (`h/j/k/l`) to navigate.
Disable with:
```
q
```

### Copy/Paste in panes with tmux buffers

More
[here](https://www.rushiagr.com/blog/2016/06/16/everything-you-need-to-know-about-tmux-copy-pasting-ubuntu/), including info on changing key bindings to match vim.

#### Default

1. Enable scroll/copy mode:
```
<prefix> [
```

2. Enter visual select mode:
```
<space>
```

3. Navigate to select a region

4. Copy the region:
```
<prefix> w
```

5. Paste the copied text:
```
<prefix> ]
```

#### Vim mappings

1. Enable scroll/copy mode:
```
<prefix> [
```

2. Enter visual select mode:
```
v
```

3. Navigate to select a region

4. Copy the region:
```
y
```

5. Paste the copied text:
```
<prefix> P
```


### Tmux Plugin Manager

Using [tpm](https://github.com/tmux-plugins/tpm)

#### Install plugins and refresh

```
<prefix> I
```

### Panes in Tmux

#### Split pane horizontally
```
<prefix>"
```
With mapping:
```
<prefix>-
```

#### Split pane vertically
```
<prefix>%
```
With mapping:
```
<prefix>|
```

#### Navigate panes (with vim mapping)
```
<prefix>h/j/k/l
```

#### Zoom into or out of a pane
```
<prefix> z
```

#### Cycle through zoomed panes
From [this question](https://superuser.com/questions/772700/switching-tmux-zoom-between-panes-without-zooming-out)

Add this mapping:
```
bind -r a select-pane -t .+1 \;  resize-pane -Z
```

Then cycle through zoomed with `<prefix> a`, `a`, `a`, ...


#### Convert a pane to a window
```
<prefix> !
```

#### Close the current pane
```
<prefix> x
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

### Show only filenames whose contents match the pattern
```zsh
rg -l <pattern>
```


