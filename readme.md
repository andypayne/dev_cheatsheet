# Dev Environment Cheatsheet

- [Dotfiles - Thoughtbot](#dotfiles---thoughtbot)
  * [Installation of Thoughtbot Dotfiles on Linux](#installation-of-thoughtbot-dotfiles-on-linux)
- [Console/Shell](#consoleshell)
  * [fzf](#fzf)
- [Password Manager](#password-manager)
- [I3 Window Manager](#i3-window-manager)
- [Ubuntu](#ubuntu)
  * [Screenshots](#screenshots)
    + [To take a screenshot of a window:](#to-take-a-screenshot-of-a-window)
    + [To take a screenshot of a selectable region:](#to-take-a-screenshot-of-a-selectable-region)
  * [Screen recordings](#screen-recordings)
  * [Display info (external screens etc)](#display-info-external-screens-etc)
    + [List active monitors](#list-active-monitors)
    + [Info about all displays](#info-about-all-displays)
  * [Processing units](#processing-units)
  * [Network services](#network-services)
- [Tmux](#tmux)
  * [Prefix](#prefix)
  * [Meta](#meta)
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
    + [Restore alias](#restore-alias)
  * [Panes in Tmux](#panes-in-tmux)
    + [Split pane horizontally](#split-pane-horizontally)
    + [Split pane vertically](#split-pane-vertically)
    + [Navigate panes (with vim mapping)](#navigate-panes-with-vim-mapping)
    + [Zoom into or out of a pane](#zoom-into-or-out-of-a-pane)
    + [Cycle through zoomed panes](#cycle-through-zoomed-panes)
    + [Convert a pane to a window](#convert-a-pane-to-a-window)
    + [Close the current pane](#close-the-current-pane)
    + [Move/swap the current pane](#moveswap-the-current-pane)
- [Vim](#vim)
  * [System clipboard access (linux)](#system-clipboard-access-linux)
  * [Edit commands](#edit-commands)
  * [Leader key](#leader-key)
  * [Go to definition/file/etc](#go-to-definitionfileetc)
  * [Macros](#macros)
    + [Record a macro to surround a word in double quotes](#record-a-macro-to-surround-a-word-in-double-quotes)
  * [List registers](#list-registers)
  * [Change inner word](#change-inner-word)
  * [Ex mode substitutions](#ex-mode-substitutions)
  * [Searching in Vim](#searching-in-vim)
    + [Word boundaries](#word-boundaries)
  * [CtrlP and FZF](#ctrlp-and-fzf)
  * [Display full error messages](#display-full-error-messages)
  * [Debugging syntax or plugin issues with syntime](#debugging-syntax-or-plugin-issues-with-syntime)
  * [Colortest](#colortest)
  * [List loaded scripts/plugins](#list-loaded-scriptsplugins)
  * [vim-plug](#vim-plug)
    + [Uninstalling a plugin](#uninstalling-a-plugin)
  * [YouCompleteMe (ycm)](#youcompleteme-ycm)
  * [Fugitive for Git](#fugitive-for-git)
- [Find command - Ripgrep](#find-command---ripgrep)
  * [Show only filenames of files whose contents match the pattern](#show-only-filenames-of-files-whose-contents-match-the-pattern)
  * [Search only files of a given type with -t (example: python files)](#search-only-files-of-a-given-type-with--t-example-python-files)
  * [Show the filenames of files whose filenames match the pattern (aliased to `rgf`)](#show-the-filenames-of-files-whose-filenames-match-the-pattern-aliased-to-rgf)
  * [Control over ignore/skip of files](#control-over-ignoreskip-of-files)
    + [Include all files when searching:](#include-all-files-when-searching)
    + [Include all files and search filenames:](#include-all-files-and-search-filenames)
- [Git and GitHub](#git-and-github)
  * [Remotes](#remotes)
  * [Diffs](#diffs)
    + [Show code diffs with logs](#show-code-diffs-with-logs)
    + [Show the remotes for the current project](#show-the-remotes-for-the-current-project)
    + [Switch to the ssh remote url](#switch-to-the-ssh-remote-url)
    + [Show diffs of staged files](#show-diffs-of-staged-files)
  * [Cloning over HTTPS or SSH](#cloning-over-https-or-ssh)
  * [Getting the abbreviated commit hash for a commit](#getting-the-abbreviated-commit-hash-for-a-commit)
  * [Reverting the last commit](#reverting-the-last-commit)
  * [Forks](#forks)
  * [Submodules](#submodules)
- [`pkg-config` notes](#pkg-config-notes)
- [Delete empty directories](#delete-empty-directories)
- [Hex dumps](#hex-dumps)

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

### Screenshots

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


### Screen recordings

To record the screen I'm using [Peek](https://github.com/phw/peek). It has a
draggable region and options for saving as a gif, webm, or mp4.


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


### Processing units

When determining how many parallel jobs to pass to `make -j`, use `nproc`:
```shell
nproc

12
```

You can use `make -j$(nproc)` but I'm sparing a few by using `make -j8`.


### Network services

To see info on all running services that are listening on the network:
```shell
ss -atpu
```


## Tmux

- I'm currently running:
  - [Tmux v3.0a](https://github.com/tmux/tmux/releases/tag/3.0a) on Ubuntu Linux
  - An outdated Tmux 2.3 on Mac (need to update)
- [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)

### Prefix

I map my prefix/leader to `C-a` for easier typing.

### Meta

On Mac, in iTerm2, I edit my session to remap the left alt key as Meta (Esc+),
more info:
- https://thinkingeek.com/2012/11/17/mac-os-x-iterm-meta-key/
- https://www.iterm2.com/faq.html

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

#### Restore alias

To avoid extra steps starting tmux and then restoring, I use an alias to
automate it. This is from this [issue filed on tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect/issues/139).

```shell
alias mux='pgrep -vx tmux > /dev/null && \
           tmux new -d -s delete-me && \
           tmux run-shell $TMUX_DIR/plugins/tmux-resurrect/scripts/restore.sh && \
           tmux kill-session -t delete-me && \
           tmux attach || tmux attach'
```

Note that this relies on setting `$TMUX_DIR`, which I do in `~/dotfiles-local/zshrc.local`:

```shell
TMUX_DIR=$HOME/.tmux
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

#### Move/swap the current pane

Move the current pane left:
```
<prefix> {
```

Move the current pane right:
```
<prefix> }
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


### Leader key

To show your leader key:
```
:echo mapleader
```
or
```
:let mapleader
```

If it's the space key, it might show up as empty. To see this more explicitly,
run:
```
:nmap showleader :echo('leader key is "<Leader>"')<Esc>| exec 'norm showleader'|
nun showleader
```
When using space as the leader it prints:
```
leader key is " "
```


### Go to definition/file/etc

For a keyword under the cursor:
- `gd` for the local definition
- `gD` for the global definition
- `g*` and `g#` to search forward/backward
- `gf` to open the file under the cursor
- `g]` to jump to a tag definition


### Macros

#### Record a macro to surround a word in double quotes

Yes, this can be done with [surround.vim](https://github.com/tpope/vim-surround) instead.

1. Press `q` and a `<register>` to record into to begin recording, for example: `qa`
2. Press `viwo<Esc>` to go to the beginning of the current word, if not already there. Using `wb` will work, except where the word is at the end of a file.
3. Press `i` to insert and type a quote `"` (or single quote or other surround character you want to use) and then `<Esc>` to leave insert mode.
4. Press `e` to move to the end of the word.
5. Press `a`to append and type a quote `"` again, then `<Esc>`.
6. Press `q` to write to the register.

To use, move the cursor within a word, and press `@<register>`, for example: `@a`.
To repeat the last macro, use `@@`.


### List registers

To list registers, including copied text and recorded macros:
```
:registers
```


### Change inner word

To change the word the cursor is within (vs `cw`):
```
ciw
```

To change the word the cursor is within including the following space:
```
caw
```


### Ex mode substitutions

Some substitutions for ex mode:
- `%` = the current filename
  ```
  :!file %
  readme.md: ASCII text, with very long lines

  Press ENTER or type command to continue
  ```
- `<cword>` = sub the current word under the cursor

For more: `:help cmdline-special`


### Searching in Vim

#### Word boundaries

The word boundary specifiers for vim regex syntax are `\<` and `\>`. To search
for "the" surrounded by word boundaries:
```
/\<the\>
```


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


### Display full error messages
```
:messages
```


### Debugging syntax or plugin issues with syntime

1. Turn syntime on
```
:syntime on
```
2. Cause a redraw or edit (`C-l` or `:e <file>`)

3. Generate a report.
```
:syntime report
```


### Colortest

```
:runtime syntax/colortest.vim
```


### List loaded scripts/plugins
```
:scriptnames
```
To search the loaded scripts
```
:filter /pattern/ scriptnames
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

#### Uninstalling a plugin

Delete or comment out the `Plug` entry, then reload `.vimrc` or restart, and run
`:PlugClean`.


### YouCompleteMe (ycm)

If receiving the error "The ycmd server SHUT DOWN (restart with
:YcmRestartServer)" on launching vim, you may need to launch the ycm server:
```zsh
cd ~/.vim/bundle/YouCompleteMe
./install.py
```


### Fugitive for Git

[fugitive.vim](https://github.com/tpope/vim-fugitive) is a git integration for
vim.

Some commands:
- `:Git` for a summary/status
- `:Git diff` or `:Gdiff`
- `:Git blame` or `:Gblame` for blame
- `:Git mergetool` and `:Git difftool` to load diffs into quickfix
- `:Ggrep` and `:Glgrep`
- `:Git add %` to stage the current file

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

### Diffs

#### Show code diffs with logs
```zsh
git log -p
```
```zsh
git log --graph -p --all
```

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

#### Show diffs of staged files

```
git diff --cached [filename]
```

or:
```
git diff --staged [filename]
```

### Cloning over HTTPS or SSH

Github now recommmends cloning over HTTPS in their [setup
guide](https://help.github.com/en/github/getting-started-with-github/set-up-git#next-steps-authenticating-to-github-from-git). No reasons are provided in the guide, but it could be because of the extra key exchange and ssh setup steps.

You can use a credential helper to cache your github credentials when using
HTTPS, as described in [this
article](https://help.github.com/en/github/using-git/caching-your-github-password-in-git).


### Getting the abbreviated commit hash for a commit

All with relative date, name, and subject:
```shell
git log --pretty="%h %ar %an %s"
```

The last two commits with only the abbreviated hashes:
```shell
git log -2 --pretty=%h
```


### Reverting the last commit

Get the last two commits:
```shell
git log -2 --pretty=%h
78dbbb2
96f95df
```

Revert to the commit before the last one:
```shell
git revert --no-commit 96f95df..HEAD
```

Combo (untested):
```shell
git revert --not-commit `git log -2 --pretty=%h | tail -n 1`..HEAD
```

Revert and push:
```shell
git revert --continue
git push
```

### Forks

Add an upstream repo to a fork:
```shell
git remote add upstream git@github.com:user/repo.git
```

Merge updates from the upstream repo into a fork:
```shell
git fetch upstream
git checkout master
git merge upstream/master
```

Without fast-forwarding:
```shell
git merge --no-ff upstream/master
```


### Submodules

Add a submodule to a project:
```shell
git submodule add git@github.com:user/repo.git
```

Update a submodule:
```shell
git submodule update --remote
```


## `pkg-config` notes

Check for a library/module (OpenCV in this example):
```shell
pkg-config --exists --print-errors opencv4
```

Add `/usr/local/lib/pkgconfig` as a location (set `PKG_CONFIG_PATH` in dotfiles):
```SHELL
mkdir /usr/local/lib/pkgconfig
cp opencv4.pc /usr/local/lib/pkgconfig/
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH
```

```shell
pkg-config --exists --print-errors opencv4
echo $?
0
```


## Delete empty directories

Using find to delete empty directories from `base/path`:
```shell
find base/path -type d -empty -delete
```


## Hex dumps

The `xxd` command can be used to do hex dumps:
```shell
echo "foobar" | xxd
00000000: 666f 6f62 6172 0a                        foobar.
```

