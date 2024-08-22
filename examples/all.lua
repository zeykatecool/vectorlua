local vector = require("vector")
local vector2 = vector.vector2
local vector3 = vector.vector3

local newV3 = vector3.new(1,1,1)
local newV2 = vector2.new(1,1)

--[[
    Vector3:
    v:normalize()
    v:dot(Vector)
    v:cross(Vector)
    v:angleBetween(Vector)
    v:length()
    v:lerp(Vector, t)
    v:reflect(Vector)
    v:project(Vector)
    v:rotate(angle, axis)
    v:interpolate(Vector,t)
    v:distance(Vector)

    Vector2:
    v:normalize()
    v:dot(Vector)
    v:length()
    v:angleBetween(Vector)
    v:lerp(Vector, t)
    v:reflect(Vector)
    v:project(Vector)
    v:rotate(angle)
    v:interpolate(Vector,t)
    v:distance(Vector)
]]
