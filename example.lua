local function run(command)
  local process = assert(io.popen(command))
  local output = process:read("*a"):gsub("%s+$", "")
  local succeeded = process:close()

  if not succeeded or output == "" then
    return nil
  end

  return output
end

local function shell_quote(text)
  return "'" .. text:gsub("'", "'\\''") .. "'"
end

local path_entry = assert(
  run("git config -f .gitmodules --get-regexp '^submodule\\..*\\.path$'"),
  "没有在 .gitmodules 中找到子仓库"
)

local path_key, path = path_entry:match("^(%S+)%s+([^\n]+)")
local section = assert(path_key:match("^submodule%.(.+)%.path$"))
local url_key = "submodule." .. section .. ".url"
local url = assert(run("git config -f .gitmodules --get " .. shell_quote(url_key)))
local submodule = url:gsub("%.git$", ""):match("github%.com[:/](.+)$") or url
local quoted_path = shell_quote(path)
local version = run("git -C " .. quoted_path .. " describe --tags --exact-match 2>/dev/null")
  or assert(run("git -C " .. quoted_path .. " rev-parse --short HEAD"))

package.path = "./" .. path .. "/?.lua;" .. package.path
local json = require("json")

local value = {
  submodule = submodule,
  path = path,
  version = version
}

print(json.encode(value))
