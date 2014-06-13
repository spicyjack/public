**pigwidgeon**
- 13" Mid-2011 Macbook Air (MacBookAir4,2)
  - Core I7 - 1.8GHz
  - Intel HD Graphics 3000, 384M VRAM
  - OS X Mavericks (10.9.3): 297/5 ~ 59fps

**larry**
- 15" Powerbook (PowerBook5,6)
  - 1.67GHz PowerPC 7447A (with Altivec)
  - ATI Mobility Radeon 9700
  - OS X Leopard (10.5.8): 15076/5 ~ 3015fps
    - FPS number bounced around quite a bit depending on system load
  - Debian Wheezy (7.5.x): 426/5 ~ 85fps
    - Software rendering; "r300 does not export required DRI extension"
    - X11 version 7.7+3, core version 1.12.4-6, radeon version 6.14.4-8, Mesa
      version 8.0.5-4

**hedgehog**
- 12" Powerbook (PowerBook6,4)
  - 1.33GHz PowerPC
  - NVidia GeForce FX Go5200, 64MB VRAM
  - OS X Leopard (10.5.8): 10745/5 ~ 2149fps
    - XQuartz 2.1.6, core version 1.4.2-apple33
  - Debian Wheezy (7.5.x): 3230/5 ~ 645fps
    - X11 version 7.7+3, core version 1.12.4-6, radeon version 6.14.4-8, Mesa
      version 8.0.5-4

**punisher**
- Power Mac G5 (PowerMac11,2)
  - 2.0GHz PowerPC 970MP Dual core, altivec supported
  - NVidia GeForce 6600 LE, 128MB VRAM
  - OS X Leopard (10.5.8): 15195/5 ~ 3039fps
    - The framerate started out around ~1400fps, then went up to ~3000fps
  - Debian Wheezy (7.5.x): 4194/5 ~ 838fps
    - X11 version 7.7+3, core version 1.12.4-6, radeon version 6.14.4-8, Mesa
      version 8.0.5-4
    - Kernel modules: `nouveau`, `drm_kms_helper`, `drm`

## Older numbers ##

pantera
- Whitebox PC, Tyan Tiger MP motherboard
  - Dual AMD Athalon 1600+ MP CPU's
  - NVidia GeForce4 Ti 4200
  - Debian Sarge x86: 3300fps

manzana
- 12" Powerbook
  - 1.4GHz PowerPC Processors
  - NVidia chipset
  - OS X Tiger (10.4.2): ~2100fps

solstice
- Whitebox PC
  - NVidia GEForce FX5200
  - Debian Sarge AMD Athalon: 1100fps

quake
- Apple iBook G3 700Mhz
  - ATI Radeon Mobile M6
  - Debian Sarge PPC: 295fps
  - Apple OS X 10.4.2: ~950fps

stinkpad
- IBM T40
  - Windows XP SP2
  - ATI Mobility Radeon 7500
  - Undocked - ~250fps
  - Docked - ~970fps

calavera
- Shuttle 95
  - NVidia GEForce4 MX 4000
  - Debian Sarge x86_64: 530fps

observer
- Shuttle 95
  - NVidia GeForce4 MX 4000
  - Debian Sarge x86_64: 458fps

devilduck 
- IBM Thinkcentre
  - Intel I810 
  - RHEL 3u4 - ~450-500 fps

imp 
- Toshiba 490XCDT
  - S3 Savage chipset
  - Knoppix: 56fps
  - Debian Woody x86: 42fps

vim: filetype=markdown shiftwidth=2 tabstop=2
