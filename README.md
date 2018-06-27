Status
------

**!!! THIS IS CURRENTLY NOT TESTED !!!***

Support
-------

If you appreciate this project, support me on Patreon or Liberapay !

[![Patreon !](https://raw.githubusercontent.com/Miouyouyou/RockMyy/master/.img/button-patreon.png)](https://www.patreon.com/Miouyouyou) 
[![Liberapay !](https://raw.githubusercontent.com/Miouyouyou/RockMyy/master/.img/button-liberapay.png)](https://liberapay.com/Myy/donate) 
[![Tip with Altcoins](https://raw.githubusercontent.com/Miouyouyou/Shapeshift-Tip-button/9e13666e9d0ecc68982fdfdf3625cd24dd2fb789/Tip-with-altcoin.png)](https://shapeshift.io/shifty.html?destination=16zwQUkG29D49G6C7pzch18HjfJqMXFNrW&output=BTC)

Using the main script
---------------------

```bash
sh GetPatchAndCompileKernel.sh
```

This works whether you cloned this whole repository or just downloaded
the script alone.

Don't hesitate to edit the script and replace the `CROSS_COMPILE` value
in the script, in order to match your cross-compiling toolset prefix.

If you'd like to reconfigure the kernel using **menuconfig**, 
**nconfig**, **qtconfig**, ... do it like this :

```bash
# Assuming that you want to use menuconfig
MAKE_CONFIG=menuconfig sh GetPatchAndCompileKernel.sh
```

About
-----

This repository provides patches and mainline kernel cross-compiling
scripts tailored towards Rockchip 3399 boards.

The [main cross-compiling script](./GetPatchAndCompileKernel.sh) will :
* Clone the latest release or release candidate branch of the mainline kernel;
* Integrate the Mali Midgard r19p0 drivers to the cloned kernel;
* Apply various RK3399 specific patches for Nano PC T4;
* Copy and use this repository configuration file;
* Cross-compile the patched kernel;
* Create the folder `/tmp/Rockmyy-Build` and install the cross-compiled kernel in that folder.

