-- Fading Text Class

-- Text that rotates and scales randonmly, and disappears automatically
local FadingText = Class{
	__includes = {DRAWABLE},
	init = function(self, x, y, text)
		x, y = math.floor(x), math.floor(y)
		local c = Color.new(love.math.random(0, 255), 255, 255 / 2, 255)

		DRAWABLE.init(self, x, y, c)
		self.text = text

		self.alp_speed = love.math.random(90, 200)
		self.rot_speed = love.math.random(1, 2)
		if love.math.random() <= .5 then self.rot_speed = -self.rot_speed end
		self.scale_speed = math.pow(2, love.math.random(-1, 1))

		self.rotation = 0
		self.sx, self.sy = nil, nil
		self.scale = 1

		self.tp = "fading_text"
	end
}

function FadingText:update(dt)
	if self.death then return end
	self.color.a = self.color.a - dt * self.alp_speed
	self.rotation = self.rotation + dt * self.rot_speed
	self.scale = self.scale * math.pow(self.scale_speed, dt)
	if self.color.a <= 0 then
		self.color.a = 0
		self:kill()
	end
end

function FadingText:draw()
	love.graphics.setFont(FONTS.default)
	Color.set(self.color)
	love.graphics.print(self.text, self.pos.x, self.pos.y, self.rotation, self.scale, self.scale, FONTS.default:getWidth(self.text) / 2)
end

-- Create a fading text and add it to the drawing and update tables
function FadingText.new(x, y, txt)
	local f = FONTS.default
	FadingText(x - f:getWidth(txt) / 2, y, txt):addElement("L1", "auto_update")
end


return FadingText
