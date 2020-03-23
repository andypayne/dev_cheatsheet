# Dev Environment Cheetsheat

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

### Tmux Plugin Manager

Using [tpm](https://github.com/tmux-plugins/tpm)

#### Install plugins and refresh

```
<prefix> I
```


## Vim

*TODO*

```
set clipboard=unnamed
set clipboard=unnamedplus
```

Use `"+y` to yank to the system clipboard.

