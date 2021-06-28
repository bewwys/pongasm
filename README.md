# pongasm

Writing a simple pong game running in a bootloader sector. Works in 16 bit real mode without an operating system.

# Dependencies

* nasm
* qemu

# Quick Start

## Build

On windows:
	run **build.bat**

On linux/macos
	run $ nasm pong.asm -o pong

## Run
	qemu-system-i386 pong