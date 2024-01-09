# Mellow Fly Gemini v3 / Pi Stock Armbian

The goal of this project is to provide patches that re-create a stock armbian image as close to the "official" images.

The patch is almost entirely based off the [`flypi`](https://github.com/mellow-3d/build/tree/flypi) branch on Mellow-3D's fork of Armbian, with some work to map Pins to the board schematic.

## Disclaimer from GPL3

> THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY
OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM
IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF
ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

## Building

```bash
# Check out armbian's build repository
$ git clone https://github.com/armbian/build/ armbian
$ cd armbian/
# Apply patches from this repository
$ git am ../patches/*.patch
# Compile ubuntu jammy with default kernel config
$ ./compile.sh BOARD=mellowflygeminipi BRANCH=legacy RELEASE=jammy BUILD_MINIMAL=no BUILD_DESKTOP=no KERNEL_CONFIGURE=no
```

## Status

| Kernel    | OS      | Status                     |
| --------- | ------- | -------------------------- |
| `current` | `jammy` | Everything works, M2WE WiFi fails to initialize but can be reinitialized later  |
| Everything works, M2WE WiFi fails to initialize but can be reinitialized later |

# M2WE

Use `nand-sata-install` to copy the system to the eMMC. Don't reboot, but follow 
https://linux-sunxi.org/Bootable_eMMC#Installation_from_Linux to make the boot partitions bootable (eMMC should be `mmcblk2`). `u-boot-sunxi-with-spl.bin` should be somewhere in `/usr`. 

Power off, remove sdcard, boot again. Mainline kernel comes with a kernel for the wifi chipset (`rtw88_8821cs`) that can fail to initialize on boot. if that happens, blacklist the module and modprobe it later during boot. `options rtw88_core disable_lps_deep=y` might also help.

## References

- [Mellow Fly Gemini V3 Product Page](https://mellow.klipper.cn/#/board/fly_gemini_v3/README)
- [Schematic and Pinout](https://github.com/Mellow-3D/Fly-Gemini-V3/tree/main/Hardware)
- [Official images](https://mellow.klipper.cn/#/introduction/downloadimg)
- [(abandoned?) mellow-3d/build branch used as a reference for the DTS and u-boot configuration](https://github.com/armbian/build/compare/main...Mellow-3D:build:flypi)
