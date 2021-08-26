# BASH dotfiles for apt-based machines

Heavily inspired by [this post](https://victoria.dev/blog/how-to-set-up-a-fresh-ubuntu-desktop-using-only-dotfiles-and-bash-scripts/)
I've decided to set up a repository to initialize any `apt`/`dpkg` based machine
(don't quote me on that, it's still being tested) with some of the essentials
one would need to have a proper workstation.

## Installation

Simply run

```cmd
$ ./bootstrap.sh
```

Each program being installed has a prompt before it, so fret not on running
all the installation scripts at once. As for the dotfiles, it prompts the
user for backup on their current ones before linking the new ones.

Also, if you so like, use `-y`, `-f`, or `--force` with `bootstrap.sh` to force
installation.

## Keybinds and desktop settings

There's not a reliable way to check whether GNOME, KDE, MATE, etc is being
used. For the time being, the `settings/` folder has individual configuration
dumps to load on your own environment.

### For GNOME

    $ dconf load /org/gnome < settings/gnome.dconf

## Inspirations and recommendations

- [Victoria Drake](https://github.com/victoriadrake)'s simple but effective
  [dotfiles repository](https://github.com/victoriadrake/dotfiles). It's the
  one used in the article;
- [Zach Holman](https://github.com/holman/dotfiles)'s extensive
  [dotfiles repository](https://github.com/holman/dotfiles), specially for the
  logger functions and the dotfile linking script;
- [Mathias Bynens](https://github.com/mathiasbynens) for the
  [coloring and prompt idea](https://github.com/mathiasbynens/dotfiles/blob/main/.bash_prompt).
