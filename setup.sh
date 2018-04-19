#!/bin/bash

# Copyright (c) 2018, Anton Anikin <anton@anikin.xyz>
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

echo "Update settings"
crudini --set $INI "Midnight-Commander" "editor_persistent_selections" "false"
crudini --set $INI "Midnight-Commander" "editor_cursor_after_inserted_block" "true"
crudini --set $INI "Midnight-Commander" "editor_group_undo" "true"
crudini --set $INI "Misc" "clipboard_store" "xclip -i -selection clipboard"
crudini --set $INI "Misc" "clipboard_paste" "xclip -o -selection clipboard"

if [ ! -f $KEYMAP ];
then
    echo "Copy default keymap"
    cp /etc/mc/mc.default.keymap $KEYMAP
fi

echo "Update keymap"

crudini --set $KEYMAP "main" "Quit" "ctrl-q; f10"

crudini --set $KEYMAP "input" "Home" "home"
crudini --set $KEYMAP "input" "End" "end"
crudini --set $KEYMAP "input" "Left" "left"
crudini --set $KEYMAP "input" "Right" "right"
crudini --set $KEYMAP "input" "WordLeft" "ctrl-left"
crudini --set $KEYMAP "input" "WordRight" "ctrl-right"
crudini --set $KEYMAP "input" "Backspace" "backspace"
crudini --set $KEYMAP "input" "Delete" "delete"
crudini --set $KEYMAP "input" "Cut" "ctrl-x; shift-delete"
crudini --set $KEYMAP "input" "Store" "ctrl-c; ctrl-insert"
crudini --set $KEYMAP "input" "Paste" "ctrl-v; shift-insert"
crudini --set $KEYMAP "input" "HistoryPrev" "ctrl-down"
crudini --set $KEYMAP "input" "HistoryNext" "ctrl-up"
crudini --set $KEYMAP "input" "Complete" "ctrl-space"

crudini --set $KEYMAP "editor" "Store" "ctrl-c; ctrl-insert"
crudini --set $KEYMAP "editor" "Paste" "ctrl-v; shift-insert"
crudini --set $KEYMAP "editor" "Cut" "ctrl-x; shift-delete"
crudini --set $KEYMAP "editor" "WordLeft" "ctrl-left"
crudini --set $KEYMAP "editor" "WordRight" "ctrl-right"
crudini --set $KEYMAP "editor" "BackSpace" "backspace"
crudini --set $KEYMAP "editor" "Delete" "delete"
crudini --set $KEYMAP "editor" "Undo" "ctrl-z"
crudini --set $KEYMAP "editor" "Top" "ctrl-home"
crudini --set $KEYMAP "editor" "Bottom" "ctrl-end"
crudini --set $KEYMAP "editor" "Save" "ctrl-s; f2"
crudini --set $KEYMAP "editor" "MarkAll" "ctrl-a"
crudini --set $KEYMAP "editor" "Search" "ctrl-f; f7"
crudini --set $KEYMAP "editor" "Replace" "ctrl-r; f4"
crudini --set $KEYMAP "editor" "Complete" "ctrl-space"
crudini --set $KEYMAP "editor" "Quit" "ctrl-q; f10; esc"

crudini --set $KEYMAP "editor" "BlockSave"
crudini --set $KEYMAP "editor" "InsertLiteral"
crudini --set $KEYMAP "editor" "MacroStartStopRecord"
crudini --set $KEYMAP "editor" "SyntaxOnOff"

echo "All done"
