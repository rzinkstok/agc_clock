# AGC clock

Test project for finding out how to program the Numato Styx board for using the Zynq Processing System PLL clock, and programming the QSPI flash so the
programmed circuit sticks after disconnecting and rebooting the board.

Prerequisites:
- Xilinx Vivado 2019.1
- A JTAG programming cable (Digilent JTAG-HS3 in my case)
- Numato Styx development board
- Installed driver for the board (see the Numato Styx website)

Sources:
- The Numato Styx user manual (https://numato.com/docs/styx-zynq-module/)
- The Numato Styx website (https://numato.com/product/styx-zynq-7020-fpga-module)
- The Numato knowledge base article on booting from flash (https://numato.com/kb/styx-boot-sd-card-qspi-flash/)

Changes in the configuration of channel A of the onboard FT2232H USB – Serial device (as mentioned in the knowledge base article) 
is only needed if you want to see the output of the `helloworld.c` program through a serial port connection. Note that the knowledge 
base article talks about configuring channel B, which is not correct: the customizable channel on the Styx is channel A. The 
knowledge base article references another article on configuring the Saturn board, for which the customizable channel is channel B;
this presumably explains the error.


## Linux

In order to be able to access the JTAG USB device, run the following script:

```
sudo /tools/Xilinx/Vivado/2019.1/data/xicom/cable_drivers/lin64/install_script/install_drivers/install_drivers
```

Also, if working on a virtual machine, make sure USB 3.0 support is enabled.

Check that the device is properly recognized:
- Set the Styx boot mode to boot from JTAG (jumper JP1 only between 1 and 2)
- Connect the JTAG programming cable
- Power the board
- `lsusb` should show an entry `ID 0403:6014 Future Technology Devices International, Ltd FT232H Single HS USB-UART/FIFO IC`
- The permissions on `/dev/bus/usb/<bus number>/<device number>` should be `666`.


## Programming

- After generating the bitstream, export the hardware using `File - Export - Export Hardware...`.
- At this point, you can use the Hardware Manager to program the device directly. This will work but the program is lost
  when the device is powered down. To make the program permanent, instead do the following:
- Select `Include bitstream` and `Local to project`, then click OK; overwrite if asked.
- Launch the SDK
- Create a new application project by selecting `File - New - Application Project`
- Name it `fsbl`, leave the rest default. Note the hardware platform, this should correspond to the folder where the bitstream ended up. Click `Next`.
- Select `Zynq FSBL` and click `Finish`.
- Create a new application project by selecting `File - New - Application Project`.
- Name it `HelloWorld`, select `Board Support Package - Use existing`, and make sure `fsbl_bsp` is selected. Click `Next`.
- Select `Hello World` and click `Finish`.
- Modify the file `HelloWorld/src/helloworld.c` such that the `print` statement is enclosed in an infinite `while` loop. Save and build.
- Select the `HelloWorld` project
- Select `Xilinx - Create Boot Image`
- Select format `MSC`
- Make sure the following files are included:
  - `...\agc_clock.sdk\fsbl\Debug\fsbl.elf` with partition type bootloader
  - `...\agc_clock.sdk\agc_clock_hw_platform_0\agc_clock.bit` with partition type data file (check this is the right hardware platform as noted above!)
  - `...\agc_clock.sdk\HelloWorld\Debug\HelloWorld.elf` with partition type data file
- Click `Create Image`
- Set the Styx boot mode to boot from JTAG (jumper J1 only between 1 and 2)
- Connect the JTAG programming cable
- Power the board
- Select `Xilinx - Program Flash`
- Make sure to select the right hardware platform, the one that contains the bitstream used above
- Select `...\agc_clock.sdk\HelloWorld\bootimage\BOOT.mcs` as Image File.
- Select `...\agc_clock.sdk\fsbl\Debug\fsbl.elf` as FSBL File.
- Click `Program`
- Disconnect the JTAG cable
- Power down the board
- Set the Styx boot mode to QSPI (jumper J1 between 1 and 3 and between 2 and 4)
- Power the board: the clock should be running on one of the output pins (see the constraints file)


## Reprogramming

- After generating the bitstream, export the hardware using `File - Export - Export Hardware...`.
- Select `Include bitstream` and `Local to project`, then click OK; overwrite if asked.
- Launch the SDK
- Select `Project - Clean...`, set to `Clean all projects` and click OK
- Select the `HelloWorld` project
- Select `Xilinx - Create Boot Image`
- Select `Import from existing BIF file` and set `...\agc_clock.sdk\HelloWorld\bootimage\HelloWorld.bif` as `Import BIF file path`
- Check the loaded settings, and click `OK`
- Set the Styx boot mode to boot from JTAG (jumper J1 only between 1 and 2)
- Connect the JTAG programming cable
- Power the board
- Select `Xilinx - Program Flash`
- Make sure to select the right hardware platform, the one that contains the bitstream used above
- Program
- Disconnect the JTAG cable
- Power down the board
- Set the Styx boot mode to QSPI (jumper J1 between 1 and 3 and between 2 and 4)
- Power the board


