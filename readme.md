# Dev Environment Cheatsheet

- [Dev Environment Cheatsheet](#dev-environment-cheatsheet)
  * [Dotfiles - Thoughtbot](#dotfiles---thoughtbot)
    + [Installation of Thoughtbot Dotfiles on Linux](#installation-of-thoughtbot-dotfiles-on-linux)
  * [Console/Shell](#consoleshell)
    + [fzf](#fzf)
  * [Password Manager](#password-manager)
  * [Regolith - Tiling I3-based Window Manager](#regolith---tiling-i3-based-window-manager)
  * [Ubuntu](#ubuntu)
    + [Navigation](#navigation)
    + [Screenshots](#screenshots)
      - [To take a screenshot of a window:](#to-take-a-screenshot-of-a-window)
      - [To take a screenshot of a selectable region:](#to-take-a-screenshot-of-a-selectable-region)
    + [Screen recordings](#screen-recordings)
    + [Display info (external screens etc)](#display-info-external-screens-etc)
      - [List active monitors](#list-active-monitors)
      - [Info about all displays](#info-about-all-displays)
    + [Processing units](#processing-units)
    + [Network services](#network-services)
    + [DNS](#dns)
      - [Check whether resolved is running](#check-whether-resolved-is-running)
      - [Flush the resolved DNS cache](#flush-the-resolved-dns-cache)
      - [Check whether network-manager is running](#check-whether-network-manager-is-running)
      - [Restart network-manager](#restart-network-manager)
      - [Status for network-manager](#status-for-network-manager)
    + [inxi - handy for system info](#inxi---handy-for-system-info)
    + [Other network/wifi tools](#other-networkwifi-tools)
  * [Tmux](#tmux)
    + [Prefix](#prefix)
    + [Meta](#meta)
    + [Help, key bindings](#help-key-bindings)
    + [Resource config files](#resource-config-files)
    + [New named session](#new-named-session)
    + [Rename a session](#rename-a-session)
    + [Kill a session](#kill-a-session)
    + [Kill the current session](#kill-the-current-session)
    + [Detach from a session](#detach-from-a-session)
    + [List sessions](#list-sessions)
    + [Attach to the last session](#attach-to-the-last-session)
    + [List key bindings](#list-key-bindings)
    + [Selecting text](#selecting-text)
    + [Scroll through the terminal](#scroll-through-the-terminal)
    + [Copy/Paste in panes with tmux buffers](#copypaste-in-panes-with-tmux-buffers)
      - [Default](#default)
      - [Vim mappings](#vim-mappings)
    + [Paste buffers in Tmux](#paste-buffers-in-tmux)
    + [Tmux Plugin Manager](#tmux-plugin-manager)
      - [Install plugins and refresh](#install-plugins-and-refresh)
    + [tmux-continuum and tmux-resurrect](#tmux-continuum-and-tmux-resurrect)
      - [Save the current tmux session](#save-the-current-tmux-session)
      - [Restore the last saved tmux session](#restore-the-last-saved-tmux-session)
      - [Restore alias](#restore-alias)
    + [Panes in Tmux](#panes-in-tmux)
      - [Split pane horizontally](#split-pane-horizontally)
      - [Split pane vertically](#split-pane-vertically)
      - [Navigate panes (with vim mapping)](#navigate-panes-with-vim-mapping)
      - [Zoom into or out of a pane](#zoom-into-or-out-of-a-pane)
      - [Cycle through zoomed panes](#cycle-through-zoomed-panes)
      - [Convert a pane to a window](#convert-a-pane-to-a-window)
      - [Close the current pane](#close-the-current-pane)
      - [Move/swap the current pane](#moveswap-the-current-pane)
  * [Vim](#vim)
    + [System clipboard access (linux)](#system-clipboard-access-linux)
    + [Edit commands](#edit-commands)
    + [Leader key](#leader-key)
    + [Go to definition/file/etc](#go-to-definitionfileetc)
    + [Go to matching brace](#go-to-matching-brace)
    + [Folding](#folding)
    + [Macros](#macros)
      - [Record a macro to surround a word in double quotes](#record-a-macro-to-surround-a-word-in-double-quotes)
    + [List registers](#list-registers)
    + [Change inner word](#change-inner-word)
    + [Changes](#changes)
    + [Apply an edit to each line in a region](#apply-an-edit-to-each-line-in-a-region)
    + [Reverse the order of lines](#reverse-the-order-of-lines)
    + [Ex mode substitutions](#ex-mode-substitutions)
    + [Searching in Vim](#searching-in-vim)
      - [Word boundaries](#word-boundaries)
    + [CtrlP and FZF](#ctrlp-and-fzf)
    + [Display full error messages](#display-full-error-messages)
    + [Debugging syntax or plugin issues with syntime](#debugging-syntax-or-plugin-issues-with-syntime)
    + [Colortest](#colortest)
    + [Color schemes](#color-schemes)
      - [Show the current colorscheme](#show-the-current-colorscheme)
      - [List all installed colorschemes](#list-all-installed-colorschemes)
      - [Set a colorscheme](#set-a-colorscheme)
    + [List loaded scripts/plugins](#list-loaded-scriptsplugins)
    + [vim-plug](#vim-plug)
      - [Uninstalling a plugin](#uninstalling-a-plugin)
    + [Surround](#surround)
    + [YouCompleteMe (ycm)](#youcompleteme-ycm)
      - [Updating ycm](#updating-ycm)
    + [Fugitive for Git](#fugitive-for-git)
    + [NERDTree file navigator](#nerdtree-file-navigator)
    + [vim-vinegar](#vim-vinegar)
    + [vim-hug-neovim-rpc pythonx error](#vim-hug-neovim-rpc-pythonx-error)
  * [Find command - Ripgrep](#find-command---ripgrep)
    + [Show only filenames of files whose contents match the pattern](#show-only-filenames-of-files-whose-contents-match-the-pattern)
    + [Search only files of a given type with -t (example: python files)](#search-only-files-of-a-given-type-with--t-example-python-files)
    + [Show the filenames of files whose filenames match the pattern (aliased to `rgf`)](#show-the-filenames-of-files-whose-filenames-match-the-pattern-aliased-to-rgf)
    + [Control over ignore/skip of files](#control-over-ignoreskip-of-files)
      - [Include all files when searching:](#include-all-files-when-searching)
      - [Include all files and search filenames:](#include-all-files-and-search-filenames)
  * [Git and GitHub](#git-and-github)
    + [Diffs](#diffs)
      - [Show code diffs with logs](#show-code-diffs-with-logs)
      - [Show diffs of staged files](#show-diffs-of-staged-files)
      - [Show the diff of the previous commit](#show-the-diff-of-the-previous-commit)
      - [Show the diff of all changes from when a branch (branch2) branched off from a parent branch (branch1):](#show-the-diff-of-all-changes-from-when-a-branch-branch2-branched-off-from-a-parent-branch-branch1)
      - [Create a patch from a diff:](#create-a-patch-from-a-diff)
    + [Stash](#stash)
      - [Stash interactively](#stash-interactively)
    + [Remotes](#remotes)
      - [Show the remotes for the current project](#show-the-remotes-for-the-current-project)
      - [Switch to the ssh remote url](#switch-to-the-ssh-remote-url)
    + [Cloning over HTTPS or SSH](#cloning-over-https-or-ssh)
    + [Getting the abbreviated commit hash for a commit](#getting-the-abbreviated-commit-hash-for-a-commit)
    + [Reverting the last commit](#reverting-the-last-commit)
    + [Forks](#forks)
    + [Submodules](#submodules)
  * [SSH notes](#ssh-notes)
    + [Sharing keys for passwordless login](#sharing-keys-for-passwordless-login)
  * [`pkg-config` notes](#pkg-config-notes)
  * [Delete empty directories](#delete-empty-directories)
  * [Hex dumps](#hex-dumps)
  * [Bat (replacement for cat)](#bat-replacement-for-cat)
  * [Image, Video, and Audio conversion](#image-video-and-audio-conversion)
    + [Convert from svg to png](#convert-from-svg-to-png)
    + [Show media file info](#show-media-file-info)
    + [Convert a video from mp4 to y4m](#convert-a-video-from-mp4-to-y4m)
    + [Extract audio from a video](#extract-audio-from-a-video)
  * [cheat.sh](#cheatsh)
  * [Key repeats on MacOS](#key-repeats-on-macos)

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


## Regolith - Tiling I3-based Window Manager

[Regolith Linux](https://regolith-linux.org/) has both a standalone distro and a
window manager that can be installed on an existing Ubuntu installation. The
latter is what I'm using.

To install on Ubuntu:
```shell
sudo add-apt-repository ppa:regolith-linux/release
sudo apt update
sudo apt install regolith-desktop i3xrocks-net-traffic i3xrocks-cpu-usage i3xrocks-time
```

Then logout or restart. When logging in with gdm, select the gear icon and
choose Regolith.

Common Keys:
- `Super` is the window key on my laptop
- `Super+Shift+?` - open the shortcut/launcher app
- `Super+Enter` - terminal
- `Super+Shift+Enter` - browser
- `Super+Space` - launch an app
- `Super+Shift+q` - quit an app
- `Super+c` - settings
- `Super+1,2,...` - activate the numbered workspace
- `Super+f` - toggle fullscreen for the active window
- `Super+arrows` - navigate through tiled apps in a workspace
- `Super+Tab` - cycle through apps (instead of `Alt+Tab`)


## Ubuntu

### Navigation

- `Super+arrows` - pin a window to the left or right or maximize it
- `Super+h` - hide (minimize) a window


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


### DNS

#### Check whether resolved is running

An active response indicates it's running:
```shell
sudo systemctl is-active systemd-resolved.service
active
```


#### Flush the resolved DNS cache

```shell
sudo systemd-resolve --flush-caches
```


#### Check whether network-manager is running

```shell
sudo systemctl is-active network-manager
active
```


#### Restart network-manager

```shell
sudo service network-manager restart
```


#### Status for network-manager

```shell
sudo service network-manager status
```


### inxi - handy for system info

```
sudo apt install inxi
```

Network info:
```
inxi -n
```


### Other network/wifi tools

```
nmcli
```

```
nmcli show devices
```

```
iw dev
```

```
iw phy
```

```
lshw -C network
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


### New named session 
To start a new session with `<name>`:
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


### Attach to the last session
```
tmux a
```


### List key bindings

```shell
tmux list-keys
```

or

```
<prefix> :list-keys
```

or

```
<prefix> ?
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


### Paste buffers in Tmux

List paste buffers:
```
<prefix>:list-buffers
```

Show the current buffer:
```
<prefix>:show-buffer
```

Show the second buffer:
```
<prefix>:show-buffer -b 2
```

Save the current paste buffer to a file named filename.txt:
```
<prefix>:save-buffer filename.txt
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
Also: `<leader><space>`, for me: `<space><space>`


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


### Go to matching brace

To jump between matching braces or supported keyword pairs (Ex: `#ifdef/#endif`), use the percent key:

```
%
```


### Folding

I mostly only use folding for large data files, like json files.

Enable:
```
:set foldmethod=syntax
```

Commands:
- `za` toggle a fold
- `zc` close a fold
- `zo` open a fold


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


### Changes

List the changes for the current buffer:
```
:changes
```

Navigate changes:
- `g;` to navigate to the position of the previous change
- `g,` to navigate to the position of the next change


### Apply an edit to each line in a region

1. `c-v` to enter visual block mode
2. Highlight the region
3. Make the edit (ex: `I  foo` to prepend "  foo" to each line)
4. `esc`


### Reverse the order of lines

1. For a region, either specify line numbers or use `v` to highlight a region
2. `:g/^/m123`, where 123 is the destination line number
3. To explicitly specify line numbers, use `:10,20g/^/m9` to reverse lines from 10 to 20.


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


### Color schemes

#### Show the current colorscheme
```
:colorscheme
```

#### List all installed colorschemes
```
:colorscheme <tab>
```

#### Set a colorscheme
```
:colorscheme elflord
```

Others that are ok:
- industry
- koehler
- pablo
- ron
- torte
- zellner


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


### Surround

Some examples:
| Key/Command | Effect |
| ----------- | ------ |
| `cs"'` | Change a surround from "double" to 'single' |
| `cs"[` | Change a surround from "double" to [brackets] |


### YouCompleteMe (ycm)

If receiving the error "The ycmd server SHUT DOWN (restart with
:YcmRestartServer)" on launching vim, you may need to launch the ycm server:
```zsh
cd ~/.vim/bundle/YouCompleteMe
./install.py
```


#### Updating ycm

I had to update ycm due to some issues with an update of golang. Steps I took:
```shell
cd ~/.vim/bundle/YouCompleteMe/third_party/ycmd
git checkout master
git pull
git submodule update --init --recursive
./build.py --go-completer
```


### Fugitive for Git

[fugitive.vim](https://github.com/tpope/vim-fugitive) is a git integration for
vim.

Some commands:
| Key/Command | Effect |
| ----------- | ------ |
| `:Git` | summary/status |
| `:Git diff` or `:Gdiff` | Show diffs |
| `:Git blame` or `:Gblame` | Show blame |
| `:Git mergetool` & `:Git difftool` | Load diffs into quickfix |
| `:Ggrep` and `:Glgrep` | Git grep |
| `:Git add %` | stage the current file |


### NERDTree file navigator

Note: I currently have this disabled while trying `vim-vinegar`.

| Key/Command | Effect |
| ----------- | ------ |
| `:NERDTree` | open NERDTree |
| `o` or `Enter` | open a file or expand a directory |
| `C-arrows`  | navigate between NERDTree and an open file |
| `m`         | open the file menu, which allows creating and deleting files and directories |
| `B`         | open bookmarks |
| `:q`        | close NERDTree |

I map `<leader>ne` to open NERDTree:
```
nmap <leader>ne :NERDTree<cr>
```


### vim-vinegar

[vim-vinegar](https://github.com/tpope/vim-vinegar) is an alternative file
navigation plugin.

| Key/Command | Effect |
| ----------- | ------ |
| `-`         | Replace the current buffer with a directory listing, or move up a level if already in vim-vinegar |
| `I`         | Toggle displaying hidden files and netrw header info |
| `y.`        | Yank the absolute path for the file under the cursor |
| `~`         | Navigate to your home directory |
| `.`         | Start a `:` command sequence with the path of the file, ex: `.grep foo` |
| `!`         | Start a shell command with the path of the file, ex: `!chmod +x` |


### vim-hug-neovim-rpc pythonx error

Error:

```
[vim-hug-neovim-rpc] Vim(pythonx):ModuleNotFoundError: No module named 'neovim'
```

[Fix](https://github.com/roxma/vim-hug-neovim-rpc/issues/47#issuecomment-463410146):

1. Make sure that vim has been compiled with python3 support by running `:ver` or `:echo has('python3')`
2. Run `pip3 install pynvim`
3. Run `pip3 install neovim`


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


### Diffs

#### Show code diffs with logs
```zsh
git log -p
```
```zsh
git log --graph -p --all
```

#### Show diffs of staged files

```
git diff --cached [filename]
```

or:
```
git diff --staged [filename]
```

#### Show the diff of the previous commit

```
git diff HEAD^ HEAD
```

#### Show the diff of all changes from when a branch (branch2) branched off from a parent branch (branch1):

```shell
git diff branch2...branch1
```

#### Create a patch from a diff:

```shell
git diff -u --no-prefix > some_patch.diff
```

Apply the patch:
```shell
patch -p0 -i some_patch.diff
```


### Stash

#### Stash interactively

```shell
git stash save -p "some message"
```

Some options:
```
y - stash
n - don't stash
q - quit
a - stash this hunk and all later hunks in the file
d - don't stash this hunk or any later hunks in the file
```


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


## SSH notes

### Sharing keys for passwordless login

1. Generate a key on the local system, if not yet done.

RSA:
```shell
ssh-keygen -t rsa
```

Ed25519:
```shell
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "user@example.com"
```

2. Copy the public key to the remote system.

```shell
ssh-copy-id -i ~/.ssh/id_rsa.pub username@remote.server
```

3. Try it.


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


## Bat (replacement for cat)

[bat](https://github.com/sharkdp/bat) is a cat alternative with syntax highlighting and git integration.

Install on Ubuntu:
```shell
apt install bat
```

Install on Mac:
```shell
brew install bat
```

Example use with `tail -f`:
```shell
tail -f /var/log/syslog | bat --paging=never -l log
───────┬────────────────────────────────────────────────────────────────────────
       │ STDIN
───────┼────────────────────────────────────────────────────────────────────────
   1   │ Aug 26 09:55:54 host lircd[1288]: lircd-0.10.0[1288]: Error: Cannot glob /sys/class/rc/rc0/input[0-9]*/event[0-9]*
   2   │ Aug 26 09:55:54 host lircd-0.10.0[1288]: Error: Cannot glob /sys/class/rc/rc0/input[0-9]*/event[0-9]*
...
```


## Image, Video, and Audio conversion

### Convert from svg to png

With Inkscape:
```shell
inkscape -z -w 512 -h 512 image.svg -e image.png
```


### Show media file info

```shell
ffprobe video.mp4
```


### Convert a video from mp4 to y4m

This is useful for loading as a media capture file in Chrome.

With `ffmpeg`:
```shell
ffmpeg -i video.mp4 -pix_fmt yuv420p video.y4m
```


### Extract audio from a video

As `aac`:
```shell
ffmpeg -y -i video.mp4 -f aac -vn audio.aac
```

As `wav`:
```shell
ffmpeg -y -i video.mp4 -f wav -vn audio.wav
```


## cheat.sh

[cheat.sh](http://cheat.sh/) has a nice interface for getting help and examples
for common commands. My convenience alias for it is:

```
cheat() {
  curl cheat.sh/"$@" | bat
}
```


## Key repeats on MacOS

To [enable key repeats on
Mac](https://www.howtogeek.com/267463/how-to-enable-key-repeating-in-macos/), set this and then restart:

```shell
defaults write -g ApplePressAndHoldEnabled -bool false
```

