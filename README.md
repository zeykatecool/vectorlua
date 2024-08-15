# vectorlua
- Vector3 and Vector2 support for Lua.
- This module makes Vector process so much easier.

# Features
- You can draw your `Vector2`'s to png file.So you can compare them easily. (not `Vector3`) (requires `bit` package.It's embedded package in LuaJIT.)
- Metatable functions for all Vectors : `add`,`sub`,`mul`,`unm`,`div`,`tostring`.
> Example:
```lua
local vector = require("vector")
print(tostring(vector.vector2.new(2,2)+vector.vector2.new(1,6)))
--> prints: Vector2(3,8).
```

# Known Problems
- Drawing functions slows down when resulation is greater than (512x512).

# Examples
- You can check [examples](https://github.com/zeykatecool/vectorlua/blob/main/examples) folder for all examples.
