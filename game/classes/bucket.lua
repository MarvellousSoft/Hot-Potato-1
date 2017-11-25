--Bucket Class

local FadingText = require "classes/fading_text"

-- gravity
local g = 1000

local Bucket = Class{
	__includes = {ELEMENT, POS},
	init = function(self, x, y)
		ELEMENT.init(self)
		POS.init(self, x, y)

		self.floor_y = y

		self.speedv = 200

		self.speed_y = 0
		self.jumps_left = -1

		self.on_floor = true

		self.moving = false

		self.tp = "bucket"
	end
}

-- return a x position next to the object
local function x_near(self)
	return self.pos.x + love.math.random(-20, IMG.bucket:getWidth() + 20)
end

-- return a y position next to the object (not below)
local function y_near(self)
	return self.pos.y - love.math.random(20, IMG.bucket:getWidth() + 20)
end

function Bucket:update(dt)

	if not love.keyboard.isDown('left', 'a', 'right', 'd') then
		self.moving = false
	elseif not self.moving then
		self.moving = true
		FadingText.new(x_near(self), y_near(self), "*running*")
	end

	if love.keyboard.isDown("left", "a") then
		self.pos.x = self.pos.x - self.speedv*dt
	end
	if love.keyboard.isDown("right", "d") then
		self.pos.x = self.pos.x + self.speedv*dt
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

	self.pos.y = self.pos.y + self.speed_y * dt + g * dt * dt / 2
	self.speed_y = self.speed_y + g * dt

	if self.pos.y > self.floor_y then
		self.pos.y = self.floor_y
		self.speed_y = 0
		self.on_floor = true
	end


end

function Bucket:draw()

	Color.set(Color.white())
	love.graphics.draw(IMG.bucket, self.pos.x, self.pos.y)

end


return Bucket
