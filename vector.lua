local vector = {
    vector2 = {},
    vector3 = {},
}
vector.__index = vector
if math.atan then
    math.atan2 = math.atan
end
local function expect(t, n, or_n)
    local t_type = type(t)
    if t_type == "table" then
        t_type = t.type or t_type
    end
    if t_type ~= n then
        local errMsg = "expected " .. n .. " but got " .. tostring(t_type)
        if or_n and t_type ~= or_n then
            errMsg = "expected " .. or_n .. " but got " .. tostring(t_type)
        end
        error(errMsg .. "\n" .. debug.traceback(), 2)
    end
end
function vector.vector2.new(x, y)
    expect(x, "number")
    expect(y, "number")
    local t = setmetatable({x=x, y=y, type="vector2"}, vector.vector2)
    function t:normalize()
        local length = vector.length(self)
        if length == 0 then
            return vector.vector2.new(0, 0)
        end
        return vector.vector2.new(self.x / length, self.y / length)
    end

    function t:dot(Vector)
        expect(Vector, "vector2")
        return self.x * Vector.x + self.y * Vector.y
    end

    function t:length()
        return math.sqrt(self.x^2 + self.y^2)
    end

    function t:angleBetween(Vector)
        expect(Vector, "vector2")
        return math.atan2(self.y, self.x) - math.atan2(Vector.y, Vector.x)
    end

    function t:lerp (Vector, ts)
        return vector.lerp(self, Vector, ts)
    end
    function t:reflect(Vector)
        expect(Vector, "vector2")
        return vector.vector2.new(
            self.x - 2 * self:dot(Vector) * Vector.x,
            self.y - 2 * self:dot(Vector) * Vector.y
        )
    end

    function t:rotate(angle)
        return vector.rotate(self, angle)
    end

    function t:project(Vector)
        expect(Vector, "vector2")
        return vector.project(self, Vector)
    end

    function t:scale(s)
        return vector.scale(self, s)
    end

    function t:interpolate(Vector2, ts)
        return vector.interpolate(self, Vector2, ts)
    end
    
    return t
end

function vector.vector2:__add(Vector)
    expect(Vector, "vector2")
    return vector.vector2.new(self.x + Vector.x, self.y + Vector.y)
end

function vector.vector2:__sub(Vector)
    expect(Vector, "vector2")
    return vector.vector2.new(self.x - Vector.x, self.y - Vector.y)
end

function vector.vector2:__mul(s)
    if type(s) == "number" then
        return vector.vector2.new(self.x * s, self.y * s)
    elseif type(s) == "table" then
        expect(s, "vector2")
        return vector.vector2.new(self.x * s.x, self.y * s.y)
    end
end

function vector.vector2:__unm()
    return vector.vector2.new(-self.x, -self.y)
end

function vector.vector2:__div(s)
    if type(s) == "number" then
        return vector.vector2.new(self.x / s, self.y / s)
    elseif type(s) == "table" then
        expect(s, "vector2")
        return vector.vector2.new(self.x / s.x, self.y / s.y)
    end
end

function vector.vector2:__eq(Vector)
    expect(Vector, "vector2")
    return self.x == Vector.x and self.y == Vector.y
end

function vector.vector2:__lt(Vector)
    expect(Vector, "vector2")
    return self.x < Vector.x and self.y < Vector.y
end

function vector.vector2:__le(Vector)
    expect(Vector, "vector2")
    return self.x <= Vector.x and self.y <= Vector.y
end
function vector.vector2:__tostring()
    return "Vector2(" .. self.x .. "," .. self.y .. ")"
end
function vector.vector3.new(x, y, z)
    expect(x, "number")
    expect(y, "number")
    expect(z, "number")
    local t = setmetatable({x=x, y=y, z=z, type="vector3"}, vector.vector3)
    function t:normalize()
        local length = vector.length(self)
        if length == 0 then
            return vector.vector3.new(0, 0, 0)
        end
        return vector.vector3.new(self.x / length, self.y / length, self.z / length)
    end

    function t:dot(Vector)
        expect(Vector, "vector3")
        return self.x * Vector.x + self.y * Vector.y + self.z * Vector.z
    end

    function t:cross(Vector)
        expect(Vector, "vector3")
        return vector.vector3.new(
            self.y * Vector.z - self.z * Vector.y,
            self.z * Vector.x - self.x * Vector.z,
            self.x * Vector.y - self.y * Vector.x
        )
    end

    function t:angleBetween(Vector)
        expect(Vector, "vector3")
        return math.atan2(self.y, self.x) - math.atan2(Vector.y, Vector.x)
    end

    function t:length()
        return math.sqrt(self.x^2 + self.y^2 + self.z^2)
    end

    function t:lerp(Vector, ts)
        expect(Vector, "vector3")
        expect(t, "number")
        return vector.lerp(self, Vector, ts)
    end

    function t:reflect(Vector)
        expect(Vector, "vector3")
        return vector.vector3.new(
            self.x - 2 * self:dot(Vector) * Vector.x,
            self.y - 2 * self:dot(Vector) * Vector.y,
            self.z - 2 * self:dot(Vector) * Vector.z
        )
    end

    function t:rotate(angle, axis)
        return vector.rotate(self, angle, axis)
    end

    function t:scale(s)
        return vector.scale(self, s)
    end

    function t:interpolate(Vector3, ts)
        return vector.interpolate(self, Vector3, ts)
    end

    function t:project(Vector)
        expect(Vector, "vector3")
        return vector.project(self, Vector)
    end
    return t
end

function vector.vector3:__add(Vector)
    expect(Vector, "vector3")
    return vector.vector3.new(self.x + Vector.x, self.y + Vector.y, self.z + Vector.z)
end

function vector.vector3:__sub(Vector)
    expect(Vector, "vector3")
    return vector.vector3.new(self.x - Vector.x, self.y - Vector.y, self.z - Vector.z)
end
function vector.vector3:__tostring()
    return "Vector3(" .. self.x .. "," .. self.y .. "," .. self.z .. ")"
end
function vector.vector3:__mul(s)
    if type(s) == "number" then
        return vector.vector3.new(self.x * s, self.y * s, self.z * s)
    elseif type(s) == "table" then
        expect(s, "vector3")
        return vector.vector3.new(self.x * s.x, self.y * s.y, self.z * s.z)
    end
end

function vector.vector3:__eq(Vector)
    expect(Vector, "vector3")
    return self.x == Vector.x and self.y == Vector.y and self.z == Vector.z
end

function vector.vector3:__lt(Vector)
    expect(Vector, "vector3")
    return self.x < Vector.x and self.y < Vector.y and self.z < Vector.z
end

function vector.vector3:__le(Vector)
    expect(Vector, "vector3")
    return self.x <= Vector.x and self.y <= Vector.y and self.z <= Vector.z
end
function vector.vector3:__unm()
    return vector.vector3.new(-self.x, -self.y, -self.z)
end

function vector.vector3:__div(s)
    if type(s) == "number" then
        return vector.vector3.new(self.x / s, self.y / s, self.z / s)
    elseif type(s) == "table" then
        expect(s, "vector3")
        return vector.vector3.new(self.x / s.x, self.y / s.y, self.z / s.z)
    end
end


function vector.rotate(Vector, angle, axis)
    expect(Vector, "vector2", "vector3")
    expect(angle, "number")
    if Vector.type == "vector2" then
        local cosTheta = math.cos(angle)
        local sinTheta = math.sin(angle)
        return vector.vector2.new(
            Vector.x * cosTheta - Vector.y * sinTheta,
            Vector.x * sinTheta + Vector.y * cosTheta
        )
    elseif Vector.type == "vector3" then
        local cosTheta = math.cos(angle)
        local sinTheta = math.sin(angle)
        local x, y, z = Vector.x, Vector.y, Vector.z

        if axis == "x" then
            return vector.vector3.new(
                x,
                y * cosTheta - z * sinTheta,
                y * sinTheta + z * cosTheta
            )
        elseif axis == "y" then
            return vector.vector3.new(
                x * cosTheta + z * sinTheta,
                y,
                -x * sinTheta + z * cosTheta
            )
        elseif axis == "z" then
            return vector.vector3.new(
                x * cosTheta - y * sinTheta,
                x * sinTheta + y * cosTheta,
                z
            )
        else
            error("unknown axis '"..axis.."'")
        end
    end
end

function vector.project(Vector1, Vector2)
    expect(Vector1, "vector2", "vector3")
    expect(Vector2, "vector2", "vector3")

    if Vector1.type ~= Vector2.type then
        error("trying to project '"..Vector1.type.."' and '"..Vector2.type.."' together")
    end

    local dotProd = vector.dot(Vector1, Vector2)
    local lengthSquared = vector.dot(Vector2, Vector2)

    if lengthSquared == 0 then
        error("trying to project zero-length vector")
    end

    local scale = dotProd / lengthSquared

    if Vector1.type == "vector2" then
        return vector.vector2.new(Vector2.x * scale, Vector2.y * scale)
    elseif Vector1.type == "vector3" then
        return vector.vector3.new(Vector2.x * scale, Vector2.y * scale, Vector2.z * scale)
    end
end
function vector.scale(Vector, s)
    expect(Vector,"vector2","vector3")
    expect(s,"number")
    if Vector.type == "vector2" then
        return vector.vector2.new(Vector.x * s, Vector.y * s)
    elseif Vector.type == "vector3" then
        return vector.vector3.new(Vector.x * s, Vector.y * s, Vector.z * s)
    end
end
function vector.length(Vector)
    expect(Vector,"vector2","vector3")
    if Vector.type == "vector2" then
        return math.sqrt(Vector.x^2 + Vector.y^2)
    elseif Vector.type == "vector3" then
        return math.sqrt(Vector.x^2 + Vector.y^2 + Vector.z^2)
    end
end

function vector.normalize(Vector)
    expect(Vector,"vector2","vector3")
    if Vector.type == "vector2" then
        local length = vector.length(Vector)
        if length == 0 then
            return vector.vector2.new(0,0)
        end
        return vector.vector2.new(Vector.x/length, Vector.y/length)
    elseif Vector.type == "vector3" then
        local length = vector.length(Vector)
        if length == 0 then
            return vector.vector3.new(0,0,0)
        end
        return vector.vector3.new(Vector.x/length, Vector.y/length, Vector.z/length)
    end
end

function vector.add(Vector1, Vector2)
    expect(Vector1,"vector2","vector3")
    expect(Vector2,"vector2","vector3")
    if Vector1.type == "vector2" and Vector2.type == "vector2" then
        return vector.vector2.new(Vector1.x + Vector2.x, Vector1.y + Vector2.y)
    elseif Vector1.type == "vector3" and Vector2.type == "vector3" then
        return vector.vector3.new(Vector1.x + Vector2.x, Vector1.y + Vector2.y, Vector1.z + Vector2.z)
    end
    error("trying to add '"..Vector1.type.."' and '"..Vector2.type.."' together")
end

function vector.sub(Vector1, Vector2)
    expect(Vector1,"vector2","vector3")
    expect(Vector2,"vector2","vector3")
    if Vector1.type == "vector2" and Vector2.type == "vector2" then
        return vector.vector2.new(Vector1.x - Vector2.x, Vector1.y - Vector2.y)
    elseif Vector1.type == "vector3" and Vector2.type == "vector3" then
        return vector.vector3.new(Vector1.x - Vector2.x, Vector1.y - Vector2.y, Vector1.z - Vector2.z)
    end
    error("trying to subtract '"..Vector1.type.."' and '"..Vector2.type.."' together")
end



function vector.dot(Vector1, Vector2)
    expect(Vector1, "vector2", "vector3")
    expect(Vector2, "vector2", "vector3")
    if Vector1.type == "vector2" and Vector2.type == "vector2" then
        return Vector1.x * Vector2.x + Vector1.y * Vector2.y
    elseif Vector1.type == "vector3" and Vector2.type == "vector3" then
        return Vector1.x * Vector2.x + Vector1.y * Vector2.y + Vector1.z * Vector2.z
    end
    error("trying to dot '"..Vector1.type.."' and '"..Vector2.type.."' together")
end

function vector.cross(Vector1, Vector2)
    expect(Vector1, "vector3")
    expect(Vector2, "vector3")
    return vector.vector3.new(
        Vector1.y * Vector2.z - Vector1.z * Vector2.y,
        Vector1.z * Vector2.x - Vector1.x * Vector2.z,
        Vector1.x * Vector2.y - Vector1.y * Vector2.x
    )
end


function vector.lerp(Vector1, Vector2, t)
    expect(Vector1, "vector2", "vector3")
    expect(Vector2, "vector2", "vector3")
    expect(t, "number")
    if Vector1.type ~= Vector2.type then
        error("trying to lerp '"..Vector1.type.."' and '"..Vector2.type.."'")
    end

    local oneMinusT = 1 - t
    local scaledV1 = vector.scale(Vector1, oneMinusT)

    local scaledV2 = vector.scale(Vector2, t)

    return vector.add(scaledV1, scaledV2)
end
function vector.angleBetween(Vector1, Vector2)
    expect(Vector1, "vector2", "vector3")
    expect(Vector2, "vector2", "vector3")
    local dotProd = vector.dot(Vector1, Vector2)
    local length1 = vector.length(Vector1)
    local length2 = vector.length(Vector2)

    if Vector1.type ~= Vector2.type then
        error("trying to compare angle between '"..Vector1.type.."' and '"..Vector2.type.."'")
    end

    if length1 == 0 or length2 == 0 then
        error("trying to compete angle with zero-length vector")
    end
    local cosTheta = dotProd / (length1 * length2)
    cosTheta = math.max(-1, math.min(1, cosTheta))
    return math.acos(cosTheta)
end

function vector.average(vectors)
    expect(vectors, "table")
    local sum = vectors[1]
    local sumtype = vectors[1].type
    for k,v in pairs(vectors) do
        if v.type ~= sumtype then
            error("trying to average vectors of different types")
        end
    end
    for i = 2, #vectors do
        sum = vector.add(sum, vectors[i])
    end
    return vector.scale(sum, 1 / #vectors)
end

function vector.distance(Vector1, Vector2)
    expect(Vector1, "vector2", "vector3")
    expect(Vector2, "vector2", "vector3")
    if Vector1.type ~= Vector2.type then
        error("trying to compare distance between '"..Vector1.type.."' and '"..Vector2.type.."'")
    end
    return vector.length(vector.sub(Vector1, Vector2))
end

function vector.interpolate(Vector1, Vector2, t)
    expect(Vector1, "vector2", "vector3")
    expect(Vector2, "vector2", "vector3")
    expect(t, "number")
    if Vector1.type ~= Vector2.type then
        error("trying to interpolate '"..Vector1.type.."' and '"..Vector2.type.."'")
    end
    return vector.lerp(Vector1, Vector2, t)
end

function vector.reflect(Vector, normal)
    expect(Vector, "vector2", "vector3")
    expect(normal, "vector2", "vector3")
    if Vector.type ~= normal.type then
        error("trying to reflect '"..Vector.type.."' with '"..normal.type.."'")
    end
    return vector.sub(Vector, vector.scale(normal, 2 * vector.dot(Vector, normal)))
end



local function drawLine(colorMap, width, startX, startY, endX, endY, color)
    local dx = math.abs(endX - startX)
    local dy = math.abs(endY - startY)
    local sx = startX < endX and 1 or -1
    local sy = startY < endY and 1 or -1
    local err = dx - dy
    while true do
        local idx = (startY * width + startX) * 4
        if idx > 0 and idx <= #colorMap - 3 then
            colorMap[idx + 1] = color[1]
            colorMap[idx + 2] = color[2]
            colorMap[idx + 3] = color[3]
            colorMap[idx + 4] = color[4]
        end

        if startX == endX and startY == endY then
            break
        end

        local e2 = 2 * err
        if e2 > -dy then
            err = err - dy
            startX = startX + sx
        end
        if e2 < dx then
            err = err + dx
            startY = startY + sy
        end
    end
end

local function drawVectors(width, height, vectors, colors)
    local colorMap = {}
    for i = 1, width * height * 4 do
        colorMap[i] = 255
    end

    local axisColor = {0, 0, 0, 255}
    for x = 0, width - 1 do
        local idx = (height / 2 * width + x) * 4
        colorMap[idx + 1] = axisColor[1]
        colorMap[idx + 2] = axisColor[2]
        colorMap[idx + 3] = axisColor[3]
        colorMap[idx + 4] = axisColor[4]
    end

    for y = 0, height - 1 do
        local idx = (y * width + width / 2) * 4
        colorMap[idx + 1] = axisColor[1]
        colorMap[idx + 2] = axisColor[2]
        colorMap[idx + 3] = axisColor[3]
        colorMap[idx + 4] = axisColor[4]
    end
    for i, v in ipairs(vectors) do
        local startX = math.floor(width / 2)
        local startY = math.floor(height / 2)
        local endX = math.floor(startX + v.x * (width / 4))
        local endY = math.floor(startY - v.y * (height / 4))
        local color = colors[i]
        drawLine(colorMap, width, startX, startY, endX, endY, color)
    end

    return colorMap
end
function vector.draw(VectorDraw_Table, filename)
    expect(VectorDraw_Table, "table")
    expect(filename, "string")
    local colors = {}
    local vectors = {}
    for k,v in pairs(VectorDraw_Table) do
        if k ~= "width" and k ~= "height" then
        expect(v.vector, "vector2")
        expect(v.color, "table")
        table.insert(vectors, v.vector)
        table.insert(colors, v.color or {0, 0, 0, 255})
        end
    end
    local width, height = VectorDraw_Table.width, VectorDraw_Table.height

        if width > 512 or height > 512 then
            print("warning: making width or height greater than 512 may cause performance issues.")
        end

    local png = require("pngencoder")
    local colorMap = drawVectors(width, height, vectors, colors)
    local image = png(width, height, "rgba")
    image:write(colorMap)
    local f = io.open(filename, "wb") or error("Failed to create PNG file")
    f:write(table.concat(image.output))
    f:close()
    return filename
end

return vector
