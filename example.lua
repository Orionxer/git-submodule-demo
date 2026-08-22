package.path = "./third_party/json.lua/?.lua;" .. package.path

local json = require("json")

local value = {
  project = "git-submodule-demo",
  submodule = "rxi/json.lua",
  version = "v0.1.0"
}

print(json.encode(value))
