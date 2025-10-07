# PL USXGMII v2024.2

## **Design Summary**

This project utilizes USXGMII Ethernet Subsystem. This has been routed to the SFP cage on SFP0 for use on a ZCU102 board. System is configured to use the ZCU102 si570 at 156.25MHz.

- `end0` is configured as USXGMII Ethernet Subsystem routed to SFP0.

---

## **Required Hardware**

- ZCU102
- SFP supporting USXGMII
- USXGMII capable link partner

---

## **Build Instructions**

### **Vivado:**

Enter the `Scripts` directory. From the command line run the following:

`vivado -source *top.tcl`

The Vivado project will be built in the `Hardware` directory.

### **PetaLinux**:

Enter the `Software/PetaLinux/` directory. From the command line run the following:

`petalinux-config --get-hw-description ../../Hardware/pre-built/ --silentconfig`

followed by:

`petalinux-build`

The PetaLinux project will be rebuilt using the configurations in the PetaLinux directory. To reduce repo size, the project is shipped pre-configured, but un-built.

Once the build is complete, the built images can be found in the `PetaLinux/images/linux/`
directory. To package these images for SD boot, run the following from the `PetaLinux` directory:

`petalinux-package --boot --fsbl images/linux/zynqmp_fsbl.elf --fpga images/linux/*.bit --pmufw images/linux/pmufw.elf --u-boot --force`

Once packaged, the `BOOT.bin` and `image.ub` files (in the `PetaLinux/images/linux` directory) can be copied to an SD card, and used to boot.

---

## **Validation**
### **Kernel:**
**NOTE:** The interfaces are assigned as follows:
 - `end0` -> 10G
```
Petalinux24:/home/petalinux# dmesg | grep axie
[    9.922871] xilinx_axienet a0010000.ethernet end0: renamed from eth0
[   12.399953] xilinx_axienet a0010000.ethernet end0: USXGMII setup at 10000
Petalinux24:/home/petalinux# ifconfig end0 192.168.1.2
Petalinux24:/home/petalinux# ping -A -q -w 3 -I eth0 192.168.1.1 
ping: bad address 'eth0'
Petalinux24:/home/petalinux# ping -A -q -w 3 -I end0 192.168.1.1 
PING 192.168.1.1 (192.168.1.1): 56 data bytes

--- 192.168.1.1 ping statistics ---
25137 packets transmitted, 25137 packets received, 0% packet loss
round-trip min/avg/max = 0.104/0.118/0.423 ms
```
### **Performance:**
**NOTE:** These are rough performance numbers - your actual performance may vary based on a variety of factors such as network topology and kernel load.
---

## **Known Issues**

---
