--Bucket Class

local Bucket = Class{
	__includes = {ELEMENT, POS},
	init = function(self, x, y)
		ELEMENT.init(self)
		POS.init(self, x, y)

		self.speed_x = 200
		self.speed_y = 0
		self.jumps_left = -1
		self.on_floor = true
		self.moving = false

		self.image = IMG.empty_bucket

		self.tp = "bucket"
	end
}

-- return a x position next to the object
local function x_near(self)
	return self.pos.x + love.math.random(-20, self.image:getWidth() + 20)
end

-- return a y position next to the object (not below)
local function y_near(self)
	return self.pos.y - love.math.random(20, self.image:getWidth() + 20)
end

function Bucket:update(dt)

	if not love.keyboard.isDown('left', 'a', 'right', 'd') then
		self.moving = false
	elseif not self.moving then
		self.moving = true
		FadingText.new(x_near(self), y_near(self), "*running*")
	end

	if love.keyboard.isDown("left", "a") then
		self.pos.x = self.pos.x - self.speed_x*dt
	end
	if love.keyboard.isDown("right", "d") then
		self.pos.x = self.pos.x + self.speed_x*dt
	end

	-- jump
	if love.keyboard.isDown("up", "space", "w") and (self.on_floor or (self.jumps_left > 0 and self.speed_y > -200)) then
		FadingText.new(x_near(self), y_near(self), "*jump*")
		self.speed_y = -500
		if self.on_floor then
			self.on_floor = false
			self.jumps_left = 1
		else
			self.jumps_left = self.jumps_left - 1
		end
	end

	self.pos.y = self.pos.y + self.speed_y * dt + GRAVITY * dt * dt / 2
	self.speed_y = self.speed_y + GRAVITY * dt

	if self.pos.y > GAME_FLOOR then
		self.pos.y = GAME_FLOOR
		self.speed_y = 0
		self.on_floor = true
	end


end

function Bucket:draw()

	Color.set(Color.white())
	love.graphics.draw(self.image, self.pos.x, self.pos.y)

end

--Create bucket and add it to layer 2 on draw tables
function Bucket.new()

	local bucket = Bucket(100, GAME_FLOOR)
	bucket:addElement("L2", nil, "the_bucket")

	return bucket
end


return Bucket
