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

## Progress

M2WE and SPI have not been tested at all. In order to make the USB-OTG port work on `current` and `edge`, comment out `g_serial` in `/etc/modules` and potentially change `dr_mode = "host";` in the `dts`.

| Kernel    | OS      | Status                     |
| --------- | ------- | -------------------------- |
| `legacy`  | `jammy` | Works                      |
| `current` | `jammy` | ~USB-OTG port does not work~ |
| `edge`    | `jammy` | ~USB-OTG port does not work~ |

## References

- [Mellow Fly Gemini V3 Product Page](https://mellow.klipper.cn/#/board/fly_gemini_v3/README)
- [Schematic and Pinout](https://github.com/Mellow-3D/Fly-Gemini-V3/tree/main/Hardware)
- [Official images](https://mellow.klipper.cn/#/introduction/downloadimg)
- [(abandoned?) mellow-3d/build branch used as a reference for the DTS and u-boot configuration](https://github.com/armbian/build/compare/main...Mellow-3D:build:flypi)
