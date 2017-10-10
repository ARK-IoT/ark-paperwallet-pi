<img src="https://github.com/Ark-IoT/ark-paperwallet-pi/blob/master/ark_paperwallet_pi_logo.png" width="350">  


### What is Ark: PaperWallet Pi

**Ark: PaperWallet Pi** is an offline, secure, WiFi-accessible webserver;  
a hardware-based paper wallet generator for the Ark cryptocurrency!  

Based off of [**Ark-PaperWallet**](https://github.com/ArkEcosystem/ark-paperwallet) 
and [**PirateBox**](https://github.com/PirateBox-Dev),  
Ark: PaperWallet Pi is a FOSS project, GPL3 compatible and MIT Licensed.

-----

### Screenshot  

Address: **paperwallet.lan**  

<img src="https://github.com/Ark-IoT/ark-paperwallet-pi/blob/master/screenshot.png" width="350">  

**Welcome Aboard!**  

-----

### Tested Hardware  
#### Raspberry Pi Zero W:  

<img src="https://github.com/sleepdefic1t/ark-nbx/blob/master/rpizw.png" width="300">


|    Part     |   Source    |
| :---------: | :---------: |
| Raspberry Pi Zero W | https://www.adafruit.com/product/3400 |  
| "Class 10/U1" microSD-card | **ex:** https://www.adafruit.com/product/2692 |


-----

# Preparation

### Image Preparation 

- See [**How to Raspbian**](https://github.com/Ark-IoT/ark-paperwallet-pi/blob/master/docs/How_to_Raspbian.md) for instructions on how to download and flash Raspbian.

#

### OTG-Mode

- See [**How to OTG**](https://github.com/Ark-IoT/ark-paperwallet-pi/blob/master/docs/How_to_OTG.md) for instructions on how to install Raspbian and access your Pi over USB.

#

#### Preparation Notes:
- Make sure you are sharing/bridging your internet connection via usb-cable with your RPi.
- Installation will take about 10-minutes.

-----


# Installation:   

#### Requirements
- For non-Zero W Pi's, you will need a [**compatible**](http://elinux.org/RPi_USB_Wi-Fi_Adapters) USB-WiFi adapter.
- If installing from Raspbian or another RPi distro, you'll need ```Git``` to clone this repo.  
  ```sudo apt-get install git```

#

**1.** Connect to your RPi.   
- if using Raspbian Stretch Lite: 
    SSH via usb [**headless-mode**](https://github.com/Ark-IoT/ark-paperwallet-pi/edit/master/README.md#ln47)  
    ``` ssh pi@raspberrypi.local```  
- default password: ```raspberry```  
- **Be sure to change this afterwards.**  

#

**2.** Expand your filesystem 
- Expand your filesystem to use your whole microSD-card:  
    ```sudo raspi-config```  
- **Option 7: Advanced Options**  
- **Option A1: Expand Filesystem**  
- Reboot when prompted,  
    or manually via ```sudo reboot```

#

**3.** Clone this repo & 'cd' into it:  
- ```git clone https://github.com/Ark-IoT/ark-paperwallet-pi```  
- ```cd ark-paperwallet-pi```

#

**4.** Change permissions of the "paperwallet" folder:  
- ```sudo chmod -R 775 paperwallet```  

#

**5.** 'cd' to 'paperwallet' and run the install.sh file:  
- ```cd paperwallet```  
- ```sudo ./install.sh```  

#

**6.** Wait about 1-minute after the install script finishes, then:   
- ```sudo shutdown now```

#

**7.** Plug your RPi into a power source (ex: micro-usb power port).
- **Your Ark: Paper Wallet Pi will power on,  
    and the WiFi network** ```Ark: Paper Wallet``` **will be visible.**  
- First boot can take a few minutes depending on hardware(microSD speed, Pi-model, etc).

#

**8.** Using a standard web-browser, navigate to:  
- ```paperwallet.lan```  
**Welcome Aboard!**  

-----

## Troubleshooting:

### **'Ark: Paper Wallet' WiFi network not showing up.**  
There are many errors that can cause this.
Try running ```sudo ./install.sh``` again.  
Using another micro-usb cable or a 'class 10' microSD card can usually fix this as well.  

#

### The Wifi signal drops/disappears every time I connect!
This can be caused by not getting enough power(mAh/Ah).
Make sure to use a 5V >=1,000mAh/1Ah power supply. 2Ah or better if using NFC or additional hardware.
If your power source meets those requirements, try another power source or USB-cable.

#

### **'Broken Pipe' / Timeout / Disconnect Errors**  
If for any reason your RPi's connection fails/freezes during installation,  
Reconnect to your Pi, then run:  
```sudo dpkg --configure -a```  
You should then return to Step 5,  
'cd' into 'paperwallet' then,  
 ```sudo ./install.sh```  
to finish installation.

-----

## ToDo:
- [ ] Make a better todo
- [ ] Documention!

-----

### Tip Jar   
**ѦRK [Ѧ]:** ```AZreeHxX23s4jttL3ML8n6A2aLrwHPfVGZ```  
**DѦRK [DѦ]:** ```DHQ4Fjsyiop3qBR4otAjAu6cBHkgRELqGA```  
