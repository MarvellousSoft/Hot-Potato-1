--MODULE FOR SETUP STUFF--

local setup = {}

--------------------
--SETUP FUNCTIONS
--------------------

--Set game's global variables, random seed, window configuration and anything else needed
function setup.config()

	--RANDOM SEED--
	love.math.setRandomSeed( os.time() )

	--TIMERS--
	MAIN_TIMER = Timer.new()  --General Timer


	--GLOBAL VARIABLES--
	DEBUG = true --DEBUG mode status
	SHOW_HITBOX = false -- show hitboxes for elements

	O_WIN_W = 960 --The original width of your game. Work with this value when using res_manager multiple resolutions support
	O_WIN_H = 540 --The original height of your game. Work with this value when using res_manager multiple resolutions support

	GRAVITY = 1000 --In-game gravity
	GAME_FLOOR = O_WIN_H * .9 --Y position of game floor

	--INITIALIZING TABLES--
	--Drawing Tables
	DRAW_TABLE = {
		BG  = {}, --Background (bottom layer, first to draw)
		L1  = {}, --Layer 1
		L2  = {}, --Layer 2
		GUI = {}  --Graphic User Interface (top layer, last to draw)
	}
	--Other Tables
	SUBTP_TABLE = {} --Table with tables for each subtype (for fast lookup)
	ID_TABLE = {} --Table with elements with Ids (for fast lookup)

	--CAMERA--
	CAM = Camera(O_WIN_W/2, O_WIN_H/2) --Set camera position to center of screen

	--IMAGES--
	IMG = { --Table containing all the images
		empty_bucket = love.graphics.newImage("assets/images/empty_bucket.png"),
		full_bucket = love.graphics.newImage("assets/images/full_bucket.png"),
		drop = love.graphics.newImage("assets/images/drop.png"),
	}

	--FONTS--
	FONTS = {
		default = love.graphics.getFont()
	}

	--AUDIO--
	SFX = { --Table containing all the sound fx
	}

	BGM = { --Table containing all the background music tracks
	}


	--SHADERS--
	--

end

--Return functions
return setup
