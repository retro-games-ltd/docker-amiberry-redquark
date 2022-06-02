# Accessing THEA500 Mini filesystem

**Applying any of the information contained in this repository to, or modifying THEA500 Mini in any way will render the
_THEA500 Mini WARRANTY NULL AND VOID_. The use of the program and information contained here is in no way authorised,
advised, recommended or supported by Retro Games Ltd and is merely provided in compliance with the GPLv3 licence of Amiberry.**

**RETRO GAMES LTD PROVIDES THE PROGRAM, DELIVERABLES AND INFORMATION "AS IS" AND
DISCLAIMS ANY AND ALL WARRANTIES OF ANY KIND OR NATURE, WHETHER EXPRESS OR
IMPLIED, ORAL OR WRITTEN, INCLUDING WITHOUT LIMITATION TO ANY WARRANTY THAT
THE PROGRAM, DELIVERABLES AND INFORMATION DISCLOSED ARE ERROR-FREE,
OR ARE COMPATIBLE WITH ALL HARDWARE AND SOFTWARE CONFIGURATIONS, AND ANY AND
ALL WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE AND USE OF THE PROGRAM, DELIVERABLES AND
INFORMATION DISCLOSED IS WITH YOU. SHOULD THE PROGRAM, DELIVERABLES OR INFORMATION
DISCLOSED PROVE DEFECTIVE OR CAUSE THE "THEA500 MINI" OR CONNECTED DEVICES TO OPERATE
INCORECTLY, INCLUDING BUT NOT LIMITED TO, FAILING TO POWER ON, YOU ASSUME THE COST OF ALL
NECESSARY SERVICING, REPAIR OR CORRECTION.**

---

## Expert developers only - Use at your own risk
## Create a custom shell boot

Because there exists different build versions of THEA500 Mini with different boot partitions, the process for gaining a
login must be applied procedurally to the device to be modified.

- Hook up a serial cable to UART 1 and connect to the board with your terminal program set at baud rate 115200
- Power on and press `s` to halt boot.
- When you reach the `redquark-six#` prompt, turn on logging in your terminal program and run the following commands:

```
sunxi-flash read 4007f800 nanda
md.b 4007f800 0xccc4b0
```

- This will dump out the boot partition as hexadecimal. It will take a long time to complete.
- When done, edit the logfile to keep the hexdump lines, starting with the line 4007f800 ... ANDROID!
- Trim the address off the front of each line and ASCII off the end, leaving hex octets:

```
41 4e 44 52 4f 49 44 21 c8 b3 8f 00 00 00 08 40
71 42 2a 00 00 00 00 41 00 00 00 00 00 00 f0 40
...
ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
```

- Convert back to a binary file and unpack:

```
xxd -r -p nanda.hex nanda.img
abootimg -x nanda.img 
```

- Unpack the gzipped cpio archive `initrd.img` using your favourite tool.

- Edit the `init` script from that archive to start the shell `/bin/sh` instead of `/init`:

```
[ -x /mnt/init ] && exec switch_root /mnt /bin/sh
```

- Repack initrd as a gzipped cpio archive called `initrd-patched.img` using your favourite tool.
- Repack the boot image:

```
cp nanda.img nanda-patched.img
abootimg -u nanda-patched.img -r initrd-patched.img
```
- Copy `nanda-patched.img` onto a FAT32 USB stick.

## Booting with your custom shell boot

- Insert USB stick containing `nanda-patched.img` into a USB slot of THEA500 Mini.
- Power on and press `s` to halt.
- When you reach the `redquark-six#` prompt, run the following commands:

```
usb start
fatload usb 0:1 4007f800 nanda-patched.img
setenv bootargs console=ttyS0,115200 quiet
boota 4007f800
```

- On booting, you will be dropped to a shell.
- Mount the USB stick and copy your new `amiberry` onto the filesystem.

> **Note**: You may need to mount `/proc`, `devtmpfs /dev` and remount `/` read-write.
