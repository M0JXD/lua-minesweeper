# Makefile for Lua Minesweeper

all: build lua love textadept ps2 wii

build:
	-mkdir -p build

lua: build
	-mkdir -p build/lua
	cp src/logic.lua src/platforms/lua/init.lua build/lua

love: build

ps2: build

textadept: build

wii: build

clean:
	rm -r build
