local DataSerializer = require("Utils.Lua-Serializer.DataSerializer")
local ArgumentBuilder = require("Utils.Lua-Serializer.ArgumentBuilder")
local Server = require("Server") -- obviously youd need to do this over http requests

local function Encrypt(Data)
    return Data -- would be encrypted with private key
end

local function Decrypt(Data)
    return Data
end

Server.Handshake() -- would be pub key transfer

local RequestExpected = { Url = {Type = "string"}, Method = {Type = "string"}, Body = {Type = "string"}, Headers = {Type = "table"}}
local RequestArgs = ArgumentBuilder.BuildArguments({Expected = RequestExpected, TypeCheck = true, SetDefaults = false})
local NewRequest = function(...)
    local Args = RequestArgs(...)

    local Serialized = DataSerializer.SerializeTable{Value = Args}
    local Encrypted = Encrypt(Serialized)
    local Result = Server.Request(Encrypted)
    local Decrypted = Decrypt(Result)
    return Decrypted
end

local Result = NewRequest({
    Url = "https://www.google.com",
    Method = "GET",
    Body = "",
    Headers = {example = "value"}
})

for i,v in pairs(Result) do
    print(i, v)
end

