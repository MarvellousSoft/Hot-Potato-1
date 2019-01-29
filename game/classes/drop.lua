local Class    = require 'extra_libs.hump.class'
local Color    = require 'classes.color.color'
local Util     = require 'util'
local DRAWABLE = require 'classes.primitives.drawable'

--Drop of liquid Class

local Drop = Class{
	__includes = {DRAWABLE},
	init = function(self, x, y)
		local c = Color.blue()
		DRAWABLE.init(self, x, y, c)

		self.speed_y = 0

		self.image = IMG.drop

		self.tp = "drop"
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

--Collision between point 'p' and rectangle 'r' where point is table with {x, y} and
--rectangle is table with {x, y, w, h}
local function collisionPointRect(p, r)
	if p.x >= r.x and
	   p.x <= r.x + r.w and
		 p.y >= r.y and
		 p.y <= r.y + r.h then
			 return true
	end

	return false
end

function Drop:update(dt)


	self.pos.y = self.pos.y + self.speed_y * dt + GRAVITY * dt * dt / 2
	self.speed_y = self.speed_y + GRAVITY * dt

	if true then return end
	--Check collision with bucket
	local b = Util.findId("the_bucket")
	if b then
		local r = {x = b.pos.x, y = b.pos.y, w = b.image:getWidth(), h = b.image:getHeight()}
		local top_left = {x = self.pos.x, y = self.pos.y}
		local top_right = {x = self.pos.x + self.image:getWidth(), y = self.pos.y}
		local bottom_right = {x = self.pos.x + self.image:getWidth(), y = self.pos.y + self.image:getWidth()}
		local bottom_left = {x = self.pos.x, y = self.pos.y + self.image:getWidth()}

		if collisionPointRect(top_left, r) or
		   collisionPointRect(top_right, r) or
		   collisionPointRect(bottom_right, r) or
		   collisionPointRect(bottom_left, r) then
				 self.death = true
				 b.image = IMG.full_bucket
				 FadingText.new(x_near(self), y_near(self), "*FILL*")
		end



	end

	if not self.death and self.pos.y > GAME_FLOOR then
		self.pos.y = GAME_FLOOR
		self.speed_y = 0
		self.death = true
		FadingText.new(x_near(self), y_near(self), "*splash*")
	end


end

function Drop:draw()

	Color.set(self.color)
	love.graphics.draw(self.image, self.pos.x, self.pos.y)

end

-- Create a new drop and add it to the drawing and update tables
function Drop.new(x, y)

	local drop = Drop(x,y)
	drop:register("L2", "drops")

	return drop
end



return Drop
