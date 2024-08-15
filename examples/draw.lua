local vector = require("vector")
local vector2 = vector.vector2

local newV2 = vector2.new(5,15)
local anotherV2 = vector2.new(10,20)

vector.draw({
    width = 512,
    height = 512,
    {
        vector = newV2,
        color = {255, 0, 0, 255},
    },
    {
        vector = anotherV2,
        color = {0, 255, 0, 255},
    },
},"myVector.png")
