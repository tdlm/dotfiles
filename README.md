# Dotfiles

This is where I keep my dotfiles in sync between my various computers.

**What are dotfiles?**

Dotfiles are, in general, customization files used to personalize your \*nix-based system. They are called 'dot' files because they begin with a period (e.g. `.zshrc`). This period or dot indicates to the file system that this file/directory should be hidden.

**Where can I learn more about this method of dotfile backup?**

- [The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles) (the method used here)
- [Github does dotfiles](https://dotfiles.github.io)

## System Updates

As dotfiles get updated on each system, it's important to occasionally keep those changes in sync between repositories.

## New System Setup

**Installation Script**

bash -c "\$(curl -fsSL https://gist.githubusercontent.com/tdlm/704f050e03e59c464ad9a6772bbe78c6/raw/setup.sh)"

Running this should install all dependencies/prerequisites, and pull in this dotfile repository on any new system.

**Manual Update**

Confirm the `dotfiles` command is present on the system by running:

```bash
$ command -v dotfiles
```

If it's not present, run the followign alias or add it to your `.bashrc` or `.zshrc` config so that it's always available:

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Now make sure you don't create recursion issues:

```bash
echo ".dotfiles" >> .gitignore
```

Next, clone this repository down:

```bash
git clone --bare git@github.com:tdlm/dotfiles.git $HOME/.dotfiles
```

Now checkout the actual content into your `$HOME` directory:

```bash
dotfiles checkout
```
