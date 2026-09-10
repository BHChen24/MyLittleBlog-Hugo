---
title: "Vim in (not so) short"
date: 2026-09-10T11:25:00
description: "I want to make it short, but Vim is too powerful"
tags: ["tool", "vim"]
categories: ["Tech notes"]
---

> 🔔 **Prelude:**
> Yes, You can always type :h to see help, for example, :h windows

## **Vim in not so short**

### Preliminaries

- When vim is not available, you can temporarily use `cat` or `nano` as alternatives
- When using a new IDE, you should first learn or configure:
    - save
    - copy / paste
    - duplicate line
    - delete word / delete line
    - line movement
    - navigate forward / back
    - undo / redo
    - page navigation (page down, page up, center to middle, etc.)
    - indent / unindent
    - multi-cursor
    - search / content search
    - input commands (`Ctrl + P` in VSCode, double `Shift` in IntelliJ, `:` in vim…)
    - completion, suggestion, parameter hint, hover hint
    - go to / peek definition, type, declaration, reference, implementation
    - rename symbol / refactor (if available)
    - AI controlling: toggle chat box, trigger inline chat…
    - tabs / windows management
- Use the `:help` command to query anything you don’t understand
- `:set option?` can view current settings

---

### Windows and Tabs

**Buffer:** Can be understood as a temporary file. Even if this file is edited, it doesn’t mean it’s written to the actual file. We can **observe** buffers through windows and **manage** them through tabs.

1. Use commands starting with `b` in Ex (command line) mode for buffer operations:
    - `bd` buffer delete; `bwipeout` clears more thoroughly
    - `bn` or `bnext` switch to next buffer
    - `bp` or `bprevious` switch to previous buffer
    - `ctrl + ^`  switch to the last buffer

`Ctrl + W` window shortcuts and `:sp` split commands are the basics of window management. `:sp` can use parameters to specify files to split (open a new window for this file)

1. `Ctrl + W` + `w` cycle windows, `Ctrl + W` + `hjkl` switch focus left/down/up/right (move cursor)
2. `Ctrl + W` + `=` (make window panes equal size)
3. `Ctrl + W` + `+` `Ctrl + W` +  `Ctrl + W` + `<` `Ctrl + W` + `>` (fine-tune window size)
4. `:vsp` performs vertical split, dividing into two sides
5. `:resize 20` sets height to 20 lines; `:vertical resize 80` sets width to 80 columns

`:tabs` is the basic tab management command.

1. `:tabnew` opens a new tab, `:tabe` (edit) opens a tab for editing. Can be followed by filename.
2. `:tabn` `:tabp` switch tabs, or use `gt` `gT` to switch
3. Display current buffer in new tab: `:tab split`
4. `:tabmove` move tab, for example `:tabmove 2`
5. **Batch execution**:
    - `:tabdo {cmd}` execute on all tabs, e.g., `:tabdo set nocursorline`
    - `:windo {cmd}` execute on each window in current tab, e.g., `:windo diffthis`

`:only` and `:close` are universal management methods

1. Type `:close` `:only` directly to manage windows
2. Type `:tabclose` `:tabonly` to manage tabs

---

### Key Remapping

Here’s the key remapping configuration in VSCode vim extension:

```json
{
"vim.leader": "<space>",
"vim.useSystemClipboard": true, // important
"vim.normalModeKeyBindings": [
    {
      "before" : ["J"],
      "after" : ["5", "j"]
    },
    {
      "before" : ["K"],
      "after" : ["5", "k"]
    },
  ],
"vim.normalModeKeyBindingsNonRecursive": [
    {
      "before" : ["<Backspace>"],
      "after" : ["x"]
    },
  ],
"vim.insertModeKeyBindingsNonRecursive": [

  ],
"vim.visualModeKeyBindingsNonRecursive": [
    {
      "before" : ["<Backspace>"],
      "after" : ["d"]
    },
  ]
}
```

Common key aliases:

- `<Backspace>`
- `<C-c>` -> Ctrl + C
- `<A-c>` -> Alt + C
- `<Shift>`
- `<CapsLock>`
- `<Tab>`
- `<Enter>`
- `<Esc>`
- `<Cmd->` Mac specific
- `<Up>`
- `<Down>`
- `<Left>`
- `<Right>`

---

#### vim Configuration File

Use the `.vimrc` file in the `home` directory:

```
" This is vimscript, so use let for assignment and " for comments

nnoremap <SPACE> <Nop>
let mapleader = " "
set number

" Use system clipboard
set clipboard=unnamedplus

" Map `J` to `5j`, `K` to `5k`, `<Backspace>` to `x`
nnoremap J 5j
nnoremap K 5k
nnoremap <Backspace> x
" inoremap
" vnoremap

" nmap
" imap
" vmap
nnoremap <Enter> o<Esc>
```

---

### Unbound Keys

In VSCode and other IDEs, you can return Vim-controlled keys to the IDE, since they have no use in GUI interfaces.

- `Ctrl + D` scroll down
- `Ctrl + Z` suspend Vim
- `Ctrl + X` decrease number at cursor by 1, in insert mode it’s completion, decrease by 1 is quite useful
- `Ctrl + C` can be considered
- `Ctrl + F` scroll forward, in insert mode used to view command history
- `Ctrl + W` window command, delete one word before cursor
- `Ctrl + P` completion
- `Ctrl + S` pause output
- `Ctrl + Q` same as `Ctrl + V`, only `q` alone is for recording macros, VSCode defaults to *Add cursor below*, multi-cursor editing tool
- `Ctrl + Y / E` scroll window up/down by 1 line
- `Ctrl + T` depends on situation

---

### Quick Reference

**(jut for memory, may not be accurate)**

1. `w` -> word
2. `b` -> back
3. `e` -> end
4. `H` -> page head; `L` -> low; `M` -> middle
5. `zz` move current line to the middle position
6. `Ctrl + U` & `Ctrl + D` half screen move up & down
    - `Ctrl + F` & `Ctrl + B` full screen move forward & back
7. `g` -> go (sometimes obviously more than that)
    - `gn` **go to next (matched)**, **commonly used**
    - `gi` go to (last) insert
    - `gd` go to definition
    - `gf` go to file
8. `d` -> delete (actually puts deleted content into register); sometimes means down
    - `dd` delete one line
9. `x` -> `dl`; `X` -> `dh`
    - `s` -> (`x` + `i`)
    - `c` -> change (`d` + `i`)
10. `y` -> yank
11. `p` -> do paste | as paragraph
12. `{` `}` -> paragraph
13. `f` -> find occurrence (**char**)
    - `;` -> next occurrence
    - `,` -> last occurrence
    - `t` -> till next occurrence
    - `F` -> backward to occurrence
14. `/` -> search item with pattern
    - `n` -> next item
    - `?` -> back search
15. `u` -> undo; `Ctrl + R` redo
16. `123…` -> as line number / do multiple times
17. `i` -> do insert | as inner (inside); `o` -> open a line below; `a` -> append | around
18. `s` -> as sentence | do substitute
19. `q` -> record macro
20. `v` -> visual
21. `s` -> surrounding. `cs{old}{new}`. plugin command
    - `v` `S{desire pair}` -> surrounding by.
22. `J` join
23. `r` replace

---

#### Special Characters

1. `@` -> execute register content
2. `.` **> as current line | do repeat last change**, **very commonly used**, for repeating **edit** operations
3. `%` -> as all lines(all contents); in normal mode represents matching symbols like `{[(`
4. `0` -> beginning of line
    - `$` -> end of line
    - `^` first meaningful character
    - `_` first meaningful character (can be operated by `g` etc.)
    - `g_` last meaningful character
5. `;` **repeat** last `f, F, t, T` command. For example, if you used `f` to find a **character**, pressing `;` will continue to find the next matching character.
    - `,` reverse repeat
6. `'` for mark navigation. For example, pressing `'a` jumps to the beginning of line of mark ‘a’.
7. ``` (backtick) for mark navigation. For example, pressing ``a` jumps to the exact position of mark ‘a’.
8. `~` change char case.
9. `&` repeat last substitution command

---

#### Modes

1. Normal mode: Enter normal mode when first starting, press `i` (insert) to enter insert mode, press `:` to enter command input mode
2. Insert mode: Edit file, press Esc to exit.
3. Command input mode: Input commands, press Esc to exit.
4. Press `v` to enter visual mode, generally used for selecting paragraphs

#### Command Structure

1. Normal mode commands are almost based on the `verb` + `adj(count)` + `obj(motion, text-object)` pattern, e.g.: `d3j`, `ca(`
    - Omitting `verb` means **cursor movement**, which can actually be understood as a type of `verb`.
        - Example: `3j`, move down 3 lines
        - Example: `0`, `$`, these are special characters
        - Example: `v3w`, `v` only switches mode, doesn’t count as `verb`, but subsequent behavior without `verb` is treated as cursor movement
    - **Special case**: Omitting `adj.` means based on current position, or only operating on **one object**.
        - Example: `cw`, `f{`
    - **Special case**: Omitting both `adj.` and `obj.` generally means some single character/line shortcuts
        - Example: `dd`, `yy`, `gg`
        - Example: `s`, `x`, `~`, `u`
2. Command line mode has almost no pattern. If anything, they can almost all be categorized as command-like modes.
    - verb + obj pattern: `:set number`, `:r file` (read file)
    - adj + verb pattern: `:3,5 d`
        - adj + verb + obj: `:3,5 d0`
    - obj pattern: `:map`
    - verb pattern: `:w`, `:q`
    - Special pattern (can be viewed as mode switching): `:!command` (execute external command)
    - Command-like pattern: `:s/foo/bar/gc`

#### Repeat Operations

- `.` for **modifications**.
- `;` for f, etc.
- `r` means replace
- `f` `sth` -> `r` -> `;` -> `.` -> `;` -> `.` -> … : guess what will happen?
- `gn` for `/` etc. Need to operate on current search content once first, then use `.` to repeat.

#### Tips

- `verb` is almost never absent, omitting `verb` generally means **movement** (`v` provides selection function, but still needs to **move** to **some position** to trigger)
- At the same time, `obj` is also almost never absent, omitting `obj` generally means **current position**

When inputting commands, if you’re unclear what else to input, consider these questions:
1. Does the command have an object? E.g., `w, p, s`.
(Specifically, line operations generally omit objects).
Selection in `v` mode actually provides objects. Similarly, **movement actions actually also provide objects.**
So, this part should be **considered first, but input last**.

2. Does the command have modifiers?
If there’s a **clear area to operate on**, you must pay attention to modifier input.
Because if not provided, it will **immediately** operate based on current position, very easy to cause misoperations.

3. What does the command need to do?
Please treat this as the last part to think about, to control vim behavior more precisely.
But when inputting commands, generally need to input first.
So, **input this first.**

**Seqs: 3 → 2 → 1**

---

### Commonly used Commands

- `:w` save
- `:q` quit
- `:q!` force quit without saving
- `:w filename` save file as filename
- `:w! filename` force save to filename
- `:set nu` `:set number` display line numbers, **commonly used**
- `/word` search downward (note, no `:`, when pressing `/`, command line becomes `/` mode)
    - Press `n, N` to search next/previous
    - `?word` search upward
- `u` and `:u` undo
- `Ctrl + R` redo
- `x` = `dl`, `X` = `dh`
- `s` = `ch`

#### Compound Commands

- `:5 d` delete line 5, **commonly used**
- `:3,5 d` delete **lines 3 to 5**
- `:$ d` delete last line of document
- `:% d` delete all content in document
- `:n move m` move line n to after line m, **commonly used**
- `:n,n+3 t m` copy **lines n to n+3** to **after** line m, **commonly used**
    - Summary: `:n,m` generally means from line n to line m
- `:%s/hello/nihao/g` replace all hello with nihao, similar to `sed` operation
    - `:s/hello/nihao/g` only replace in current line
- `:5,8s/hello/nihao/g` replace hello with nihao in lines 5-8

### Common Shortcuts

#### Movement

1. `Ctrl + O` previous position, `Ctrl + I` next position
2. If you have `Home` `End` `PageUp` and `PageDown` keys, you can use them directly, adding `Ctrl` is more convenient
    1. `PgUp` `PgDown` behavior varies, specifically use with `Ctrl` and `Shift`
3. `Ctrl + U` and `Ctrl + D` half screen scroll; `Ctrl + F` and `Ctrl + B` full screen scroll
4. `Ctrl + Up` to beginning of line, vice versa

---

### Normal Mode

#### **Cursor Movement**

#### Character-based Movement

- `h` `l` move left/right, `k` `j` move up/down, arrow keys also work
- Use `f` to find next **character**, uppercase for reverse search; using `t` stops before that character
    - Use `;` and `,` to repeat forward/backward search
- `^` move to first non-whitespace position
- `g_` find first non-whitespace position from end of line
- Use `$` to move to end of line
- Use `%` to match brackets like `( { [`

#### Word-based Movement

- `w` move to next word, **commonly used**, remember as word
- `b` move to beginning of current/previous word, **commonly used**, remember as back
- `e` move to end of current/next word, **commonly used**, remember as end
    - Uppercase `W, B, E, gE` for including characters after words
    - `ge` move to end of previous word
    - `3w` can move 3 times
- Use `/` and `?` to search for `pattern`, use `n` and `N` to jump to next/previous

#### Line-based Movement

- `g` is the most basic line movement command
- `0` move cursor to beginning of line, `$` move cursor to end of line
- `Home` key to beginning of line, `End` key to end of line
- `G` (Shift+G)/`gg` move cursor to end/beginning of file
- Actually `G` is go, so you can input `500G` or `500gg` to locate to line `500`, **commonly used**
    - Or directly use `:line_number` to locate
    - `gi` return to last insert location, **commonly used**

#### Block or Screen-based Movement

- `{` `}` move by paragraph
- `H` move to **top line of screen**; `L` move to **bottom line of screen**; `M` move to **middle of screen**

#### Mark-based Movement

- `ma` set mark a
- `'a` jump to beginning of line of mark a
- ``a` jump to exact position of mark a
- `''` jump to beginning of line of previous position, **commonly used**
- ```` jump to exact position of previous position, **commonly used**

---

#### Operation Commands

Follow `{operator}{count}{motion}` pattern, e.g.: `d2w`

- `c` change, `d` delete, `y` yank (copy), `p` paste
    - change means delete corresponding content and directly enter insert mode
- `gu` `gU` or directly press `~` to change char’s case (**commonly used**)
- `=` format, for formatting, need to set code standards in advance, e.g.:

```
set autoindent        " Inherit indentation from previous line
set smartindent       " Smart indentation based on syntax
set cindent           " C/C++ style indentation
set shiftwidth=4      " Move 4 spaces for each indentation operation
set tabstop=4         " Display one Tab as 4 spaces
set expandtab         " Use spaces instead of Tab
```

Common formatting commands:
- `==`: Format current line.
- `=motion`: Format range specified by `motion`.
- `=ap`: Format current paragraph (`ap` means “a paragraph”).
- `=%`: Format content within brackets matching current cursor position.
- `gg=G`: Format entire file.

- Use `>>` for indentation, use `>` when target is provided

#### Text Objects (delete content of specific patterns)

Follow `{operator}{a/i}{text object}` pattern, e.g.: `di'` (delete inside ’)

- Generally used with `c`, `d`
- a -> around, i -> inside
- text-object identifiers:
    - `w` word
    - `s` sentence
    - `p` paragraph
    - `'"[{<` ` corresponding to respective special blocks
    - `t` tag, commonly used in html language, between `><`

#### Copy and Delete

- `yy` copy current line, **commonly used**
- `dd` cut current line, **commonly used**
- `3dd` delete 3 lines, **commonly used**
- `p`/`P` paste content after/before cursor, **commonly used**
- `x` delete character at cursor, `X` delete previous character
- `r` modify character at cursor
- `R` enter replace mode

#### Undo

- `u` undo, **commonly used**
- `Ctrl + R` redo, **commonly used**

#### Enter Insert Mode

- `i` enter insert mode at current position
- `a` enter insert mode at next character
- `A` enter insert mode at end of line
- **`o` enter insert mode on next line**, often used with `G` and `End`, **commonly used**
- `s` delete current character and enter insert mode
- `S` delete current line and enter insert mode
- `cw` delete next word and enter insert mode
- `cb` delete previous word and enter insert mode

---

### Insert Mode

Generally use shortcuts for operations

#### Cursor Movement

1. `Ctrl + A` move cursor to beginning of line, uppercase moves to beginning of document
2. `Ctrl + E` move cursor to end of line

#### Text Operations

1. `Ctrl + W`: Delete one word before cursor.
2. `Ctrl + U`: Delete all content from current cursor position to beginning of line.
3. `Ctrl + T` increase indentation to the right
4. `Ctrl + D` decrease indentation to the left
5. `Ctrl + R`: Insert register content. After pressing, need to input register identifier, e.g., `Ctrl + R, 0` inserts content of register 0.

#### Completion Features

1. `Ctrl + N`: Auto-complete next matching word. **commonly used**
2. `Ctrl + P`: Auto-complete previous matching word.
3. `Ctrl + X`, `Ctrl + L`: Full line completion, shows dropdown menu
4. `Ctrl + X`, `Ctrl + N/P`: Word completion based on current file.
5. `Ctrl + X`, `Ctrl + F`: Filename completion.
6. `Ctrl + X`, `Ctrl + K`: Dictionary lookup completion.

#### Others

1. `Ctrl + C`: Exit input mode. Replace Esc, **commonly used**
2. `Ctrl + O`: Temporarily switch to normal mode to execute one command, then return to input mode. **commonly used**
3. What if you press wrong key? In normal mode use `Ctrl + O` to return to previous position, meaning in input mode press `Ctrl + O` x2

---

### Visual Mode

Follow `{trigger v}{motion}{operator}` pattern, e.g.: `v2wd` (select two words then delete)

- Press `v` for character selection, `V` for line selection, `Ctrl + V` for block selection
- Generally only used for copy-paste, operation speed is slow

---

### `:` Command Mode

#### Batch Processing (delete, move, copy, paste)

1. `:2,5d a`: Delete **lines 2 to 5** and **save in register a**
2. `0` line 0; `# Vim in a Nutshell
3. `:.,+3d` delete current lint & plus 3 lines
4. In `visual` mode，`:'<,'>d` means “delete selected content”
5. `@:` repeat last `:` command
    - After using `q` for macro recording we can use `@@` repeat it
    - After `@:` , `@@` is still available
6. `:'<,'>move .`
    - `:m 10` move (current line) to 10 line after
7. `:/` looking for last found pattern

---

#### Quick Reference

#### Find and Replace

- **`:%s/old/new/g`**: In entire file range, replace all strings matching `old` with `new`. Add `c` to ask before each replacement.
- **`:s/old/new/g`**: Replace all `old` with `new` in current line.
- **`:g/pattern/d`**: Delete all lines matching `pattern`.
- **`:'<,'>s/old/new/g`**: In visual mode selected range, replace all `old` with `new`.
- **`:'<,'>normal command`**: Execute `normal` mode command on each line selected in visual mode.

#### Line Operations

- **`:d`**: Delete current line (similar to `dd`).
- **`:t .+1`**: Copy current line and paste to next line.
- **`:m .+1`**: Move current line down one line.
- **`:m .-2`**: Move current line up two lines.
- `:-3,. m .+1`: Move 3 lines above current line to below current line
- `:-3,.y | :.+1put`: Copy above three lines, paste to next line. `put` creates new line, `p` pastes at cursor position

#### sed-like Command Usage

1. Replace all matching patterns at once: `:%s/pattern/replacement/gc` for entire file range (`%`), substitute (`s`) `pattern` with `replacement`
2. `gc` are `flags`, common `flags` include:
    - `g`: Global replacement (apply command to all lines)
    - `c`: Ask before each command execution.
    - `i`: Ignore case
    - `n`: Maximum number of replacements
    - `p`: Print results
    - `v`: Invert results
    - `!`: Pass to external tool -> `%!sort` will sort entire text
3. **Explicitly** use **normal commands** in `Ex` mode. Use `norm`
    - Very useful with v mode
    - Example: `:'<,'>norm A!`, will **for content selected in v mode (‘<,’>)**, uniformly **add a “!” at the end of lines (A)**

`%` itself is shorthand for **`1,# Vim in a Nutshell

---

### Tips

- Accidentally pressed `Ctrl + S`? Use `Ctrl + Q` to release
- It’s best not to use the right numeric keypad for editing, there might be key conflicts

---

### Copy-Paste Issues

Vim editor has its own clipboard system called registers. Vim uses registers to store text, which are different from X11 clipboards. If Vim is compiled with X11 clipboard support (through +clipboard option), then you can use special registers `"*` and `"+` to access X11’s PRIMARY and CLIPBOARD.

#### Paste Mode

To prevent auto-formatting from corrupting pasted content, Vim provides paste mode. Before pasting, execute `:set paste` command to enter paste mode, which will temporarily disable auto-indent, auto-wrap and other functions. After pasting, execute `:set nopaste` to return to normal mode.

You can also install some programs to access X11 clipboard, such as **xclip** or **xsel**.

Right mouse button enters visual mode?

- `:set mouse-=a`

---

#### Register Overview

Vim uses a set of registers as its “clipboard”. These registers can be used to save text and paste later. Each register has an identifier, which can be a single letter or special character. Here are some basics about Vim registers:

Note, to use registers, first press `"`, then **switch** to the desired register, then perform operations

To view register status, type `:reg` in command line mode

---

#### Basic Registers

- `""` - Default register, if you don’t know where copied content went, look here
- `"0` - Number 0 register. Stores content of your last yank (copy).
- `"-` - Small delete register. Stores content of your last delete or change that’s less than one line.
- `"1` to `"9` - Number registers. Store your recent delete or change history (`"1` is most recent, `"9` is oldest).
- `"a` to `"z` or `"A` to `"Z` - Named registers. You can use lowercase letters to store text, uppercase letters to append text to corresponding lowercase register.

---

#### Special Registers

- `"*` and `"+` - Clipboard registers. In Vim with clipboard support (usually GUI version Vim or Vim with `+clipboard` feature), these two registers communicate with system clipboard:
    - `"*` register corresponds to X11’s `PRIMARY` clipboard (usually the select-to-copy one).
    - `"+` register corresponds to `CLIPBOARD` clipboard (usually used with `Ctrl+C`/`Ctrl+V` key combinations). **Most commonly used.**

---

#### Using Registers

- **Copy to register**: You can use `"ay` to copy to register `a`, where `a` is the register name, `y` is the yank command.
    - Almost the same in visual mode
- **Paste from register**: To paste from register, you can use `"ap` to paste content of register `a`, where `a` is the register name, `p` is the paste command.
- **In insert mode**: Use `Ctrl + R` to call up `"` symbol

#### Using Registers in Insert Mode

Press

`Ctrl + R + register name`

For example

`Ctrl + R + "` uses default register, `Ctrl + R + +` uses system register.

---

#### Using Registers in Terminal

When you use Vim in terminal instead of GUI version, accessing system clipboard becomes more complex, because Vim needs to include clipboard support at compile time. You can run `vim --version` to see if your Vim supports clipboard (look for `+clipboard` or `+xterm_clipboard`).

If your Vim supports clipboard, you can interact with system clipboard in the following ways:

- Use `"*y` to copy to system’s PRIMARY clipboard.
- Use `"+y` to copy to system’s CLIPBOARD clipboard.
- Use `"*p` or `"+p` to paste from corresponding system clipboard to Vim.

If your Vim doesn’t have clipboard support, you won’t be able to directly access system clipboard from Vim. In this case, you need to use external programs (like `xclip` or `xsel`) to help you copy Vim register content to system clipboard, or paste from system clipboard to Vim.

---

### External Commands

#### Using `:!` to Execute External Commands

You can use `:!` followed by command to execute any external command. For example, if you want to see current directory contents, you can type in Vim’s command mode:

```bash
:!ls
```

#### Using `:r` to Read External Command Output

If you want to insert output of `sed`, `awk` or other commands into current Vim editor text, you can use `:r !` command. For example, if you want to insert `ls` command output at current position, you can type:

```bash
:r !ls
```

#### Using `:%!` to Process Entire File Content Through External Command

If you want to apply `sed` or `awk` command to entire file content and replace current file content, you can use `:%!` followed by corresponding command. For example, use `sed` command to replace all “foo” with “bar” in document:

```bash
:%!sed 's/foo/bar/g'
```

#### Partial Usage

You can also specify a range to use external command only on certain parts of the file. For example, only process lines 5 to 10 through `awk` command:

```bash
:5,10!awk '{print $1}'
```

---

### **Macro Recording**

1. Use `q` for macro recording in normal mode
    - Give register a name, say `a`, the full name of this register is `@a`
    - Press `q` again to end recording after recording is complete
    - Type `@a` to execute macro, `@@` to execute last macro, `9@a` to execute macro 9 times
2. **+1 operation** on numbers. `<C-a>`, can be used with macro recording to write ordered lists:
    - `1. sth`, then `yyp`, perform `<C-a>` on 1, repeat

---

### Other Features

1. **Spell check**. `:set spell! spelllang=en_us`
2. `:set rnu` set **relative line numbers**. Convenient for jumping
