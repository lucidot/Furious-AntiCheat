local Webhooks = {
    Bans = 'https://discord.com/api/webhooks/960666962244010037/8WjhvjBahpMtIzRpRSEBhMCAgctLRdoH33w1yI_sY42BuJORKFpWqeN7mFq_vfARD__4',
    Kicks = 'https://discord.com/api/webhooks/960666962244010037/8WjhvjBahpMtIzRpRSEBhMCAgctLRdoH33w1yI_sY42BuJORKFpWqeN7mFq_vfARD__4',
    CommandBans = 'https://discord.com/api/webhooks/960666962244010037/8WjhvjBahpMtIzRpRSEBhMCAgctLRdoH33w1yI_sY42BuJORKFpWqeN7mFq_vfARD__4',
    CommandKicks = 'https://discord.com/api/webhooks/960666962244010037/8WjhvjBahpMtIzRpRSEBhMCAgctLRdoH33w1yI_sY42BuJORKFpWqeN7mFq_vfARD__4',
    Unbans = 'https://discord.com/api/webhooks/960666962244010037/8WjhvjBahpMtIzRpRSEBhMCAgctLRdoH33w1yI_sY42BuJORKFpWqeN7mFq_vfARD__4',
    Screenshots = 'https://discord.com/api/webhooks/959269211748839514/YIVKQ_uPlXS8R9MR0Q8hmRjDn6yZrl0M0uzUpBl5nINzK1IPzGvoNAEd8gpexpCbgRDD',
}
Explosions = {}

FuriousAC = {
    Website = 'https://furiousanticheat.com',
    Logo = 'https://cdn.discordapp.com/attachments/968784069334818816/969437667764867142/swifteyepng.png',
    Color = '2303786'
}

--ESX = nil
--TriggerEvent(FAC.ESX.Object, function(obj) ESX = obj end)

CreateThread(function()
    TriggerClientEvent('Furious_ac:client:weaponblacklist', -1, FAC.Weapons)
end)

RegisterServerEvent('Furious_ac:server:weaponblacklist')
AddEventHandler('Furious_ac:server:weaponblacklist', function()
    local src = source

    TriggerClientEvent('Furious_ac:client:weaponblacklist', src, FAC.Weapons)
end)

RegisterNetEvent('Furious_ac:server:ban-player')
AddEventHandler('Furious_ac:server:ban-player',function(src, type, logReason)
    local reason = 'Cheating'
    if type == BlacklistedWeapon then
        reason = FAC.Strings['Reasons'].BlacklistedWeapon
    elseif type == DamageMultiplier then
        reason = FAC.Strings['Reasons'].DamageMultiplier
    elseif type == MaxAmmo then
        reason = FAC.Strings['Reasons'].MaxAmmo
    local src = source
    BanPlayer(src, reason)
    Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logReason, 'b')
    Furious_ac_discordlog(src, Webhooks.Bans, logReason, 'b')
    Wait(1000)
    DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
   end
end)

RegisterNetEvent('Furious_ac:server:kick-player')
AddEventHandler('Furious_ac:server:kick-player',function(src, type, logReason, label)
    local reason = 'Cheating'
    if type == BlacklistedWeapon then
        reason = FAC.Strings['Reasons'].BlacklistedWeapon
    elseif type == DamageMultiplier then
        reason = FAC.Strings['Reasons'].DamageMultiplier
    elseif type == MaxAmmo then
        reason = FAC.Strings['Reasons'].MaxAmmo
    end
    local src = source
    Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logReason, label)
    Furious_ac_discordlog(src, Webhooks.Kicks, logReason, label)
    Wait(1000)
    DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
end)

RegisterCommand(FAC.Commands.WipeCommand, function(source, args, raw)
   local src = source;
    if IsPlayerAceAllowed(src, "fac.wipe") or IsPlayerAceAllowed(src, "fac.bypass") then 
      if args[1] == "1" then
        TriggerClientEvent("dsh8uf82j82ej8dsj8fj8j2jfjsjd8jf89j2e8jjdfsjfdsjidjsioj:objd8usd88fudsudfs8uds8uwip3d89fjgfd09j", -1)
          TriggerClientEvent("chat:addMessage", source, {args = { "^3[FuriousAC]^7 ^2[SUCCESS]^7: You wiped all Props"}})
            elseif args[1] == "2" then
                TriggerClientEvent("Furious:PedWipe", -1)
                  TriggerClientEvent("chat:addMessage", source, {args = { "^3[FuriousAC]^7 ^2[SUCCESS]^7: You wiped all Peds"}})
                elseif args[1] == "3" then
                    TriggerClientEvent("Furious:VehicleWipe", -1)
                    TriggerClientEvent("chat:addMessage", source, {args = { "^3[FuriousAC]^7 ^2[SUCCESS]^7: You wiped all unoccupied Vehicles"}})
                elseif args[1] == "4" then
                    TriggerClientEvent("Furious:EntityWipe", -1)
                    TriggerClientEvent("chat:addMessage", source, {args = { "^3[FuriousAC]^7 ^2[SUCCESS]^7: You wiped all Entities"}})
                elseif args[1] == nil then
                    TriggerClientEvent("chat:addMessage", source, {args = { "^3[FuriousAC]^7 ^3[ERROR]^7: Please provide a Option (1-4)"}})
                else
                    TriggerClientEvent("chat:addMessage", source, {args = { "^3[FuriousAC]^7 ^3[ERROR]^7: Please provide a Option (1-4)"}})
                end
            else
        TriggerClientEvent("chat:addMessage", source, {args = { "^3[FuriousAC]^7 ^3[ERROR]^7: Insufficient Permissions!"}})
    end
end) 

RegisterCommand(FAC.Commands.KickCommand, function(source, args, raw)
    local src = source;
    if IsPlayerAceAllowed(src, "fac.kick") or IsPlayerAceAllowed(src, "fac.bypass") then
        if #args < 2 then 
            TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^1Please enter a ID of a player in-game to kick.\n^3 /kick [id] [reason]'); 
            return;
        end
        local id = args[1]
        if ExtractIdentifiers(args[1]) ~= nil then 
            local ids = ExtractIdentifiers(id);
            local steam = ids.steam;
            local gameLicense = ids.license;
            local discord = ids.discord;
            local xbox = ids.xbl;
            local live = ids.live;
            local targetip = ids.ip;
            local reason = table.concat(args, ' '):gsub(args[1] .. " ", "");
            for k, v in pairs(GetPlayerIdentifiers(source)) do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then
                    steamid = v
                elseif string.sub(v, 1, string.len("license:")) == "license:" then
                    license = v
                elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                    xbl = v
                elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                    ip = string.sub(v, 4)
                elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                    discordid = string.sub(v, 9)
                    discord = "<@" .. discordid .. ">"
                elseif string.sub(v, 1, string.len("live:")) == "live:" then
                    liveid = v
                end
            end
            local ipLog = ""
            local steamLog = ""
            local licenseLog = ""
            local xblLog = ""
            local discordLog = ""
            local liveidLog = ""
            if FAC.Webhooks.Identifiers.IPAddress then
                ipLog = "IP Address: ||" .. ip .. "||"
            else
                ipLog = ""
            end
            if FAC.Webhooks.Identifiers.Steam then
                steamLog = "Steam: " .. steamid
            else
                steamLog = ""
            end
            if FAC.Webhooks.Identifiers.License then
                licenseLog = "License: " .. license
            else
                licenseLog = ""
            end
            if FAC.Webhooks.Identifiers.Xbox then
                xblLog = "Xbox: " .. xbl
            else
                xblLog = ""
            end
            if FAC.Webhooks.Identifiers.Live then
                liveidLog = "Live: " .. liveid
            else
                liveidLog = ""
            end
            if FAC.Webhooks.Identifiers.Discord then
                discordLog = "Discord: " .. discord
            else
                discordLog = ""
            end
            local playerName = GetPlayerName(id)
            local bannerName = GetPlayerName(source)
            playerId = tonumber(source)
            local discordInfo = {
                ["author"] = {
                    ["name"] = "Furious Anti-Cheat",
                    ["url"] = FuriousAC.Website,
                    ["icon_url"] = FuriousAC.Logo
                },
                ["color"] = FuriousAC.Color,
                ["title"] = 'Staff Kicked A Player',
                ["footer"] = {
                    ["text"] = "Furious Anti-Cheat | " .. (os.date("%B %d, %Y at %I:%M %p"))
                },
                ["fields"] = {
                    {
                        ["name"] = "Player Kicked",
                        ["value"] = 'Name: '..playerName.. '\nServer ID : ' ..id,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Identifiers",
                        ["value"] = "Steam Hex: "..steam.."\nLicense: " .. gameLicense .. "\nXbox: " .. xbox .. "\nDiscord: " .. discord .. "\nLive: " .. live,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Kicked By",
                        ["value"] = 'Name: '..bannerName.. '\nServer ID : ' ..playerId,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Identifiers",
                        ["value"] = " ".. ipLog .."\n".. steamLog.."\n" .. licenseLog .. "\n" .. xblLog .. "\n" .. discord .. "\n" .. liveidLog,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Reason",
                        ["value"] = reason,
                        ["inline"] = false
                    },
                }
            }
            PerformHttpRequest(Webhooks.Kicks, function(err, text, headers) end, 'POST', json.encode({ username = 'Furious Anti-Cheat', avatar_url = FuriousAC.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
            if FAC.Webhooks.Kicks.Enabled then
                PerformHttpRequest(FAC.Webhooks.Kicks.Webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Furious Anti-Cheat', avatar_url = FuriousAC.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
            end
            DropPlayer(id, "[FuriousAC]: " ..FAC.Strings['Kicked'].title.. " \nKicked By: " .. GetPlayerName(src) .. "\nReason: " .. reason);
        else 
            TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^1Please enter a valid ID of a player in-game to kick.\n^3 /kick [id] [reason]'); 
        end
    else
        TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^1You are not allowed to kick players!'); 
    end
end)
RegisterCommand(FAC.Commands.BanCommand, function(source, args, raw)
    local src = source;
    if IsPlayerAceAllowed(src, "fac.ban") or IsPlayerAceAllowed(src, "fac.bypass") then
        if #args < 2 then 
            TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^1Please enter a ID of a player in-game to ban.\n^3 /ban [id] [reason]'); 
            return;
        end
        local id = args[1]
        if ExtractIdentifiers(args[1]) ~= nil then 
            local ids = ExtractIdentifiers(id);
            local steam = ids.steam;
            local gameLicense = ids.license;
            local discord = ids.discord;
            local xbox = ids.xbl;
            local live = ids.live;
            local targetip = ids.ip;
            local reason = table.concat(args, ' '):gsub(args[1] .. " ", "");
            BanPlayer(args[1], reason);
            for k, v in pairs(GetPlayerIdentifiers(source)) do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then
                    steamid = v
                elseif string.sub(v, 1, string.len("license:")) == "license:" then
                    license = v
                elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                    xbl = v
                elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                    ip = string.sub(v, 4)
                elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                    discordid = string.sub(v, 9)
                    discord = "<@" .. discordid .. ">"
                elseif string.sub(v, 1, string.len("live:")) == "live:" then
                    liveid = v
                end
            end
            local ipLog = ""
            local steamLog = ""
            local licenseLog = ""
            local xblLog = ""
            local discordLog = ""
            local liveidLog = ""
            if FAC.Webhooks.Identifiers.IPAddress then
                ipLog = "IP Address: ||" .. ip .. "||"
            else
                ipLog = ""
            end
            if FAC.Webhooks.Identifiers.Steam then
                steamLog = "Steam: " .. steamid
            else
                steamLog = ""
            end
            if FAC.Webhooks.Identifiers.License then
                licenseLog = "License: " .. license
            else
                licenseLog = ""
            end
            if FAC.Webhooks.Identifiers.Xbox then
                xblLog = "Xbox: " .. xbl
            else
                xblLog = ""
            end
            if FAC.Webhooks.Identifiers.Live then
                liveidLog = "Live: " .. liveid
            else
                liveidLog = ""
            end
            if FAC.Webhooks.Identifiers.Discord then
                discordLog = "Discord: " .. discord
            else
                discordLog = ""
            end
            local playerName = GetPlayerName(id)
            local bannerName = GetPlayerName(source)
            playerId = tonumber(source)
            local discordInfo = {
                ["author"] = {
                    ["name"] = "Furious Anti-Cheat",
                    ["url"] = FuriousAC.Website,
                    ["icon_url"] = FuriousAC.Logo
                },
                ["color"] = FuriousAC.Color,
                ["title"] = 'Staff Banned A Player',
                ["footer"] = {
                    ["text"] = "Furious Anti-Cheat | " .. (os.date("%B %d, %Y at %I:%M %p"))
                },
                ["fields"] = {
                    {
                        ["name"] = "Player Banned",
                        ["value"] = 'Name: '..playerName.. '\nServer ID : ' ..id,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Identifiers",
                        ["value"] = "Steam Hex: "..steam.."\nLicense: " .. gameLicense .. "\nXbox: " .. xbox .. "\nDiscord: " .. discord .. "\nLive: " .. live,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Banned By",
                        ["value"] = 'Name: '..bannerName.. '\nServer ID : ' ..playerId,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Identifiers",
                        ["value"] = " ".. ipLog .."\n".. steamLog.."\n" .. licenseLog .. "\n" .. xblLog .. "\n" .. discord .. "\n" .. liveidLog,
                        ["inline"] = false
                    },
                    {
                        ["name"] = "Reason",
                        ["value"] = reason,
                        ["inline"] = false
                    },
                }
            }
            PerformHttpRequest(Webhooks.Bans, function(err, text, headers) end, 'POST', json.encode({ username = 'Furious Anti-Cheat', avatar_url = FuriousAC.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
            if FAC.Webhooks.Bans.Enabled then
                PerformHttpRequest(FAC.Webhooks.Bans.Webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Furious Anti-Cheat', avatar_url = FuriousAC.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
            end
            DropPlayer(id, "[FuriousAC]: " ..FAC.Strings['Banned'].title.. " \nBanned By: " .. GetPlayerName(src) .. "\nReason: " .. reason);
        else 
            TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^1Please enter a valid ID of a player in-game to ban.\n^3 /ban [id] [reason]'); 
        end
    else
        TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^1You are not allowed to ban players!'); 
    end
end)
RegisterCommand(FAC.Commands.UnbanCommand, function(src, args)
    local config = LoadResourceFile(GetCurrentResourceName(), "bans.json")
    local cfg = {}
    cfg = json.decode(config)
    if (src <= 0) then
        if #args == 0 then 
            print('^3[^3FuriousAC^3]: ^3Please enter a identifier of a banned player to unban.'); 
            return; 
        end
        local target = args[1]
        if target ~= nil then
            for k, v in pairs(cfg) do 
                local steamid = v['steam'];
                local discordid = v['discord'];
                local xblid = v['xbl'];
                local licenseid = v['license'];
                local liveid = v['live'];
                local ipid = v['ip'];
                if target == steamid or target == discordid or target == xblid or target == licenseid or target == liveid or target == ipid then
                    local name = k;
                    cfg[k] = nil;
                    SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(cfg, { indent = true }), -1)
                    print('^3[^3FuriousAC^3]: ^3 the identifier has successfully been unbanned!'); 
                    return name;
                else
                    print('^3[^3FuriousAC^3]: ^3That identifier wasen\'t found inside of the ban list!'); 
                end
            end
        end
        return;
    end 
    if IsPlayerAceAllowed(src, "fac.unban") or IsPlayerAceAllowed(src, "fac.bypass") then
        if #args < 1 then 
            TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^1Please enter a identifier of a banned player to unban.\n^3 /unban [identifier]'); 
            return;
        end
        local target = args[1]
        for k, v in pairs(cfg) do 
            local steamid = v['steam'];
            local discordid = v['discord'];
            local xblid = v['xbl'];
            local licenseid = v['license'];
            local liveid = v['live'];
            local ipid = v['ip'];
            if target == steamid or target == discordid or target == xblid or target == licenseid or target == liveid or target == ipid then
                local name = k;
                cfg[k] = nil;
                SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(cfg, { indent = true }), -1)
                TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^2' ..target.. ' has successfully been unbanned!'); 
                return name;
            else
                TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^1That identifier wasen\'t found inside of the ban list!'); 
            end
        end
    else
        TriggerClientEvent('chatMessage', src, '^3[^3FuriousAC^3]: ^1You are not allowed to unban players!'); 
    end
end)

AddEventHandler("playerConnecting", OnPlayerConnecting)

RegisterNetEvent("Furious_ac:client:spectatedplayer")
AddEventHandler("Furious_ac:client:spectatedplayer", function(logreason)
    local src = source
    if FAC.Spectate.Enabled and not IsPlayerAceAllowed(source, "fac.spectate") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Spectate
        if FAC.Spectate.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried Spectating another Player', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'Player tried Spectating another Player', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Spectate.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried Spectating another Player', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried Spectating another Player', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:resourcestop")
AddEventHandler("Furious_ac:client:resourcestop", function(logreason)
    local src = source
    if FAC.Resource.Enabled and not IsPlayerAceAllowed(source, "fac.resourcestop") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].ResourceStop
        if FAC.Resource.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried to stop a Resource', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player tried to stop a Resource', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Resource.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried to stop a Resource', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried to stop a Resource', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:ragdoll")
AddEventHandler("Furious_ac:client:ragdoll", function(logreason)
    local src = source
    if FAC.Ragdoll.Enabled and not IsPlayerAceAllowed(source, "fac.ragdoll") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Ragdoll
        if FAC.Ragdoll.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried turing Anti Ragdoll on', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'Player tried turing Anti Ragdoll on', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Ragdoll.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried turing Anti Ragdoll on', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried turing Anti Ragdoll on', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

AddEventHandler("clearPedTasksEvent", function(sender, source, data)
    if FAC.ClearPedTasks.Enabled and not IsPlayerAceAllowed(source, "fac.clearpedtasks") and not IsPlayerAceAllowed(source, "fac.bypass") then
        local src = sender
            local reason = FAC.Strings['Reasons'].ClearPedTasks
            local logreason = 'Player tried to kick another player out there car / cleared ped tasks'
            if FAC.ClearPedTasks.Punishment == 'ban' then 
                Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'b')
                if FAC.Webhooks.Bans.Enabled then
                    Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
                end
                BanPlayer(src, reason)
                DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.ClearPedTasks.Punishment == 'kick' then
                Furious_ac_discordlog(src, Webhooks.Kicks, logreason, 'b')
                if FAC.Webhooks.Kicks.Enabled then
                    Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logreason, 'b')
                end
                DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        end
    end
end)

AddEventHandler("ptFxEvent", function(sender, data)
    if FAC.PTFX.Enabled and not IsPlayerAceAllowed(source, "fac.ptfx") and not IsPlayerAceAllowed(source, "fac.bypass") then
        local src = sender
            local reason = FAC.Strings['Reasons'].PTFX
            local logreason = 'Player tried to send PTFX'
            if FAC.PTFX.Punishment == 'ban' then
                Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'b')
                if FAC.Webhooks.Bans.Enabled then
                    Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
                end
                BanPlayer(src, reason)
                DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.PTFX.Punishment == 'kick' then
                Furious_ac_discordlog(src, Webhooks.Kicks, logreason, 'b')
                if FAC.Webhooks.Kicks.Enabled then
                    Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logreason, 'b')
                end
                DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        end
    end
end)

AddEventHandler("giveWeaponEvent", function(sender, data)
    if data.givenAsPickup == false then
    local src = source
    if FAC.GiveWeapon.Enabled and not IsPlayerAceAllowed(source, "fac.giveweapon") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].GiveWeapon
        if FAC.GiveWeapon.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried giving a gun to another player', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans,'Player tried giving a gun to another player', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.GiveWeapon.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried giving a gun to another player', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried giving a gun to another player', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p"))) 
          end
       end
    end
end)

AddEventHandler("RemoveWeaponEvent", function(sender, data)
    local src = source
    if FAC.RemoveWeapon.Enabled and not IsPlayerAceAllowed(source, "fac.removeweapon") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].RemoveWeapon
        if FAC.RemoveWeapon.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried removing a gun from another player', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'Player tried removing a gun from another player', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.RemoveWeapon.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried removing a gun from another player', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried removing a gun from another player', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

AddEventHandler("RemoveAllWeaponsEvent", function(sender, data)
    local src = source
    if FAC.RemoveWeapon.Enabled and not IsPlayerAceAllowed(source, "fac.removeweapon") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].RemoveWeapon
        if FAC.RemoveWeapon.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried removing a gun from another player', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'Player tried removing a gun from another player', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.RemoveWeapon.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried removing a gun from another player', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried removing a gun from another player', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:invisable")
AddEventHandler("Furious_ac:client:invisable", function(logreason)
    local src = source
    if FAC.Invisibility.Enabled and not IsPlayerAceAllowed(source, "fac.invisibility") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Invisibility
        if FAC.Invisibility.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player turned Invisibility on', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans,'Player turned Invisibility on', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Invisibility.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player turned Invisibility on', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player turned Invisibility on', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:godmode")
AddEventHandler("Furious_ac:client:godmode", function(logreason)
    local src = source
    if FAC.AntiGodmode.Enabled and not IsPlayerAceAllowed(source, "fac.godmode") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Godmode
        if FAC.AntiGodmode.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player turned Godmode on', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player turned Godmode on', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.AntiGodmode.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player turned Godmode on', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player turned Godmode on', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:nightvision")
AddEventHandler("Furious_ac:client:nightvision", function(logreason)
    local src = source
    if FAC.Nightvision.Enabled and not IsPlayerAceAllowed(source, "fac.nightvision") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Nightvision
        if FAC.Nightvision.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried using Nightvision', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player tried using Nightvision', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Nightvision.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried using Nightvision', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried using Nightvision', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:heatvision")
AddEventHandler("Furious_ac:client:heatvision", function(logreason)
    local src = source
    if FAC.Heatvision.Enabled and not IsPlayerAceAllowed(source, "fac.heatvision") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Heatvision
        if FAC.Heatvision.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried using Heatvision', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player tried using Heatvision', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Heatvision.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried using Heatvision', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried using Heatvision', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:aimbot")
AddEventHandler("Furious_ac:client:aimbot", function(logreason)
    local src = source
    if FAC.Aimbot.Enabled and not IsPlayerAceAllowed(source, "fac.aimbot") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Aimbot
        if FAC.Aimbot.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player was using Aimbot', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player was using Aimbot', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Aimbot.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player was using Aimbot', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player was using Aimbot', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:teleport")
AddEventHandler("Furious_ac:client:teleport", function(logreason)
    local src = source
    if FAC.Teleport.Enabled and not IsPlayerAceAllowed(source, "fac.teleport") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Teleport
        if FAC.Teleport.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried teleporting', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player tried teleporting', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Teleport.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried teleporting', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried teleporting', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:freecam")
AddEventHandler("Furious_ac:client:freecam", function(logreason)
    local src = source
    if FAC.Freecam.Enabled and not IsPlayerAceAllowed(source, "fac.freecam") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Freecam
        if FAC.Freecam.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Freecam Detected', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Freecam Detected', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Freecam.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Freecam Detected', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Freecam Detected', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
   playerName = (string.gsub(string.gsub(string.gsub(playerName,  "-", ""), ",", ""), " ", ""):lower())
    for k, v in pairs(FAC.Names.Blacklisted) do
      local g, f = playerName:find(string.lower(v))
      if g or f then
       if FAC.Names.Enabled and not IsPlayerAceAllowed(source, "fac.names") and not IsPlayerAceAllowed(source, "fac.bypass") then
         setKickReason('Your In Game Name is Blacklisted. Please Change Your Name.')
        CancelEvent()
      end
    end
  end
end)

RegisterNetEvent("Furious_ac:client:smallped")
AddEventHandler("Furious_ac:client:smallped", function(logreason)
    local src = source
    if FAC.ShrinkPed.Enabled and not IsPlayerAceAllowed(source, "fac.shrinkped") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].ShrinkPed
        if FAC.ShrinkPed.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Shrink Ped Detected', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Shrink Ped Detected', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.ShrinkPed.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Shrink Ped Detected', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Shrink Ped Detected', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            end
            end
            if FAC.OnPlayerBan.DiscordLog then
            local reason = FAC.Strings['Reasons'].ShrinkPed
            local embed = {
            embeds = { 
                {
                    title = "Player Banned",
                    description = "".. GetPlayerName(src) .." Got Beamed for " ..reason.. " \n\nFurious Anti-Cheat | " .. (os.date("%B %d, %Y at %I:%M %p")),
                    color = '15105570'
                   } 
               }
          }
          PerformHttpRequest(FAC.OnPlayerBan.Webhook, function(err, text, headers) end, 'POST', json.encode(embed), { ['Content-Type'] = 'application/json' })
    end
end)

RegisterNetEvent("Furious_ac:client:vehiclegodmode")
AddEventHandler("Furious_ac:client:vehiclegodmode", function(logreason)
    local src = source
    if FAC.VehicleGodmode.Enabled and not IsPlayerAceAllowed(source, "fac.vehiclegodmode") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].VehicleGodmode
        if FAC.VehicleGodmode.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Vehicle Godmode Detected', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Vehicle Godmode Detected', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.VehicleGodmode.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Vehicle Godmode Detected', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Vehicle Godmode Detected', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:vehiclespeed")
AddEventHandler("Furious_ac:client:vehiclespeed", function(logreason)
    local src = source
    if FAC.VehicleSpeed.Enabled and not IsPlayerAceAllowed(source, "fac.vehiclespeed") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].VehicleSpeed
        if FAC.VehicleSpeed.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Vehicle Speed Multi Detected', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Vehicle Speed Multi Detected', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.VehicleSpeed.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Vehicle Speed Multi Detected', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Vehicle Speed Multi Detected', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
       end
    end
end)

RegisterNetEvent("Furious_ac:client:onscreenkeyboard")
AddEventHandler("Furious_ac:client:onscreenkeyboard", function(logreason)
    local src = source
    if FAC.OnScreenKeyboard.Enabled and not IsPlayerAceAllowed(source, "fac.onscreenkeyboard") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].OnScreenKeyboard
        if FAC.OnScreenKeyboard.Punishment == 'ban' then
                    TriggerClientEvent("Screen", src)
                Wait(2100)
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player was using a On Screen Keyboard', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player was using a On Screen Keyboard', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.OnScreenKeyboard.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player was using a On Screen Keyboard', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player was using a On Screen Keyboard', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        end
    end
end)

RegisterNetEvent("Furious_ac:client:luamenudetection")
AddEventHandler("Furious_ac:client:luamenudetection", function(logreason)
    local src = source
    if FAC.MenuInjection.Enabled and not IsPlayerAceAllowed(source, "fac.menudetection") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].MenuInjection
        if FAC.MenuInjection.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'LUA Mod Menu Injection Detected', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'LUA Mod Menu Injection Detected', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.MenuInjection.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'LUA Mod Menu Injection Detected', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'LUA Mod Menu Injection Detected', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        end
    end
end)

RegisterNetEvent("Furious_ac:client:noclip")
AddEventHandler("Furious_ac:client:noclip", function(logreason)
    local src = source
    if FAC.Noclip.Enabled and not IsPlayerAceAllowed(source, "fac.noclip") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Noclip
        if FAC.Noclip.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Noclip Detected', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Noclip Detected', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        elseif FAC.Noclip.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Noclip Detected', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Noclip Detected', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        end
    end
end)


RegisterNetEvent("Furious_ac:server:radar")
AddEventHandler("Furious_ac:server:radar", function()
    local src = source
    if not IsPlayerAceAllowed(source, "fac.radar") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Radar
        local logreason = 'Player tried to enable the radar/minimap'
        if FAC.Radar.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        elseif FAC.Radar.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logreason, 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, logreason, 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        end
    end
end)

RegisterNetEvent("Furious_ac:client:blacklistedkeys-ban")
AddEventHandler("Furious_ac:client:blacklistedkeys-ban", function(logreason)
    local src = source
    if not IsPlayerAceAllowed(source, "fac.blacklistedkeys") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].BlacklistedKey
        BanPlayer(src, reason)
        if FAC.Webhooks.Bans.Enabled then
            Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
        end
        Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'b')
        DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
    end
end)

RegisterNetEvent("Furious_ac:client:blacklistedkeys-kick")
AddEventHandler("Furious_ac:client:blacklistedkeys-kick", function(logreason)
    local src = source
    if not IsPlayerAceAllowed(source, "fac.blacklistedkeys") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        if FAC.Webhooks.Kicks.Enabled then
            Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logreason, 'k')
        end
        Furious_ac_discordlog(src, Webhooks.Kicks, logreason, 'k')
        DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
    end
end)

RegisterNetEvent("Furious_ac:client:blips")
AddEventHandler("Furious_ac:client:blips", function(reason)
    local src = source
    if FAC.Blips.Enabled and not IsPlayerAceAllowed(source, "fac.blips") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Blips
        if FAC.Blips.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried to enable player blips', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player tried to enable player blips', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        elseif FAC.Blips.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried to enable player blips', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried to enable player blips', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
        end
    end
end)

if FAC.Chat.FakeChatMessages.Enabled then
    local function OnFakeChat(src, name, data)
        local playername = GetPlayerName(src)
        local reason = FAC.Strings['Reasons'].FakeChat
        local logreason = 'Player attempted to say something as a different player'
        if name ~= playername then
            CancelEvent()
            if FAC.Chat.FakeChatMessages.Punishment == 'ban' then
                BanPlayer(src, reason)
                if FAC.Webhooks.Bans.Enabled then
                    Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
                end
                Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'b')
                DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif not FAC.Chat.FakeChatMessages.Kick then
                if FAC.Webhooks.Kicks.Enabled then
                    Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logreason, 'k')
                end
                Furious_ac_discordlog(src, Webhooks.Kicks, logreason, 'k')
                DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            end
        end
    end
end

AddEventHandler('weaponDamageEvent', function(sender, data)
    if data.weaponType == 911657153 or data.weaponType == GetHashKey("WEAPON_STUNGUN") then
    local src = source
    if FAC.Tazers.Enabled and not IsPlayerAceAllowed(source, "fac.tazers") and not IsPlayerAceAllowed(source, "fac.bypass") then 
        local reason = FAC.Strings['Reasons'].Tazers
        if FAC.Tazers.Punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player tried tazing another player', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player tried tazing another player', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Tazers.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player tried tazing another player', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player tried tazing another player', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
         end
       end
    end
end)

for k, v in pairs(FAC.Triggers.Triggers) do
        RegisterServerEvent(k)
        AddEventHandler(k, function()
        CancelEvent() 
        local src = source
        local reason = FAC.Strings['Reasons'].BlacklistedTrigger
        local logreason = 'Player tried triggering the Blacklisted Trigger : ``' ..k..'``'
        if FAC.Triggers.Enabled and not IsPlayerAceAllowed(source, "fac.triggers") and not IsPlayerAceAllowed(source, "fac.bypass") then
        if v.punishment == 'ban' then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, logreason, logreason, 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif v.punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logreason, 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, logreason, 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            end
        end
    end)
end
local function OnBlacklistedWord(source, name, data)
    local src = source
    local reason = FAC.Strings['Reasons'].BlacklistedWord
    local illegal = false
    for k, v in pairs(FAC.Chat.BlacklistedWords) do
            local logreason;
            if string.match(data:lower(), k:lower()) then
                illegal = true
                logreason = 'Player has tried used the Blacklisted Word: ``' ..k.. '``'
            end
            if illegal and not IsPlayerAceAllowed(source, "fac.words") and not IsPlayerAceAllowed(source, "fac.bypass") then
                if v.punishment == 'ban' then
                    BanPlayer(src, reason)
                    if FAC.Webhooks.Bans.Enabled then
                        Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
                    end
                    Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'b')
                    DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
                    break;
                elseif v.punishment == 'kick' then
                    if FAC.Webhooks.Kicks.Enabled then
                        Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logreason, 'k')
                    end
                    Furious_ac_discordlog(src, Webhooks.Kicks, logreason, 'k')
                    DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
               break;
            end
        end 
    end
end
AddEventHandler("chatMessage", OnBlacklistedWord)

AddEventHandler('entityCreating', function(entity)
        for k, v in pairs(FAC.Objects) do
        local src = NetworkGetEntityOwner(entity)
	local model = GetEntityModel(entity)
        local amount = GetEntityPopulationType(entity)
        local objs = GetHashKey(k)
        if src == nil then
          CancelEvent()
          DeleteEntity(entity)
        elseif amount == v.spawnlimit then
          CancelEvent()
        end
        if model == objs then
        CancelEvent()
        DeleteEntity(entity)
               local logreason = 'Tried spawning the blacklisted Object: ``' ..k.. '``'
            if not IsPlayerAceAllowed(source, "fac.objects") and not IsPlayerAceAllowed(source, "fac.bypass") then 
            local reason = FAC.Strings['Reasons'].Object
                if v.punishment == 'ban' then
                    BanPlayer(src, reason)
                if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
                    end
                    Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'b')
                   DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
                 elseif v.punishment == 'kick' then
                    if FAC.Webhooks.Kicks.Enabled then
                        Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logreason, 'k')
                    end
                    Furious_ac_discordlog(src, Webhooks.Kicks, logreason, 'k')
                end
                DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
                elseif v.punishment == 'none' then
                DeleteEntity(entity)
             end
         end
     end
end)

vehCreator = {}
pedCreator = {}
propCreator = {}
AddEventHandler('entityCreating', function(entity)
        for k, v in pairs(FAC.Objects) do
        local src = NetworkGetEntityOwner(entity)
	local model = GetEntityModel(entity)
        local amount = GetEntityPopulationType(entity)
        local objs = GetHashKey(k)
        if src == nil then
          CancelEvent()
          DeleteEntity(entity)
        elseif amount == v.spawnlimit then
          CancelEvent()
        end
        if model == objs then
        CancelEvent()
        DeleteEntity(entity)
                local logreason = '``Tried spawning a blacklisted Object, Object: '..v.label..' hash: ' ..model..'``'
            if not IsPlayerAceAllowed(source, "fac.objects") and not IsPlayerAceAllowed(source, "fac.bypass") then 
            local reason = FAC.Strings['Reasons'].Object
                if v.punishment == 'ban' then
                    BanPlayer(src, reason)
                if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
                    end
                    Furious_ac_discordlog(src, Webhooks.Bans, logreason, 'b')
                   DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
                 elseif v.punishment == 'kick' then
                    if FAC.Webhooks.Kicks.Enabled then
                        Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, logreason, 'k')
                    end
                    Furious_ac_discordlog(src, Webhooks.Kicks, logreason, 'k')
                end
                DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
             end
         end
     end
end)

AddEventHandler("entityCreating", function(entity)
     if DoesEntityExist(entity) then
     local src = NetworkGetEntityOwner(entity)
     local model = GetEntityModel(entity)
      local eType = GetEntityPopulationType(entity) 
      if src == nil then
         CancelEvent()
          end
      if eType == 0 then
        CancelEvent()
          end
           if GetEntityType(entity) == 2 then
            if eType == 6 or eType == 7 or eType == 0 then
             vehCreator[src] = (vehCreator[src] or 0) + 1
             if vehCreator[src] > FAC.MaxVehicles.Amount then
              CancelEvent()    
              DeleteEntity(entity)
             end
          end
       end
    end
      if GetEntityType(entity) == 1 then
       if eType == 6 or eType == 7 or eType == 0 then
        pedCreator[src] = (pedCreator[src] or 0) + 1
         if pedCreator[src] > FAC.MaxPeds.Amount then
           CancelEvent()    
          end
       end
    end
       if GetEntityType(entity) == 3 then
         if eType == 6 or eType == 7 then
          propCreator[src] = (propCreator[src] or 0) + 1
           if propCreator[src] > FAC.MaxProps.Amount then
           CancelEvent()    
          end
       end
    end
end)

function Furious_BanPlayer(source, reason, logreason)
    local src = source;
    if src ~= nil then
        BanPlayer(src, reason)
        if FAC.Webhooks.Bans.Enabled then
            Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, logreason, 'b')
        end;
        DropPlayer(src, reason)
    end;
end

AddEventHandler("explosionEvent", function(source, exp)
    local src = source;
    local reason = FAC.Strings['Reasons'].Explosion
    if src == nil then return end; 
    if src ~= nil and not IsPlayerAceAllowed(src, 'fac.explosions') and not IsPlayerAceAllowed(source, "fac.bypass") then 
        for k, v in pairs(FAC.Explosions) do
            if tonumber(k) == exp.explosionType then
            BanPlayer(src, reason)
            if FAC.Webhooks.Bans.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Bans.Webhook, 'Player Caused A Malicious Explosion', 'b')
            end
            Furious_ac_discordlog(src, Webhooks.Bans, 'Player Caused A Malicious Explosion', 'b')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Banned'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Banned'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            elseif FAC.Explosions.Punishment == 'kick' then
            if FAC.Webhooks.Kicks.Enabled then
                Furious_ac_discordlog(src, FAC.Webhooks.Kicks.Webhook, 'Player Caused A Malicious Explosion', 'k')
            end
            Furious_ac_discordlog(src, Webhooks.Kicks, 'Player Caused A Malicious Explosion', 'k')
            DropPlayer(src, '[FuriousAC]: ' ..FAC.Strings['Kicked'].title.. "\nReason: " ..reason.. "\n " ..FAC.Strings['Kicked'].text.. "\n" ..(os.date("%B %d, %Y at %I:%M %p")))
            end;
        end;
    end;
end)

Citizen.CreateThread(function()
    AntiCheatStartUp()
end)
function shutdownserver()
        Wait(1000)
        print("^3[FuriousAC] ^3[ALERT]^7: Please visit https://discord.gg/furiousac for support.")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 10 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 9 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 8 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 7 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 6 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 5 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 4 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 3 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 2 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down in 1 Seconds")
        Wait(1000)
        print("^3[FuriousAC] ^3[ERROR]^7: Shutting down")
        Wait(1000)
        os.exit()
    end
    function IncorrectResourceName()
        print("^3[FuriousAC] ^3[ERROR]^7: The resource Can\'t be Named: ^3"..GetCurrentResourceName().."")
        Wait(2000)
        shutdownserver()
    end
function AntiCheatStartUp()  
        Wait(1000)
        if LoadResourceFile(GetCurrentResourceName(), "client/client.lua") then
        print("^3[FuriousAC]^0: ^3 Client Side LOADED!^0")
        else
        print("^1[FuriousAC]^0: ^1 Client Side FAILED TO LOAD!^0")
        Wait(2000)
        shutdownserver()
        end
        Wait(1000)
        if LoadResourceFile(GetCurrentResourceName(), "server/server.lua") then
        print("^3[FuriousAC]^0: ^3 Server Side LOADED!^0")
        else
        print("^1[FuriousAC]^0: ^1 Server Side FAILED TO LOAD!^0")
        Wait(2000)
        shutdownserver()
        end
        Wait(1000)
        if LoadResourceFile(GetCurrentResourceName(), "config.lua") then
        print("^3[FuriousAC]^0: ^3 Config LOADED!^0")
        else
        print("^1[FuriousAC]^0: ^1 Config FAILED TO LOAD!^0")
        Wait(2000)
        shutdownserver()
        end
        Wait(1000)
        if LoadResourceFile(GetCurrentResourceName(), "bans.json") then
        print("^3[FuriousAC]^0: ^3 Banlist LOADED!^0")
        else
        print("^1[FuriousAC]^0: ^1 Banlist FAILED TO LOAD!^0")
        Wait(2000)
        shutdownserver()
        end
        Wait(2000)
    if GetCurrentResourceName() == "F.AC" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "F_AC" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "F-AC" then
        IncorrectResourceName()
    --elseif GetCurrentResourceName() == "FAC" then
        --IncorrectResourceName()
    elseif GetCurrentResourceName() == "FuriousAC" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "Furious-AC" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "fac.AC" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "Furious_AC" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "Furious" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "AntiCheat" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "AC" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "Anti-Cheat" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "Anti_Cheat" then
        IncorrectResourceName()
    elseif GetCurrentResourceName() == "Anti.Cheat" then
        IncorrectResourceName()
    end 
    print([[
   ^3 ________  ______  ________  __  _______
   ^3/ ____/ / / / __ \/  _/ __ \/ / / / ___/
  ^3/ /_  / / / / /_/ // // / / / / / /\__ \ 
 ^3/ __/ / /_/ / _, _// // /_/ / /_/ /___/ /
^3/_/    \____/_/ |_/___/\____/\____//____/                                                             
                    ]])
end