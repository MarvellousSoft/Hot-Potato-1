--Bucket Class

local Bucket = Class{
	__includes = {ELEMENT, POS},
	init = function(self, x, y)
		ELEMENT.init(self)
		POS.init(self, x, y)

		self.speedv = 200

		self.tp = "bucket"
	end
}

function Bucket:update(dt)

	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		self.pos.x = self.pos.x - self.speedv*dt
	end
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		self.pos.x = self.pos.x + self.speedv*dt
	end

end

function Bucket:draw()

	Color.set(Color.white())
	love.graphics.draw(IMG.bucket, self.pos.x, self.pos.y)

end


return Bucket
