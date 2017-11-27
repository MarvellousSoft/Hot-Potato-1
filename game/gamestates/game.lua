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

	Draw.allTables()

end

function state:keypressed(key)

	if key == "r" then
		switch = "MENU"
	else
		Util.defaultKeyPressed(key)
	end

end

--Return state functions
return state
