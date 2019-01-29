
local Gamestate = require 'extra_libs.hump.gamestate'
local Setup = require 'setup'
local Res = require 'res_manager'


--GAMESTATES
GS = {
	GAME = require "gamestates.game",     --Game Gamestate
}

------------------
--LÖVE FUNCTIONS--
------------------

function love.load()

	Setup.config() --Configure your game

	Gamestate.registerEvents() --Overwrites love callbacks to call Gamestate as well

	--[[
		Setup support for multiple resolutions. Res.init() Must be called after Gamestate.registerEvents()
		so it will properly call the draw function applying translations.
	]]
	Res.init()

	Gamestate.switch(GS.GAME) --Jump to the inicial state

	love.graphics.setBackgroundColor(255, 255, 255)
end
