# Dev Environment Cheatsheet

- [Dotfiles - Thoughtbot](#dotfiles---thoughtbot)
  * [Installation of Thoughtbot Dotfiles on Linux](#installation-of-thoughtbot-dotfiles-on-linux)
- [Console/Shell](#consoleshell)
  * [fzf](#fzf)
- [Password Manager](#password-manager)
- [I3 Window Manager](#i3-window-manager)
- [Ubuntu](#ubuntu)
  * [Screenhots](#screenhots)
    + [To take a screenshot of a window:](#to-take-a-screenshot-of-a-window)
    + [To take a screenshot of a selectable region:](#to-take-a-screenshot-of-a-selectable-region)
  * [Display info (external screens etc)](#display-info-external-screens-etc)
    + [List active monitors](#list-active-monitors)
    + [Info about all displays](#info-about-all-displays)
- [Tmux](#tmux)
  * [Prefix](#prefix)
  * [Help, key bindings](#help-key-bindings)
  * [Resource config files](#resource-config-files)
  * [New Session with ``](#new-session-with-)
  * [Rename a session](#rename-a-session)
  * [Kill a session](#kill-a-session)
  * [Kill the current session](#kill-the-current-session)
  * [Detach from a session](#detach-from-a-session)
  * [List sessions](#list-sessions)
  * [Selecting text](#selecting-text)
  * [Scroll through the terminal](#scroll-through-the-terminal)
  * [Copy/Paste in panes with tmux buffers](#copypaste-in-panes-with-tmux-buffers)
    + [Default](#default)
    + [Vim mappings](#vim-mappings)
  * [Tmux Plugin Manager](#tmux-plugin-manager)
    + [Install plugins and refresh](#install-plugins-and-refresh)
  * [tmux-continuum and tmux-resurrect](#tmux-continuum-and-tmux-resurrect)
    + [Save the current tmux session](#save-the-current-tmux-session)
    + [Restore the last saved tmux session](#restore-the-last-saved-tmux-session)
  * [Panes in Tmux](#panes-in-tmux)
    + [Split pane horizontally](#split-pane-horizontally)
    + [Split pane vertically](#split-pane-vertically)
    + [Navigate panes (with vim mapping)](#navigate-panes-with-vim-mapping)
    + [Zoom into or out of a pane](#zoom-into-or-out-of-a-pane)
    + [Cycle through zoomed panes](#cycle-through-zoomed-panes)
    + [Convert a pane to a window](#convert-a-pane-to-a-window)
    + [Close the current pane](#close-the-current-pane)
- [Vim](#vim)
  * [System clipboard access (linux)](#system-clipboard-access-linux)
  * [Edit commands](#edit-commands)
  * [CtrlP and FZF](#ctrlp-and-fzf)
  * [Colortest](#colortest)
  * [vim-plug](#vim-plug)
- [Find command - Ripgrep](#find-command---ripgrep)
  * [Show only filenames of files whose contents match the pattern](#show-only-filenames-of-files-whose-contents-match-the-pattern)
  * [Search only files of a given type with -t (example: python files)](#search-only-files-of-a-given-type-with--t-example-python-files)
  * [Show the filenames of files whose filenames match the pattern (aliased to `rgf`)](#show-the-filenames-of-files-whose-filenames-match-the-pattern-aliased-to-rgf)
  * [Control over ignore/skip of files](#control-over-ignoreskip-of-files)
    + [Include all files when searching:](#include-all-files-when-searching)
    + [Include all files and search filenames:](#include-all-files-and-search-filenames)
- [Git and GitHub](#git-and-github)
  * [Remotes](#remotes)
    + [Show the remotes for the current project](#show-the-remotes-for-the-current-project)
    + [Switch to the ssh remote url](#switch-to-the-ssh-remote-url)
  * [Cloning over HTTPS or SSH](#cloning-over-https-or-ssh)

<TOC>

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

### Display info (external screens etc)

#### List active monitors
```
xrandr --listactivemonitors
```
```
xrandr --listmonitors
```

#### Info about all displays
```
xrandr
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

### Kill the current session
```
<prefix> x
```
Then confirm.

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


### tmux-continuum and tmux-resurrect

  I'm using [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) and [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) for [saving and restoring tmux sessions](https://andrewjamesjohnson.com/restoring-tmux-sessions/). Sessions are auto-saved every 15 minutes, but sometimes I manually save them.

#### Save the current tmux session

```
<prefix> C-s
```

#### Restore the last saved tmux session

```
<prefix> C-r
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


### Colortest

```
:runtime syntax/colortest.vim
```

### vim-plug

Thoughtbot uses [vim-plug](https://github.com/junegunn/vim-plug) as the default
vim plugin manager. To install a plugin, edit `~/.vimrc.bundles.local` (which
should symlink to your local overrides, and add an entry for a plugin like this:
```
Plug 'maxmellon/vim-jsx-pretty'
```
Then source .vimrc (or exit and return) and run the install command:
```
:so ~/.vimrc
:PlugInstall
```

Sometimes I've found that I have to put the full github path in for some
plugins, as can be seen in the [bundle
file](https://github.com/andypayne/dotfiles-local/blob/master/vimrc.bundles.local)
in my local overrides. I also remove some problematic plugins installed by
Thoughtbot's defaults.


## Find command - Ripgrep

Use [Ripgrep](https://github.com/BurntSushi/ripgrep):
```zsh
rg <pattern>
```
```zsh
rg -i <case-insensitive pattern>
```

### Show only filenames of files whose contents match the pattern
```zsh
rg -l <pattern>
```

### Search only files of a given type with -t (example: python files)
```zsh
rg -tpy <pattern>
```

### Show the filenames of files whose filenames match the pattern (aliased to `rgf`)
```zsh
rg --files | rg <pattern>
```


### Control over ignore/skip of files

By default, ripgrep will ignore binary files, hidden files, and files listed in
.gitignore files. This behavior can be changed, from the usage:

```
    -u, --unrestricted
            Reduce the level of "smart" searching. A single -u won't respect .gitignore
            (etc.) files. Two -u flags will additionally search hidden files and
            directories. Three -u flags will additionally search binary files.

            -uu is roughly equivalent to grep -r and -uuu is roughly equivalent to grep -a -r.
```


#### Include all files when searching:
```zsh
rg -uuu <pattern>
```

#### Include all files and search filenames:
```zsh
rg -uuu --files | rg -uuu <pattern>
```


## Git and GitHub

### Remotes

#### Show the remotes for the current project
```
git remote -v
```

#### Switch to the ssh remote url
```
git remote set-url origin git@github.com:path/to/repo.git
```
Ex:
```
git remote set-url origin git@github.com:andypayne/dev_cheatsheet.git
```

### Cloning over HTTPS or SSH

Github now recommmends cloning over HTTPS in their [setup
guide](https://help.github.com/en/github/getting-started-with-github/set-up-git#next-steps-authenticating-to-github-from-git). No reasons are provided in the guide, but it could be because of the extra key exchange and ssh setup steps.

You can use a credential helper to cache your github credentials when using
HTTPS, as described in [this
article](https://help.github.com/en/github/using-git/caching-your-github-password-in-git).

