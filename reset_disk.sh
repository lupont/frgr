#!/bin/sh
rm -f vdisk
dd if=/dev/zero of=vdisk bs=1024 count=1440
mke2fs vdisk 1440
