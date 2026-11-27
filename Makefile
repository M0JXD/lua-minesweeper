# Makefile for Lua Minesweeper

all: lua love ps2 docs

lua:
	mkdir -p build/lua
	cp src/logic.lua src/lua/* build/lua

ps2: build/ps2 build/ps2/minesweeper/minesweeper.lua

build/ps2:
	mkdir -p build
	curl -L -s -o build/enceladus.tar.gz https://github.com/DanielSant0s/Enceladus/releases/download/latest/Enceladus.tar.gz
	tar -xzf ./build/enceladus.tar.gz -C ./build && rm ./build/enceladus.tar.gz
	mv ./build/Enceladus ./build/ps2
	rm -r ./build/ps2/lua_intellisense ./build/ps2/mesh ./build/ps2/pads && rm ./build/ps2/enceladus.elf
	echo "dofile('minesweeper.minesweeper.lua')" > ./build/ps2/System/system.lua

build/ps2/minesweeper/minesweeper.lua: src/ps2/minesweeper.lua
	mkdir -p build/ps2/minesweeper
	cp src/logic.lua src/ps2/* build/ps2/minesweeper
	cp assets/*.png build/ps2/minesweeper

love: src/love/main.lua
	mkdir -p build/love/src/assets
	cp assets/*.png build/love/src/assets
	cp src/logic.lua src/love/* build/love/src
	(cd build/love/src && zip -9 -r ../minesweeper.love .)
	rm -r build/love/src

megadrive:
	mkdir -p build/megadrive
	cd build/megadrive && npm install mdlua
	cd build/megadrive && npx mdlua build main.lua -o minesweeper.bin

.PHONY: docs update

docs:
	ldoc --boilerplate --filter external/markdowndoc.ldoc src/logic.lua -- --title="Lua Minesweeper Logic Implementation" --single > src/LOGIC.md
	ldoc --boilerplate --filter external/markdowndoc.ldoc src/love/main.lua -- --title="Lua Minesweeper LOVE2D Platform" --single > build/love/LOVE2D.md
	ldoc --boilerplate --filter external/markdowndoc.ldoc src/lua/minesweeper.lua -- --title="Lua Minesweeper Lua Platform" --single > build/lua/LUA_CONSOLE.md
	ldoc --boilerplate --filter external/markdowndoc.ldoc src/ps2/minesweeper.lua -- --title="Lua Minesweeper PS2 Platform" --single > build/ps2/PLAYSTATION_2.md

# Grab latest external files.
update:
	# Markdown Filter for LDoc.
	curl -L -s --output-dir external -O https://raw.githubusercontent.com/orbitalquark/textadept/refs/heads/default/scripts/markdowndoc.lua
	# Ansicolors
	#curl -s -O  https://raw.githubusercontent.com/orbitalquark/textadept/refs/heads/default/scripts/markdowndoc.lua

clean:
	rm -r build
