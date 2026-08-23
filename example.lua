package.path = "./json.lua/?.lua;" .. package.path

local json = require("json")

local value = {
  submodule = "rxi/json.lua",
  path = "json.lua",
  version = "v0.1.0"
}

print(json.encode(value))
