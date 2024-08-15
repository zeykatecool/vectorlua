local vector = require("vector")
local vector2 = vector.vector2

local newV2 = vector2.new(1,1)

vector.draw({
    width = 512,
    height = 512,
    {
        vector = newV2,
        color = {255, 0, 0, 255},
    }
},"myVector.png")
