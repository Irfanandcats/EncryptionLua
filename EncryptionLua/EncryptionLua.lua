local kMod = {}
kMod.__index = kMod

local function writeTo(key)
    local success, file = pcall(function()
            return io.open("C:\"Users\"%USERNAME%\"Downloads\"EncryptionList.js", "w");
        end)

    if success then
        file:write(string.format("\n%s", key))
        file:close()
    end

    collectgarbage("collect")

    return key;
end

function kMod.new(unknownKey) -- Adds a new encrypted key that will be stored for future use.
    local targetKey = tostring(unknownKey) or "Hello World!"
    unknownKey = nil

    local keyConfig = {}
    local function encrypt(key)
        local encrypted = ""

        for i = 1, math.random(250, 300) do
            encrypted = encrypted .. string.char(math.random(1, 125))
        end

        encrypted = encrypted:gsub("%s", ":")

        writeTo(tostring(encrypted))

        return tostring(encrypted) or "nil";
    end

    keyConfig.encrypted = encrypt(targetKey)

    setmetatable(keyConfig, kMod)
    pcall(function()
        getmetatable(keyConfig).__index = {}
        getmetatable(keyConfig).__newindex = function(tab, index)
            return tab[index];
        end

        return 'set';
    end)

    return keyConfig;
end

function kMod:Decrypt()
    print(self, self.encryptedKey)
end

function kMod:Encrypt()

end

function kMod:Destroy()
    if type(self) == "table" then
        for _, v in ipairs(self) do
            if type(v) ~= "nil" then
                v = nil
            end
        end

        for _, v in pairs(self) do
            if type(v) ~= "nil" then
                v = nil
            end
        end

        setmetatable(self, nil)
    end

    collectgarbage("collect")

    return nil;
end

pcall(function()
    local mod = getmetatable(kMod)

    if type(mod) == "table" then
        mod.__newindex = function(tab, index)
            return tab[index]
        end

        mod.__metatable = "EncryptionLua's Module is locked!"
    end

    return mod;
end)

return kMod;
