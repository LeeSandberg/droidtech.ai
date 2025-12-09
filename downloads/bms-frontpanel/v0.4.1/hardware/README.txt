BMS Front Panel Firmware Release Package
=========================================

Version: v0.4.1
Build Date: $(date -u +"%Y-%m-%d %H:%M:%S UTC")
Target: Nuvoton M483 MCP (ARM Cortex-M4F)

Files Included:
---------------
Application Firmware:
  - frontpanel_app.elf    : ELF executable with debug symbols
  - frontpanel_app.bin    : Raw binary for direct flash programming
  - frontpanel_app.hex    : Intel HEX format
  - frontpanel_app_icp.bin: Binary with ICP header for bootloader updates

Bootloader Firmware:
  - front_panel_bl        : ELF executable with debug symbols
  - front_panel_bl.bin    : Raw binary for direct flash programming
  - front_panel_bl.hex    : Intel HEX format

Combined Firmware:
  - firmware_complete.bin : Complete firmware (bootloader + application)

Verification:
  - SHA256SUMS.txt           : Application firmware checksums
  - BOOTLOADER_SHA256SUMS.txt: Bootloader checksums
  - manifest.json            : Build metadata

Programming Instructions:
------------------------
1. Verify checksums match SHA256SUMS.txt files
2. Use Nu-Link, OpenOCD, or J-Link to program the device
3. Flash bootloader first (if updating bootloader)
4. Flash application firmware

For field updates via bootloader:
- Use frontpanel_app_icp.bin with the bootloader update protocol

Support: https://droidtech.ai
