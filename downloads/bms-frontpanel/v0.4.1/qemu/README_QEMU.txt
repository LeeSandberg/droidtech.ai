BMS Front Panel Firmware - QEMU Emulation Build
================================================

Version: v0.4.1-qemu
Build Date: $(date -u +"%Y-%m-%d %H:%M:%S UTC")
Target: QEMU ARM Emulation

⚠️ IMPORTANT: This is a QEMU emulation build with injectable test data.
This firmware is NOT for production hardware - use hardware builds instead.

Features:
---------
- Injectable battery voltage, current, and SoC via HAL
- Simulated EADC measurements
- Same codebase as hardware version
- Useful for automated testing and CI/CD validation

Memory Layout:
--------------
- QEMU build uses full 256KB flash (no bootloader offset)
- Hardware build uses ~216KB (32KB bootloader + 512B header reserved)
- Developers: If QEMU build exceeds ~216KB, it won't fit on hardware!
- Vector table at 0x0000 (QEMU requirement, unlike hardware at 0x8200)

Files Included:
---------------
- frontpanel_app_qemu.elf        : QEMU executable with debug symbols
- frontpanel_app_qemu.bin        : Raw binary for QEMU memory loading
- frontpanel_app_qemu.hex        : Intel HEX format
- frontpanel_app_qemu_icp.bin    : ICP format (Note: "_qemu" suffix to prevent confusion with hardware)
- SHA256SUMS_QEMU.txt            : Checksums for verification
- manifest_qemu.json             : Build metadata with emulation flag

Running in QEMU:
----------------
qemu-system-arm -M nuvoton-m480 -kernel frontpanel_app_qemu.elf -nographic

With GDB debugging:
qemu-system-arm -M nuvoton-m480 -kernel frontpanel_app_qemu.elf -s -S
arm-none-eabi-gdb frontpanel_app_qemu.elf
(gdb) target remote :1234

Data Injection via GDB:
-----------------------
(gdb) call g_measurement_hal.inject_voltage(37000)    # 37.0V
(gdb) call g_measurement_hal.inject_current(-5000)    # -5A discharge
(gdb) call g_measurement_hal.inject_soc(75)           # 75% SoC

Support: https://droidtech.ai
