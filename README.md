# Lua Minesweeper

This is my attempt at using Lua to make the classic game Minesweeper for as many platforms as I can. For now it only implements the basic gameplay for with traditional difficulty levels without any timers/flag counters. It is a work in progress!

![](assets/screenshots/showcase.png)

## Platforms

- Plain Lua via CLI
- Desktop via LÖVE
- PlayStation 2 via Enceladus

## Game Design

The core logic of Lua Minesweeper is platform independent and implemented in *logic.lua*.

Each platform has a folder within the source tree, which has an implementation README and platform specific Lua code.
For the most part that is just requiring the logic file and implementing a UI around it.

## Building

There is a Makefile which builds release folders that are ready to run on each platform.
You can build just for a specific platform by specifying the target, e.g. `make lua`.

## License

This project has dependencies (e.g. Enceladus) that are GPLv3 and is hence under the same license, apart from the following exemption(s):

- The file "ansicolors.lua" for the Lua platform is Rob Hoelz's and Enrique García Cota's "ansicolors.lua", modified to support Windows Terminal. This modified version can be used under the original MIT license.

## Platforms awaiting implementation and/or under consideration:

- Adjust LÖVE version to play nice on Mobile 
- Love.js for the Web
- Wii via LuafWii or Wiilove
- Textadept
- Dreamcast via ANTIRUINS
- ROBLOX
- PSP via Lua Player Plus PSP
- REAPER
- PICO-8
- (Neo)Vim
- If I'm willing to look at developing my own LuaPlayer(s), I could maybe support PSX, N64 etc.
- Note to self: Check out KallistiOS and its possible GC support

## Credits

- PUC-Rio for [Lua](https://www.lua.org).
- The [LÖVE](https://www.love2d.org) developers.
- @DanielSant0s for [Enceladus](https://github.com/DanielSant0s/Enceladus).
- Rob Hoelz and Enrique García Cota for "ansicolors.lua"
