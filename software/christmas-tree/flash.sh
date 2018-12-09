#! /bin/sh

set -ex

arduino=arduino
avrdude=avrdude

[ build/christmas-tree.ino.elf -nt christmas-tree.ino ] ||      \
    "$arduino" --verify christmas-tree.ino                      \
    --board attiny:avr:ATtinyX4:cpu=attiny84,clock=internal8    \
    --preserve-temp-files --pref build.path=build/

$avrdude -p attiny84 -c usbtiny                                 \
    -U lfuse:w:0xe2:m -U hfuse:w:0xdd:m -U efuse:w:0xff:m       \
    -U flash:w:build/christmas-tree.ino.hex:i -B 1
