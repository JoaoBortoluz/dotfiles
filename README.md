# My config files

This repo contais my dotfiles for my system

## Requirements

Programs required for installing my dotfiles

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
```

## Installation

Clone the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com:JoaoBortoluz/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks for the dotfiles

```
$ stow .
```

Now the changes you made in `~/dotfiles` will be reflected to your dotfiles in $HOME directory

## Remmaping keys with Keyd (Optional)

Config for remmaping keymaps with keyd

### Keyd installation

```
pacman -S keyd
```

Now, create a symbolic link from the `~/.config/keyd/default.conf` to `/etc/keyd/default.conf`:

```
sudo ln -sf ~/.config/keyd/default.conf /etc/keyd/default.conf
```

This command will create a symbolic link that points to your user config, so changes you make in `~/.config/keyd/default.conf` will be reflected in `/etc/keyd/default.conf`.

### Keyd config

This config remmaps `Capslock` to `Ctrl` em pressed with another key and `Esc` if pressed and released alone. Also binds `Ctrl` `(Capslock)` + `semicolon` `(;)` to `Esc`

`~/.config/keyd/default.conf`:

```
[ids]

*

[main]

# Maps capslock to escape when pressed and control when held.
capslock = overload(control, esc)

# Maps control (capslock) + ; to escape
leftcontrol = layer(control) 

[control:C]
semicolon = esc
```

### Start Keyd

Add this in hyprland.conf exec-once:
```
sudo keyd
```
