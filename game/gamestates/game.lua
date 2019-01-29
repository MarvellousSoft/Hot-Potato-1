local Util   = require 'util'
local Draw   = require 'draw'
local Bucket = require 'classes.bucket'
local Drop   = require 'classes.drop'
local Color  = require 'classes.color.color'

--MODULE FOR THE GAMESTATE: GAME--

local state = {}

--LOCAL VARIABLES--

local time_to_drop = 1
local tick = 0

--LOCAL FUNCTIONS--

--STATE FUNCTIONS--

function state:enter()

	--Create bucket
	Bucket.new()

end

function state:leave()

	Util.destroyAll("force")

end


function state:update(dt)
	tick = tick + dt
	while tick >= time_to_drop do
		tick = tick - time_to_drop
		local x = love.math.random(10, O_WIN_H - 10)
		local y = 30
		Drop.new(x, y)
	end


	Util.updateDrawTable(dt)

	Util.destroyAll()

end

function state:draw()

	Color.set(Color.black())
	love.graphics.rectangle('fill', 0, GAME_FLOOR, O_WIN_W, O_WIN_H)

	Draw.allTables()

end

function state:keypressed(key)

	if key == "r" then
		switch = "MENU"
	else
		Util.defaultKeyPressed(key)
	end

    Util.findId("the_bucket"):keypressed(key)
end

--Return state functions
return state
