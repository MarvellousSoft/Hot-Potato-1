--MODULE FOR THE GAMESTATE: GAME--

local state = {}

--LOCAL VARIABLES--

--LOCAL FUNCTIONS--

--STATE FUNCTIONS--

function state:enter()

	--Create bucket and add it to layer 2 on draw tables
	local bucket = Bucket(100, 200)
	bucket:addElement("L2", nil, "the_bucket")

end

function state:leave()

	Util.destroyAll("force")

end


function state:update(dt)

	Util.updateId(dt, "the_bucket")

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
