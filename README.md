# pongasm

Writing a simple pong game running in a bootloader sector. Works in 16 bit real mode without an operating system.

# Dependencies
Install
* nasm
* qemu

# Quick Start

## Build

On windows
* run on command line in source directory: **build.bat**

On linux/macos
* run on command line in source directory: **nasm pong.asm -o pong**

## Run
* run on command line in source direectory: **qemu-system-i386 pong**