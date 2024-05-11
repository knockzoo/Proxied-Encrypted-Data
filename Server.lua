local function Encrypt(Data)
    return Data
end

local function Decrypt(Data)
    return Data
end

local function httprequest(Args)
    return {
        StatusCode = 200,
        Body = "Hello, world!"
    }
end

return {
    Handshake = function() end,
    Request = function(Args)
        local Decrypted = Decrypt(Args)
        print(Decrypted)
        local Deserialized = load("return " .. Decrypted)() -- assuming it was serialized to a table, which it was | do NOT do this on your server

        local Result = httprequest(Deserialized)
        return Result
    end
}