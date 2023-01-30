<h1 align="center">
  <a href="https://github.com/z-shell/zi">
    <img align="center" src="https://github.com/z-shell/zi/raw/main/docs/images/logo.png" alt="Logo" width="60px" height="60px" />
  </a> ❮ Zsh Editing Workbench ❯
</h1>
<h2 align="center">
  <p> <samp><code>ZEW</code></samp> provides organized key bindings for various command line editing features. </p>
  <p> Original features are used to make user not depart from mainstream Zsh. </p>
</h2>

<!-- <p><img align="center" src="https://raw.githubusercontent.com/z-shell/z-a-rust/main/docs/images/annex-rust.gif" alt="Zi annex rust" width="100%" height="auto" /></p> -->

<div align="center"></div>

## 💡 Wiki: [ZEW](https://wiki.zshell.dev/ecosystem/plugins/zsh-editing-workbench) - [Plugins](https://wiki.zshell.dev/ecosystem/category/%EF%B8%8F-plugins)

Organized shortcuts for various command line editing operations, plus new operations (e.g. incremental history word completion).

Incremental history _word_ completing (started with<kbd><kbd>Alt</kbd>+<kbd>h</kbd></kbd>, <kbd><kbd>Alt</kbd>+<kbd>H</kbd></kbd> or <kbd><kbd>Option</kbd>+<kbd>h</kbd></kbd>, <kbd><kbd>Option</kbd>+<kbd>H</kbd></kbd> on Mac).

| Key(s)                                                                         | Description                                                                                                                                                  |
| ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <kbd><kbd>Alt</kbd>+<kbd>w</kbd></kbd>                                         | Delete a **shell word** [^1]                                                                                                                                 |
| <kbd><kbd>Alt</kbd>+<kbd>t</kbd></kbd>                                         | Transpose (swap) **shell words**                                                                                                                             |
| <kbd><kbd>Alt</kbd>+<kbd>m</kbd></kbd>                                         | Copy previous **shell word**, or word before that, etc. when used multiple times                                                                             |
| <kbd><kbd>Alt</kbd>+<kbd>M</kbd></kbd>                                         | Just copy previous **shell word** without iterating to previous ones                                                                                         |
| <kbd><kbd>Alt</kbd>+<kbd>.</kbd></kbd>                                         | Copy last **shell word** from previous line, or line before that, etc. when used multiple times; can be combined with <kbd><kbd>Alt</kbd>+<kbd>m</kbd></kbd> |
| <kbd><kbd>Ctrl</kbd>+<kbd>W</kbd></kbd>                                        | Delete word according to configured **word style** [^2]:                                                                                                     |
| <kbd><kbd>Alt</kbd>+<kbd>r</kbd></kbd>                                         | Transpose (swap) words according to configured **word style** (cursor needs to be placed on beginning of word to swap)                                       |
| <kbd><kbd>Alt</kbd>+<kbd>/</kbd></kbd>                                         | Complete **some word** [^3] from history                                                                                                                     |
| <kbd><kbd>Alt</kbd>+<kbd>h</kbd></kbd>, <kbd><kbd>Alt</kbd>+<kbd>H</kbd></kbd> | Complete **shell word** from history (custom version)                                                                                                        |
| <kbd><kbd>Alt</kbd>+<kbd>J</kbd></kbd>                                         | Break line                                                                                                                                                   |
| <kbd><kbd>Alt</kbd>+<kbd>\_</kbd></kbd>                                        | Undo                                                                                                                                                         |
|                                                                                |

### Installation With [Zi](https://github.com/z-shell/zi)

Add `zi load z-shell/zsh-editing-workbench` to `.zshrc`. The config files will be available in `~/.config/zew`.

### Installation With Zgen

Add `zgen load z-shell/zsh-editing-workbench` to `.zshrc` and issue a `zgen reset` (this assumes that there is a proper `zgen save` construct in `.zshrc`).
The config files will be available in `~/.config/zew`.

### Installation With Antigen

Add `antigen bundle z-shell/zsh-editing-workbench` to `.zshrc`. There also should be `antigen apply`. The config files will be in `~/.config/znt`.

### Manual Installation

After extracting `ZEW` to `{some-directory}` add following two lines to `~/.zshrc`:

```shell
fpath+=( {some-directory} )
source "{some-directory}/zsh-editing-workbench.plugin.zsh"
```

As you can see, no plugin manager is needed to use the `*.plugin.zsh` file. The above two lines of code are all that almost **all** plugin managers do. In fact, what's actually needed is only:

```shell
source "{some-directory}/zsh-editing-workbench.plugin.zsh"
```

<details>
<summary>Configure terminals</summary>

- **XTerm**

To make <kbd>Alt</kbd> key work like expected under `XTerm` add `XTerm*metaSendsEscape: true` to your resource file, e.g.:

```shell
echo 'XTerm*metaSendsEscape: true' >> ~/.Xresources
```

- **Konsole**

To make <kbd>Alt</kbd> key work like expected under `Konsole` add `Konsole*keysym.Meta: Meta` to your resource file, e.g.:

```shell
echo 'Konsole*keysym.Meta: Meta' >> ~/.config/konsolerc
```

</details>

[^1]: A **shell word** is a text that Zsh would see as single segment. For example `$(( i + 1 ))` is a single **shell word**.
[^2]:
    A **word style** defines a way Zsh recognizes segments (words) of text in commands that want to use the style information.

    - The style can be configured in zew.conf to be one of:
      - bash words are built up of alphanumeric characters only.
      - normal as in normal shell operation: word characters are alphanumeric characters plus any characters present in the string given by the parameter `$WORDCHARS`.
      - shell words are complete shell command arguments, possibly including complete quoted strings, or any tokens special to the shell.
      - whitespace words are any set of characters delimited by whitespace.
      - default restore the default settings; this is the same as 'normal' with default `$WORDCHARS` value.

[^3]: **Some word** is in general a sophisticated word, but not a **shell word**, because of limitations in Zsh history word completion. **Some word** is rather not build from special characters, it works well for normal characters.
