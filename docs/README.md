# `ZSH-EDITING-WORKBENCH`

## Introduction

Organized shortcuts for various command line editing operations, plus new
operations (e.g. incremental history word completion).

Incremental history _word_ completing (started with `Alt-h/H` or `Option-h/H` on Mac):

## Installation With [Zinit](https://github.com/z-shell/zinit)

Add `zinit load z-shell/zsh-editing-workbench` to `.zshrc`. The config files will be available in `~/.config/zew`.

## Installation With Zgen

Add `zgen load z-shell/zsh-editing-workbench` to `.zshrc` and issue a `zgen reset` (this assumes that there is a proper `zgen save` construct in `.zshrc`).
The config files will be available in `~/.config/zew`.

## Installation With Antigen

Add `antigen bundle z-shell/zsh-editing-workbench` to `.zshrc`. There also
should be `antigen apply`. The config files will be in `~/.config/znt`.

## Manual Installation

After extracting `ZEW` to `{some-directory}` add following two lines
to `~/.zshrc`:

```zsh
fpath+=( {some-directory} )
source "{some-directory}/zsh-editing-workbench.plugin.zsh"
```

As you can see, no plugin manager is needed to use the `*.plugin.zsh`
file. The above two lines of code are all that almost **all** plugin
managers do. In fact, what's actually needed is only:

```zsh
source "{some-directory}/zsh-editing-workbench.plugin.zsh"
```

because `ZEW` detects if it is used by **any** plugin manager and can
handle `$fpath` update by itself.

## Configuring terminals

### **XTerm**

To make `Alt` key work like expected under `XTerm` add `XTerm*metaSendsEscape: true` to your resource file, e.g.:

```zsh
echo 'XTerm*metaSendsEscape: true' >> ~/.Xresources
```
