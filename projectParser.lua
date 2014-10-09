#!/usr/bin/lua
-- Codea package (long press+Copy on project then paste into file) unpacker
-- 
-- Use projectParser.lua packageFile
-- produces separate files created from the pakage file

FILENAME=(arg and arg[1]) or "_.gist"

-- iter and tabs functions by juce, Jmv38 and HyroVitalyProtago
local function iter(obj)
    if not obj.name then
        return
    end
    local data = obj.data
    local name, pos = obj.name, obj.pos
    local s, e, next = data:find("\n[-][-]# ([%w_]+)[^\n]*\n.", pos)
    obj.name, obj.pos = next, e
    return name, data:sub(pos, s and s-1 or nil)
end

local function tabs(data)
    local s, e, name = data:find("^%s*[-][-]# ([%w_]+)[^\n]*\n.")
    local obj = {
        pos = e or 1, 
        name = name or "Main",
        data = data,
    }
    return iter, obj
end

function readFileContent(fileName)
    local f = io.open(fileName, "rb")
    if not f then return end
    local content = f:read("*all")
    assert(f:close())
    return content
end

function saveProjectFile(fileName,data)
    print (fileName)
    local f = io.open(fileName..'.lua', "wb")
    f:write(data)
    assert(f:close())
    return content
end

data=readFileContent(FILENAME)

if not data then
	print ("ERROR: Wrong file: "..FILENAME)
	return
end

for fileName,data in tabs(data) do
    saveProjectFile(fileName,data)
end
