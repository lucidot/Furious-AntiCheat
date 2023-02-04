function BanPlayer(src, reason)
    local config = LoadResourceFile(GetCurrentResourceName(), "bans.json")
    local cfg = json.decode(config)
    local ids = ExtractIdentifiers(src);
    local ip = ids.ip;
    local playerSteam = ids.steam;
    local playerLicense = ids.license;
    local playerXbl = ids.xbl;
    local playerLive = ids.live;
    local playerDisc = ids.discord;
    local playerToken = GetPlayerToken(src, 0);
    local banData = {};
    banData['ip'] = "Not Found";
    banData['reason'] = reason;
    banData["img"] = img;
    banData['license'] = "Not Found";
    banData['steam'] = "Not Found";
    banData['xbl'] = "Not Found";
    banData['live'] = "Not Found";
    banData['token'] = "Not Found";
    banData['discord'] = "Not Found";
    if ip ~= nil and ip ~= "nil" and ip ~= "" then 
        banData['ip'] = tostring(ip);
    end
    if not img or img == nil then
        img = screenshotImage
    end
    if playerLicense ~= nil and playerLicense ~= "nil" and playerLicense ~= "" then 
        banData['license'] = tostring(playerLicense);
    end
    if playerSteam ~= nil and playerSteam ~= "nil" and playerSteam ~= "" then 
        banData['steam'] = tostring(playerSteam);
    end
    if playerXbl ~= nil and playerXbl ~= "nil" and playerXbl ~= "" then 
        banData['xbl'] = tostring(playerXbl);
    end
    if playerToken ~= nil and playerToken ~= "nil" and playerToken ~= "" then 
        banData['token'] = tostring(playerToken);
    end
    if playerLive ~= nil and playerLive ~= "nil" and playerLive ~= "" then 
        banData['live'] = tostring(playerXbl);
    end
    if playerDisc ~= nil and playerDisc ~= "nil" and playerDisc ~= "" then 
        banData['discord'] = tostring(playerDisc);
    end
    cfg[tostring(GetPlayerName(src))] = banData;
    SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(cfg, { indent = true }), -1)
    --if FAC.OnPlayerBan.ChatMessage then
   -- TriggerClientEvent('chat:addMessage', -1, {
   -- template = '<div style="padding: 0.3vw; margin: 0.5vw; background-color: rgba(0,0,0,0.5); border-left: 2px solid rgba(0,0,255,0.5); border-right: 2px solid rgba(248,152,8,255); border-top: 2px solid rgba(248,152,8,255) border-bottom: 2px solid rgba(0,0,255,0.5); border-radius: 5px;"><i class="fab fa-discord"></i></i> Furious Anticheat: {0}</div>',
    --args = {"Player ^8 ^7 was permanently banned ^1Reason: "}
   -- })
   -- end
    --if FAC.OnPlayerBan.DiscordLog then
   -- local embed = {
      -- embeds = { 
               -- {
                  --  title = "Player Banned",
                  --  description = "".. GetPlayerName(src) .." Got Beamed! \n\nFurious Anti-Cheat | " .. (os.date("%B %d, %Y at %I:%M %p")),
                   -- color = '15105570'
               -- } 
            --}
        --}
        --PerformHttpRequest(FAC.OnPlayerBan.Webhook, function(err, text, headers) end, 'POST', json.encode(embed), { ['Content-Type'] = 'application/json' })
    --end
end
function isBanned(src)
    local config = LoadResourceFile(GetCurrentResourceName(), "bans.json")
    local cfg = json.decode(config)
    local ids = ExtractIdentifiers(src);
    local playerIP = ids.ip;
    local playerSteam = ids.steam;
    local playerLicense = ids.license;
    local playerXbl = ids.xbl;
    local playerLive = ids.live;
    local playerToken = ids.token;
    local playerDisc = ids.discord;
    for k, v in pairs(cfg) do 
        local reason = v['reason']
        local ip = v['ip']
        local license = v['license']
        local steam = v['steam']
        local xbl = v['xbl']
        local live = v['live']
        local discord = v['discord']
        local token = v['token']
        if tostring(ip) == tostring(playerIP) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(license) == tostring(playerLicense) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(steam) == tostring(playerSteam) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(xbl) == tostring(playerXbl) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(token) == tostring(playerToken) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(live) == tostring(playerLive) then return { ['banID'] = id, ['reason'] = reason } end;
        if tostring(discord) == tostring(playerDisc) then return { ['banID'] = id, ['reason'] = reason } end;
    end
    return false;
end
local function getVPN(name, setKickReason, deferrals)
    local ip = tostring(GetPlayerEndpoint(source))
    deferrals.defer()
    Wait(0)
    PerformHttpRequest(
        "https://blackbox.ipinfo.app/lookup/" .. ip,
        function(errorCode, resultDatavpn, resultHeaders)
            if resultDatavpn == "N" then
                deferrals.done()
            else
                print("^3[^6FuriousAC^3]: ^1 Player " ..name.. " tried to join, but there ip ("..ip..") was detected as a VPN");
                Furious_ac_discordlog(name, Webhooks.VPN, 'Player attempted to connect with a VPN, IP: ``' ..ip..'``', 'VPN Connection')
                if FAC.VPN.Logs.Enabled then
                    Furious_ac_discordlog(name, FAC.VPN.Logs.Webhook, 'Player attempted to connect with a VPN, IP: ``' ..ip..'``', 'VPN Connection')
                end
                deferrals.done("\n[FuriousAC]: Please disable your VPN connection, then reconnect.")
            end
        end
    )
end

function OnPlayerConnecting(name, setKickReason, deferrals)
    deferrals.defer();
    local src = source;
    local banned = false;
    local ban = isBanned(src);
    Citizen.Wait(100);
    if ban then 
        local reason = ban['reason'];
        local printMessage = nil;
        local embed = {
            embeds = { 
                {
                    title = "Player Banned",
                    description = "".. GetPlayerName(src) .." Is a banned player trying to join the server\n\n Reason: ".. reason .." \n\nFurious Anti-Cheat | " .. (os.date("%B %d, %Y at %I:%M %p")),
                    color = '15105570'
                } 
            }
        }
        if FAC.OnBannedPlayerJoin.DiscordLog then
        PerformHttpRequest(FAC.Webhooks.Bans.Webhook, function(err, text, headers) end, 'POST', json.encode(embed), { ['Content-Type'] = 'application/json' })
        end
        if FAC.OnBannedPlayerJoin.ConsolePrint then
        print("^3[FuriousAC] ^3[ALERT]: Player " .. GetPlayerName(src) .. " ("..GetPlayerIdentifier(src)..") tried to join but is banned for: " .. reason);
        end
        Functions.AdaptiveCard(deferrals, src, FAC.Strings['Banned'].title)
        banned = true;
        CancelEvent();
        return;
    end
    if not banned then 
        deferrals.done();
    end
end

Functions = {
    AdaptiveCard = function(card, source, message, message2)
        card = card
    local src = source;
    local selectnumber = math.random(5,40);
    local banned = false;
    local ban = isBanned(src);
    local reason = ban['reason'];
        while GetPlayerName(source) ~= nil do
        card.presentCard({
            ["type"] = "AdaptiveCard",
            ["body"] = {
              {
                type = "TextBlock",
                size = "Medium",
                weight = "Bolder",
                text = message
              },
              {
                type = "ColumnSet",
                columns = {
                  {
                    type = "Column",
                    items = {
                      {
                        type = "Image",
                        size = "Small",
                        url = "https://cdn.discordapp.com/attachments/943030146183614474/970839931251482674/pngletters.png",
                        selectAction = {
                          type = "Action.OpenUrl",
                          url = "discord.gg/furiousac"
                        }
                      }
                    },
                    width = "auto"
                  },
                  {
                    type = "Column",
                    items = {
                      {
                        type = "TextBlock",
                        text = "Furious Anti-Cheat",
                        wrap = true,
                        fontType = "Default",
                        weight = "Bolder"
                      },
                      {
                        type = "TextBlock",
                        spacing = "None",
                        text = "discord.gg/furiousac",
                        wrap = true,
                        isSubtle = true
                      }
                    },
                    width = "stretch"
                  }
                }
              },
              {
                type = "TextBlock",
                text = "You have been banned From ".. FAC.Info.ServerName .. " "   .. reason,
                wrap = true
              },
              {
                type = "Image",
                --size = "Small",
                url = screenshotImg,
              }
            },
            ["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
            ["version"] = "1.3"
          })
          if GetPlayerName(source) == nil then
            break;
          end
          Wait(1000)
        end
    end
}
function ExtractIdentifiers(src)
    local identifiers = {
        steam = "",
        ip = "",
        discord = "",
        license = "",
        xbl = "",
        live = ""
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        elseif string.find(id, "xbl") then
            identifiers.xbl = id
        elseif string.find(id, "live") then
            identifiers.live = id
        end
    end

    return identifiers
end

function matchURL(text_with_URLs)
    
    local domains = [[.ac.ad.ae.aero.af.ag.ai.al.am.an.ao.aq.ar.arpa.as.asia.at.au.aw.ax.az.ba.bb.bd.be.bf.bg.bh.bi.biz.bj.bm.bn.bo.br.bs.bt.bv.bw.by.bz.ca.cat.cc.cd.cf.cg.ch.ci.ck.cl.cm.cn.co.com.coop.cr.cs.cu.cv.cx.cy.cz.dd.de.dj.dk.dm.do.dz.ec.edu.ee.eg.eh.er.es.et.eu.fi.firm.fj.fk.fm.fo.fr.fx.ga.gb.gd.ge.gf.gh.gi.gl.gm.gn.gov.gp.gq.gr.gs.gt.gu.gw.gy.hk.hm.hn.hr.ht.hu.id.ie.il.im.in.info.int.io.iq.ir.is.it.je.jm.jo.jobs.jp.ke.kg.kh.ki.km.kn.kp.kr.kw.ky.kz.la.lb.lc.li.lk.lr.ls.lt.lu.lv.ly.ma.mc.md.me.mg.mh.mil.mk.ml.mm.mn.mo.mobi.mp.mq.mr.ms.mt.mu.museum.mv.mw.mx.my.mz.na.name.nato.nc.ne.net.nf.ng.ni.nl.no.nom.np.nr.nt.nu.nz.om.org.pa.pe.pf.pg.ph.pk.pl.pm.pn.post.pr.pro.ps.pt.pw.py.qa.re.ro.ru.rw.sa.sb.sc.sd.se.sg.sh.si.sj.sk.sl.sm.sn.so.sr.ss.st.store.su.sv.sy.sz.tc.td.tel.tf.tg.th.tj.tk.tl.tm.tn.to.tp.tr.travel.tt.tv.tw.tz.ua.ug.uk.um.us.uy.va.vc.ve.vg.vi.vn.vu.web.wf.ws.xxx.ye.yt.yu.za.zm.zr.zw]]
        
    local tlds = {}
    for tld in domains:gmatch'%w+' do
        tlds[tld] = true
    end
    local function max4(a,b,c,d) return math.max(a+0, b+0, c+0, d+0) end
    local protocols = {[''] = 0, ['http://'] = 0, ['https://'] = 0, ['ftp://'] = 0}
    local finished = {}
    
    for pos_start, url, prot, subd, tld, colon, port, slash, path in
    text_with_URLs:gmatch'()(([%w_.~!*:@&+$/?%%#-]-)(%w[-.%w]*%.)(%w+)(:?)(%d*)(/?)([%w_.~!*:@&+$/?%%#=-]*))'
    do
        if protocols[prot:lower()] == (1 - #slash) * #path and not subd:find'%W%W'
        and (colon == '' or port ~= '' and port + 0 < 65536)
        and (tlds[tld:lower()] or tld:find'^%d+$' and subd:find'^%d+%.%d+%.%d+%.$'
        and max4(tld, subd:match'^(%d+)%.(%d+)%.(%d+)%.$') < 256)
        then
            finished[pos_start] = true
            return url
        end
    end
    
    for pos_start, url, prot, dom, colon, port, slash, path in
    text_with_URLs:gmatch'()((%f[%w]%a+://)(%w[-.%w]*)(:?)(%d*)(/?)([%w_.~!*:@&+$/?%%#=-]*))'
    do
        if not finished[pos_start] and not (dom..'.'):find'%W%W'
        and protocols[prot:lower()] == (1 - #slash) * #path
        and (colon == '' or port ~= '' and port + 0 < 65536)
        then
            return url
        end
    end
end

local screenshots = {}
RegisterServerEvent("TookScreenshot")
AddEventHandler("TookScreenshot", function(result)
    res = matchURL(tostring(result))
    screenshots[source] = res
end)

Furious_ac_discordlog = function(playerId, webhook, logReason, label)
        if FAC.Screenshot.Enabled then
    TriggerClientEvent("Screen", playerId)
    end
    Citizen.Wait(2100)
    
    playerId = tonumber(playerId)
    local name = GetPlayerName(playerId)
    local steamid = "Not Found"
    local license = "Not Found"
    local discord = "Not Found"
    local xbl = "Not Found"
    local liveid = "Not Found"
    local ip = "Not Found"
    screenshotImage = screenshots[playerId]
    
    if name == nil then
        name = "Not Found"
    end

    if label == 'k' then
        label = "Player Kicked"
    elseif label == 'b' then
        label = "Player Banned"
    elseif label == 'vpn' then
        label = "VPN Detected"
    end

    for k, v in pairs(GetPlayerIdentifiers(playerId)) do
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

    local discordInfo = {
        ["author"] = {
            ["name"] = "Furious Anti-Cheat",
            ["url"] = FuriousAC.Website,
            ["icon_url"] = FuriousAC.Logo
        },
        ["color"] = FuriousAC.Color,
        ["title"] = label,
        ["footer"] = {
            ["text"] = "Furious Anti-Cheat | " .. (os.date("%B %d, %Y at %I:%M %p"))
        },
        ["fields"] = {
            {
                ["name"] = "Name",
                ["value"] = name,
                ["inline"] = true
            },
            {
                ["name"] = "Server ID",
                ["value"] = playerId,
                ["inline"] = true
            },
            {
                ["name"] = "Reason",
                ["value"] = logReason,
                ["inline"] = false
            },
            {
                ["name"] = "Identifiers",
                ["value"] = " ".. ipLog .."\n".. steamLog.."\n" .. licenseLog .. "\n" .. xblLog .. "\n" .. discordLog .. "\n" .. liveidLog,
                ["inline"] = false
            }
        },
        ["image"] = {
            ["url"] = screenshotImage
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = 'Furious Anti-Cheat', avatar_url = FuriousAC.Logo, embeds = { discordInfo } }), { ['Content-Type'] = 'application/json' })
end