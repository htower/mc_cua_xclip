#!/usr/bin/env bash

# Copyright (c) 2018 - present, Anton Anikin <anton@anikin.xyz>
# MIT License, see http://opensource.org/licenses/MIT

USER=`whoami`
if [[ `ps -u $USER | grep -E " mc(edit|view|diff)?$"` ]];
then
    echo "Please close all mc instances before running the script"
    exit 1
fi

if [[ -z `command -v crudini` ]];
then
    echo "Please install crudini utility"
    exit 1
fi

if [[ -z `command -v xclip` ]];
then
    echo "Please install xclip for the X11 clipboard support"
    exit 1
fi

INI="$HOME/.config/mc/ini"
KEYMAP="$HOME/.config/mc/mc.keymap"

if [[ ! -f $INI ]];
then
    echo "Please run (and close) mc to initialize its config file"
    exit 1
fi

function update_settings {
  crudini --set $INI "$1" "$2" "$3"
  printf "."
}

printf "Update settings "
update_settings "Midnight-Commander" "editor_persistent_selections" "false"
update_settings "Midnight-Commander" "editor_cursor_after_inserted_block" "true"
update_settings "Midnight-Commander" "editor_group_undo" "true"
update_settings "Misc" "clipboard_store" "xclip -i -selection clipboard"
update_settings "Misc" "clipboard_paste" "xclip -o -selection clipboard"
echo ""

if [ ! -f $KEYMAP ];
then
    echo "Copy default keymap"
    if [[ -f /etc/NIXOS || `grep "NAME=NixOS" /etc/os-release` ]];
    then
      p=`which mc`
      p=`readlink $p`
      p=`dirname $p`
      cp "$p/../etc/mc/mc.default.keymap" $KEYMAP
      chmod 644 $KEYMAP
    else
      cp /etc/mc/mc.default.keymap $KEYMAP
    fi
fi

function update_keymap {
  crudini --set $KEYMAP "$1" "$2" "$3"
  printf "."
}

printf "Update keymap "
update_keymap "main" "Quit" "ctrl-q; f10"

update_keymap "input" "Home" "home"
update_keymap "input" "End" "end"
update_keymap "input" "Left" "left"
update_keymap "input" "Right" "right"
update_keymap "input" "WordLeft" "ctrl-left"
update_keymap "input" "WordRight" "ctrl-right"
update_keymap "input" "Backspace" "backspace"
update_keymap "input" "Delete" "delete"
update_keymap "input" "Cut" "ctrl-x; shift-delete"
update_keymap "input" "Store" "ctrl-c; ctrl-insert"
update_keymap "input" "Paste" "ctrl-v; shift-insert"
update_keymap "input" "HistoryPrev" "ctrl-down"
update_keymap "input" "HistoryNext" "ctrl-up"
update_keymap "input" "Complete" "ctrl-space"

update_keymap "editor" "Store" "ctrl-c; ctrl-insert"
update_keymap "editor" "Paste" "ctrl-v; shift-insert"
update_keymap "editor" "Cut" "ctrl-x; shift-delete"
update_keymap "editor" "WordLeft" "ctrl-left"
update_keymap "editor" "WordRight" "ctrl-right"
update_keymap "editor" "BackSpace" "backspace"
update_keymap "editor" "Delete" "delete"
update_keymap "editor" "Undo" "ctrl-z"
update_keymap "editor" "Top" "ctrl-home"
update_keymap "editor" "Bottom" "ctrl-end"
update_keymap "editor" "Save" "ctrl-s; f2"
update_keymap "editor" "MarkAll" "ctrl-a"
update_keymap "editor" "Search" "ctrl-f; f7"
update_keymap "editor" "Replace" "ctrl-r; f4"
update_keymap "editor" "Complete" "ctrl-space"
update_keymap "editor" "Quit" "ctrl-q; f10; esc"

update_keymap "editor" "BlockSave"
update_keymap "editor" "InsertLiteral"
update_keymap "editor" "MacroStartStopRecord"
update_keymap "editor" "SyntaxOnOff"
echo ""

echo "All done"
