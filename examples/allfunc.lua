local vector = require("vector")
local v1 = vector.vector2.new(3, 4)
local v2 = vector.vector2.new(1, 2)
print(v1:dot(v2))

local v1 = vector.vector2.new(3, 4)
local v1_normalized = v1:normalize()
print(v1_normalized)

local v1 = vector.vector2.new(3, 4)
print(v1:length())

local v1 = vector.vector2.new(1, 0)
local v2 = vector.vector2.new(0, 1)
print(v1:angleBetween(v2))

local v1 = vector.vector2.new(0, 0)
local v2 = vector.vector2.new(10, 10)
local result = v1:lerp(v2, 0.5)
print(result)

local v1 = vector.vector2.new(1, 1)
local normal = vector.vector2.new(0, 1)
local reflected = v1:reflect(normal)
print(reflected)

local v1 = vector.vector2.new(1, 0)
local rotated = v1:rotate(math.pi / 2)
print(rotated)

local v1 = vector.vector2.new(1, 1)
local v2 = vector.vector2.new(1, 0)
local projection = v1:project(v2)
print(projection)

local v1 = vector.vector3.new(1, 2, 3)
print(v1)

--[[
Note:
    Vector3 functions are same as vector2.Only some functions LIKE (vector):rotate() and (vector):cross() is different.
]]

local v1 = vector.vector3.new(1, 2, 3)
local v2 = vector.vector3.new(4, 5, 6)
local cross = v1:cross(v2)
print(cross)
