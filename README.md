# Tetris FDS

https://github.com/TakuikaNinja/TetrisFDS

This is a proof-of-concept port of Tetris to the Famicom Disk System, similar to [Dr. Mario](https://github.com/TakuikaNinja/dr-mario-fds).
It abuses the fact that most of the variables and routines originate from the [FDS BIOS](https://www.nesdev.org/wiki/FDS_BIOS).

It builds `tetris.fds` with the following differences from the original game:
- Boots and runs on FDS, bypassing the BIOS' license message check.
- Most of the generic subroutines have been replaced with calls to the BIOS routines.
- Loading screens have been inserted to load the appropriate CHR data for each screen.
- CHR bankswitching is faked to keep the title/menu and gameplay screens intact.
- Minor bugfix: PPUCTRL is now set in the NMI handler to maintain the correct nametable selection bits (0-1).
   - This was required for the game to look correct without the MMC1's single-screen mirroring mode.

Possibilities opened up by this port (but no immediate plans to implement them):
- Hi-score table saving using disk I/O.
- Restoration of the demo recording mode by writing $FF to zero-page address $D0.
- Extra features/bugfixes due to some PRG-RAM space being freed up by the BIOS routines.

This port is based on: https://github.com/CelestialAmber/TetrisNESDisasm

## Original README (continued)

To set up the repository, see [**INSTALL.md**](INSTALL.md).

Thanks to https://github.com/ejona86 for creating an info file and other files used to generate the disassembly code and other parts of the disassembly. (Original repository link:  https://github.com/ejona86/taus)

CHR png converting tools repository link: https://github.com/qalle2/nes-util
