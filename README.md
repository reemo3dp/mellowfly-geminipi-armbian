# Mellow Fly Gemini v3 / Pi Stock Armbian

The goal of this project is to provide patches that re-create a stock armbian image as close to the "official" images.

The patch was initially entirely based off the [`flypi`](https://github.com/mellow-3d/build/tree/flypi) branch on Mellow-3D's fork of Armbian, with some work to map Pins to the board schematic.

## No Support Given

🛑 Please understand that you're running these images at your own risk. There is no support and issues asking for support will be closed without comment. Please do file issues if you encounter unexpected behaviour or bugs. Include the version you're running and steps to reproduce the issue.

## Disclaimer from GPL3

> THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY
OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM
IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF
ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

## Installation

Head to the [latest release](https://github.com/reemo3dp/mellowfly-geminipi-armbian/releases/latest) and download one of the `img.xz` files - `current` for a stable armbian kernel, `edge` for the latest mainline kernel supported by armbian. Both should work with all periphals (M2WE included).

Unpack the `xz`-archive and etch the image to an SD card using your favorite tool (e.g. balenaEtcher).

### M2WE

Use `nand-sata-install` to copy the system to the eMMC. 

If this is not enough to boot without the SD card into armbian, boot onto the SD Card and follow 
https://linux-sunxi.org/Bootable_eMMC#Installation_from_Linux to make the boot partitions bootable (eMMC should be `mmcblk2`). `u-boot-sunxi-with-spl.bin` should be in `/usr/lib/linux-u-boot-current-mellowflygeminipi/u-boot-sunxi-with-spl.bin`. It should be written to both boot partitions of the eMMC.

Mainline kernel comes with a kernel for the wifi chipset (`rtw88_8821cs`) that can fail to initialize on boot. if that happens, blacklist the module and modprobe it later during boot. `options rtw88_core disable_lps_deep=y` might also help, or installing the scripts and systemd service in `./contrib/`.

## Building yourself

```bash
# Check out armbian's build repository
$ git clone https://github.com/armbian/build/ armbian
$ cd armbian/
# Apply patches from this repository
$ git am ../patches/*.patch
# Compile ubuntu jammy with default kernel config
$ ./compile.sh BOARD=mellowflygeminipi BRANCH=current RELEASE=jammy BUILD_MINIMAL=no BUILD_DESKTOP=no KERNEL_CONFIGURE=no INSTALL_HEADERS=yes
```

## Status

| Kernel    | OS      | Status                     |
| --------- | ------- | -------------------------- |
| `current` | `jammy` | Everything works, M2WE WiFi fails to initialize but can be reinitialized later  |
| `edge` | `jammy` | Everything works, M2WE WiFi fails to initialize but can be reinitialized later |


## References

- [Mellow Fly Gemini V3 Product Page](https://mellow.klipper.cn/#/board/fly_gemini_v3/README)
- [Schematic and Pinout](https://github.com/Mellow-3D/Fly-Gemini-V3/tree/main/Hardware)
- [Official images](https://mellow.klipper.cn/#/introduction/downloadimg)
- [(abandoned?) mellow-3d/build branch used as a reference for the DTS and u-boot configuration](https://github.com/armbian/build/compare/main...Mellow-3D:build:flypi)
