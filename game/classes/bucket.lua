local sodapop = require 'extra_libs/sodapop'
local Eye = require 'classes/eye'

--Bucket Class

local Bucket = Class{
	__includes = {ELEMENT, POS},
	init = function(self, x, y)
		self.w, self.h = 110, 220
		y = y - self.h
		ELEMENT.init(self)
		POS.init(self, x, y)

		self.anim = sodapop.newAnimatedSprite(0, 0)
		self.anim:addAnimation('idle', {
			image = love.graphics.newImage 'assets/images/player/idle.png',
			frameWidth = 443,
			frameHeight = 569,
			frames ={
				{1, 1, 5, 8, .1}
			}
		})
		self.anim:addAnimation('jump', {
			image = love.graphics.newImage 'assets/images/player/jump.png',
			frameWidth = 486,
			frameHeight = 576,
			frames ={
				{1, 1, 6, 4, .1}
			}
		})
		self.anim:addAnimation('run', {
			image = love.graphics.newImage 'assets/images/player/run.png',
			frameWidth = 457,
			frameHeight = 611,
			frames ={
				{1, 1, 6, 4, .1}
			}
		})
		self.anim.sx, self.anim.sy = .4, .4

		self.speed_x = 200
		self.speed_y = 0
		self.jumps_left = -1
		self.on_floor = true
		self.moving = false

		self.tp = "bucket"

        self.eyes_ref = {self.w/2, self.h/8+8} -- eyes positions relative to player's origin
        self.eyes = {Eye.new(1), Eye.new(2)}
        self.eye_bridge = 10
	end
}

-- returns the position of the player's eyes
local function eyes_pos(self, p)
    local d = p==1 and self.eye_bridge or -self.eye_bridge
    return self.pos.x + self.eyes_ref[1] + d, self.pos.y + self.eyes_ref[2]
end

-- return a x position next to the object
local function x_near(self)
	return self.pos.x + love.math.random(-20, self.w + 20)
end

-- return a y position next to the object (not below)
local function y_near(self)
	return self.pos.y + love.math.random(-20, self.h - 20)
end

function Bucket:update(dt)
	self.anim:update(dt)

	if not love.keyboard.isDown('a', 'd') then
		if self.moving and self.on_floor then
			self.anim:switch('idle')
		end
		self.moving = false
	elseif not self.moving then
		if self.on_floor then
			self.anim:switch('run')
		end
		self.moving = true
		FadingText.new(x_near(self), y_near(self), "*running*")
	end

	if love.keyboard.isDown("a") then
		self.pos.x = self.pos.x - self.speed_x * dt
		self.anim.flipX = true
	end
	if love.keyboard.isDown("d") then
		self.pos.x = self.pos.x + self.speed_x * dt
		self.anim.flipX = false
	end

	-- jump
	if love.keyboard.isDown("w") and (self.on_floor or (self.jumps_left > 0 and self.speed_y > -200)) then
		FadingText.new(x_near(self), y_near(self), "*jump*")
		self.speed_y = -500
		if self.on_floor then
			self.on_floor = false
			self.anim:switch('jump')
			self.jumps_left = 1
		else
			self.jumps_left = self.jumps_left - 1
		end
	end

	self.pos.y = self.pos.y + self.speed_y * dt + GRAVITY * dt * dt / 2
	self.speed_y = self.speed_y + GRAVITY * dt

	if self.pos.y + self.h > GAME_FLOOR then
		self.pos.y = GAME_FLOOR - self.h
		self.speed_y = 0
		if not self.on_floor then
			if self.moving then
				self.anim:switch('run')
			else
				self.anim:switch('idle')
			end
		end
		self.on_floor = true
	end

    for i=1,2 do
        self.eyes[i]:update_pos(eyes_pos(self, i)) -- update eyes positions
        self.eyes[i]:update(dt)
    end
end

function Bucket:draw()

	self.anim:draw(self.pos.x + self.w / 2, self.pos.y + self.h / 2)
	if SHOW_HITBOX then
		Color.set(Color.green())
		love.graphics.rectangle('line', self.pos.x, self.pos.y, self.w, self.h)
	end

    for i=1,2 do self.eyes[i]:draw() end
end


function Bucket:keypressed(key, scode, isrepeat)
    for i=1,2 do self.eyes[i]:keypressed(key, scode, isrepeat) end
end

--Create bucket and add it to layer 2 on draw tables
function Bucket.new()

	local bucket = Bucket(100, GAME_FLOOR)
	bucket:addElement("L2", nil, "the_bucket")

	return bucket
end

return Bucket
