# mc_cua_xclip

The script setup your midnight commander for using standard CUA-like editor shortcuts: `ctrl-c`(`ctrl-insert`), `ctrl-v`(`shift-insert`) and so on. This shortcuts will work in the editor and also in the line edit fields. The script also adds integration with X11 clipboard - you can copy text from mc into system clipboard and vice versa. This should works for ssh sessions - you need install `xclip` on remote system and enable X11 forwarding.

## Dependencies
* `xclip` - runtime dependency, required for X11 clipboard integration.
* `crudini` - setup-time dependency, required for mc config (ini-files) patching.

## How to use
1. Install `xclip` and `crudini` packages.
1. Close all `mc` instances.
1. Run `setup.sh` and wait for the finish.
1. Run `mc` :)

## Limitations
Keyboard shortcuts used in the script may not work on your system for a number of reasons. On my [neon](https://neon.kde.org) system with `konsole` terminal emulator everything works well.

Copyright (c) 2018 - present, Anton Anikin <anton@anikin.xyz>

MIT License, see http://opensource.org/licenses/MIT
