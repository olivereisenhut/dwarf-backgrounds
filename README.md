# Dwarf Backgrounds

## Purpose
This tool will change you background with a neat picture from Unsplash.com

## Build

### Build with Valac
compile with `valac DwarfBackgrounds.vala GsettingConfigurator.vala UnsplashApi.vala FilesystemController.vala DbusMessenger.vala CommandParser.vala CommandExecuter.vala Commands/ICommand.vala Commands/UserCommand.vala Commands/RandomCommand.vala Commands/CategoryCommand.vala Errors/BadArgumentError.vala --pkg gio-2.0 --pkg posix`

### Build with CMake
1. First run `cmake .`
2. Compile with `make`
3. Install with `sudo cmake install`

