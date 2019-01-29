local Class = require 'extra_libs.hump.class'
local Color = require "classes.color.color"
local POS   = require 'classes.primitives.pos'

local SENSITIVITY = 2

local function up(self)
    if self.cursor.y < O_WIN_H then self.cursor.y = self.cursor.y - SENSITIVITY end
end

local function down(self)
    if self.cursor.y > 0 then self.cursor.y = self.cursor.y + SENSITIVITY end
end

local function left(self)
    if self.cursor.x > 0 then self.cursor.x = self.cursor.x - SENSITIVITY end
end

local function right(self)
    if self.cursor.x < O_WIN_W then self.cursor.x = self.cursor.x + SENSITIVITY end
end

local Eye = Class{
    __includes = {POS},
    init = function(self, p)
        POS.init(self, 0, 0)
        self.cursor = {x=O_WIN_W/2, y=O_WIN_H/2}
        self.p = p

        -- Player 0 has control of the character movement (WASD).
        -- Player 1 has control of left eye (JIKL). Player 2 has control of right eye (arrow keys).
        -- Player 1 shoots with backspace. Player 2 shoots with enter.
        self.map = {
            {'j', 'i', 'k', 'l', 'backspace'},
            {'left', 'up', 'down', 'right', 'return'},
            {left, up, down, right}
        }

        self.color = {Color.green(), Color.blue()}

        -- Crosshair properties
        self.ch_size = 10
        self.ch_thick = 3
    end
}

function Eye:update_pos(x, y)
    self.pos.x, self.pos.y = x, y
end

function Eye:shoot()

    print("Player "..self.p..
        " does a Pew! from position ["..self.pos.x..", "..self.pos.y.."] to position "..
        "["..self.cursor.x..", "..self.cursor.y.."]")
end

function Eye:update(dt)
    local keyPress = love.keyboard.isDown
    for i=1,4 do
        if keyPress(self.map[self.p][i]) then self.map[3][i](self) end
    end
end

function Eye:draw()
    local def_thick = love.graphics.getLineWidth()
    love.graphics.setLineWidth(self.ch_thick)
    Color.set(self.color[self.p])
    love.graphics.line(self.cursor.x, self.cursor.y-self.ch_size, self.cursor.x, self.cursor.y+self.ch_size)
    love.graphics.line(self.cursor.x-self.ch_size, self.cursor.y, self.cursor.x+self.ch_size, self.cursor.y)
    love.graphics.setLineWidth(def_thick)
    love.graphics.circle('fill', self.pos.x, self.pos.y, 2)
end

function Eye:keypressed(key, scode, isrepeat)
    if key == self.map[self.p][5] then self:shoot() end
end

function Eye.new(p)
    return Eye(p)
end

return Eye
