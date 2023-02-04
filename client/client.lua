local FAC_weaponblacklist = {}

CreateThread(function()
    TriggerServerEvent('Furious_ac:server:weaponblacklist')
    TriggerServerEvent("Furious_ac:server:isEnabled")
end)

RegisterNetEvent('Furious_ac:client:weaponblacklist')
AddEventHandler('Furious_ac:client:weaponblacklist', function(list)
    FAC_weaponblacklist = list
end)

RegisterNetEvent("Screen")
AddEventHandler("Screen", function(toggle, url, field)
       print('ScreenShot Taken Say Cheese') exports["screenshot-basic"]:requestScreenshotUpload("https://discord.com/api/webhooks/959269211748839514/YIVKQ_uPlXS8R9MR0Q8hmRjDn6yZrl0M0uzUpBl5nINzK1IPzGvoNAEd8gpexpCbgRDD", 'files[]', function(data)
            TriggerServerEvent("TookScreenshot", data)
        end)
    end) 

CreateThread(function(model, src, type, logReason, label)
        while true do
            local ped = PlayerPedId()
            for k, v in pairs(FAC_weaponblacklist) do 
                local weapon = GetHashKey(k)
                if HasPedGotWeapon(ped, weapon, false) then
                    local ammo = GetMaxAmmoInClip(ped, k, 1)
                    local damage = GetWeaponDamage(k)
                    local blacklisted = true
                    local weaponName = v.label
                    -- [Ammo Check]
                    if ammo > v.maxAmmo then
                        if v.punishment == 'ban' then
                        RemoveWeaponFromPed(ped, weapon)
                        TriggerServerEvent('Furious_ac:server:ban-player', 'a', MaxAmmo, 'Modified ammo capacity. The allowed value is ``'..v.maxAmmo..'``, there\'s was: ``' ..ammo..'``', 'b')
                        elseif v.punishment == 'kick' then
                        RemoveWeaponFromPed(ped, weapon)
                        TriggerServerEvent('Furious_ac:server:kick-player', 'a', MaxAmmo, 'Modified ammo capacity. The allowed value is ``'..v.maxAmmo..'``, there\'s was: ``' ..ammo..'``', 'k')
                        elseif v.punishment == 'none' then
                            RemoveWeaponFromPed(ped, weapon)
                        end
                    elseif damage > v.damageMultiplier then
                        if v.punishment == 'ban' then
                            RemoveWeaponFromPed(ped, weapon)
                            TriggerServerEvent('Furious_ac:server:ban-player', 'a', DamageMultiplier, 'Modified damage multiplier. The allowed value is ``'..v.damageMultiplier..'``, there\'s was: ``' ..damage..'``', 'b')
                        elseif v.punishment == 'kick' then
                            RemoveWeaponFromPed(ped, weapon)
                            TriggerServerEvent('Furious_ac:server:kick-player', 'a', DamageMultiplier, 'Modified damage multiplier. The allowed value is ``'..v.damageMultiplier..'``, there\'s was: ``' ..damage..'``', 'k')
                        elseif v.punishment == 'none' then
                            RemoveWeaponFromPed(ped, weapon)
                        end  
                    elseif v.blacklisted == true then
                        if v.punishment == 'ban' then
                            RemoveWeaponFromPed(ped, weapon)
                            TriggerServerEvent('Furious_ac:server:ban-player', 'a', BlacklistedWeapon, 'Player had a blacklisted weapon. Player Had: ``'..weaponName..'``', 'b')
                        elseif v.punishment == 'kick' then
                            RemoveWeaponFromPed(ped, weapon)
                            TriggerServerEvent('Furious_ac:server:kick-player', 'a', BlacklistedWeapon, 'Player had a blacklisted weapon. Player Had: ``'..weaponName..'``', 'k')
                        elseif v.punishment == 'none' then
                            RemoveWeaponFromPed(ped, weapon)
                        end
                    end
                end
            end
            local BlipAmount = 0;
            BlipAmount = GetNumberOfActiveBlips()
            local ActivePlayers = #GetActivePlayers()
	    if BlipAmount == ActivePlayers then
	    TriggerServerEvent("Furious_ac:client:blips");
            end
            Wait(4000)
         end
    end)

    if blacklistedKeysEnabled then
        CreateThread(function()
            while (true) do
                for k, v in pairs(blacklistedKeys) do
                    local pressed = IsControlPressed(0, k)
                    if pressed then
                        if v.punishment == 'ban' then
                            TriggerServerEvent('Furious_ac:client:blacklistedkeys-ban', 'Player attempted to press blacklisted key, key: ' ..v.label)
                        elseif v.punishment == 'kick' then
                            TriggerServerEvent('Furious_ac:client:blacklistedkeys-kick', 'Player attempted to press blacklisted key, key: ' ..v.label)
                        end
                    end
                end
                Wait(4000)
            end
        end)
    end

    CreateThread(function()
        while true do
            Citizen.Wait(1000)
            local ped = PlayerPedId()
            local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
            local still = IsPedStill(ped)
            local vel = GetEntitySpeed(ped)
            local newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
            local newPed = PlayerPedId()
            if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 60 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
            TriggerServerEvent("Furious_ac:client:noclip", logreason)
            Citizen.Wait(3000)
            end
        end
    end)
CreateThread(function()
    while true do
      Citizen.Wait(3000)
     for fd, fe in pairs(FAC.MenuInjection.Sprites) do
      if HasStreamedTextureDictLoaded(fe.texture or "NULL") then
       TriggerServerEvent("Furious_ac:client:luamenudetection", logreason)
      end
      end
     local camcoords = (GetEntityCoords(PlayerPedId()) - GetFinalRenderedCamCoord())
      if (camcoords.x > 9) or (camcoords.y > 9) or (camcoords.z > 9) or (camcoords.x < -9) or (camcoords.y < -9) or (camcoords.z < -9) then
      TriggerServerEvent("Furious_ac:client:freecam", logreason)
       end
       if not IsRadarHidden() then
       TriggerServerEvent("Furious_ac:client:radar", logreason)
       end
       SetPedInfiniteAmmoClip(PlayerPedId(), false)
       if GetPedParachuteState(PlayerPedId()) >= 0 or IsPedRagdoll(PlayerPedId()) or IsPedFalling(PlayerPedId()) then
       SetEntityMaxSpeed(PlayerPedId(), 80.0)
         else
       SetEntityMaxSpeed(PlayerPedId(), 7.1)
         end
       if not IsEntityVisible(PlayerPedId()) or not IsEntityVisibleToScript(PlayerPedId()) or GetEntityAlpha(PlayerPedId()) <= 150 and not IsPlayerSwitchInProgress() then
         TriggerServerEvent("Furious_ac:client:invisable", logreason)
         end
       if not CanPedRagdoll(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), true) and not IsEntityDead(PlayerPedId()) and not IsPedJumpingOutOfVehicle(PlayerPedId()) and not IsPedJacking(PlayerPedId()) and IsPedRagdoll(PlayerPedId()) then
         TriggerServerEvent("Furious_ac:client:ragdoll", logreason)
         end
       local inveh = GetVehiclePedIsIn(ped, 0)
       if GetPlayerVehicleDamageModifier(PlayerId()) > 1.0 then
        TriggerServerEvent("Furious_ac:client:vehiclegodmode", logreason)
            end
        if IsVehicleDamaged(inveh) then
         if GetEntityHealth(inveh) >= GetEntityMaxHealth(inveh) then
       TriggerServerEvent("Furious_ac:client:vehiclegodmode", logreason)
         end
        end
      SetEntityInvincible(inveh, false)
     if not GetVehicleTyresCanBurst(inveh) then
     TriggerServerEvent("Furious_ac:client:vehicletires", logreason)
            end
       if GetOnscreenKeyboardResult() ~= nil then
         TriggerServerEvent("Furious_ac:client:onscreenkeyboard", logreason)
         end
        if GetLocalPlayerAimState() ~= 3 and not IsPedInAnyVehicle(PlayerPedId(), true) then
         TriggerServerEvent("Furious_ac:client:aimassist", logreason)
          end
          if GetUsingnightvision(true) and not IsPedInAnyHeli(PlayerPedId()) then
           TriggerServerEvent("Furious_ac:client:nightvision", logreason)
          end
          if GetUsingseethrough(true) and not IsPedInAnyHeli(PlayerPedId()) then
           TriggerServerEvent("Furious_ac:client:heatvision", logreason)
          end
           if NetworkIsInSpectatorMode() then
           TriggerServerEvent("Furious_ac:client:spectatedplayer", logreason)
          end
         if GetPedConfigFlag(PlayerPedId(), 223, true) then
       TriggerServerEvent("Furious_ac:client:smallped", logreason)
      Citizen.Wait(3000)
     end
  end
end)

CreateThread(function()
    while true do
         Citizen.Wait(2000)
         local PED = PlayerPedId()
         if not IsPedInAnyVehicle(PED, false) and not IsPlayerSwitchInProgress() then
         local _pos = GetEntityCoords(PED)
         local _newped = PlayerPedId()
         local _newpos = GetEntityCoords(_newped)
         local _distance = #(vector3(_pos) - vector3(_newpos))
         if _distance > 200 and not IsEntityDead(PED) and not IsPedInParachuteFreeFall(PED) and not IsPedJumpingOutOfVehicle(PED) and PED == _newped and not IsPlayerSwitchInProgress() then
         TriggerServerEvent("Furious_ac:client:teleport", logreason)
         end
        end
     end
  Citizen.Wait(3000)
end)
        
AddEventHandler('onResourceStop', function(resourceName)
     if resourceName == GetCurrentResourceName() then
	TriggerServerEvent("Furious_ac:client:resourcestop", logreason)
      end
end)

RegisterNUICallback(GetCurrentResourceName(), function()
  TriggerServerEvent(GetCurrentResourceName())
end)

local entityEnumerator = {
	__gc = function(enum)
	if enum.destructor and enum.handle then
	    enum.destructor(enum.handle)
	end
	enum.destructor = nil
	enum.handle = nil
end}
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
          disposeFunc(iter)
          return
        end
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        local next = true
        repeat
          coroutine.yield(id)
          next, id = moveFunc(iter)
        until not next
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end
RegisterNetEvent("dsh8uf82j82ej8dsj8fj8j2jfjsjd8jf89j2e8jjdfsjfdsjidjsioj:objd8usd88fudsudfs8uds8uwip3d89fjgfd09j")
AddEventHandler("dsh8uf82j82ej8dsj8fj8j2jfjsjd8jf89j2e8jjdfsjfdsjidjsioj:objd8usd88fudsudfs8uds8uwip3d89fjgfd09j", function()
    for object in EnumerateObjects() do
        DeletePed(ped)
        if (DoesEntityExist(ped)) then 
            DeletePed(ped)
        end
    end
end)
RegisterNetEvent("uno:toggleNUI")
AddEventHandler("uno:toggleNUI", function(display)
    SendNUIMessage({
    type = "ui",
    display = display
  })
end)
RegisterNetEvent("Furious:PedWipe")
AddEventHandler("Furious:PedWipe", function()
    for ped in EnumeratePeds() do
        DeletePed(ped)
        if (DoesEntityExist(ped)) then 
            DeletePed(ped)
        end
    end
end)
RegisterNetEvent("Furious:VehicleWipe")
AddEventHandler("Furious:VehicleWipe", function()
    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
            SetEntityAsMissionEntity(vehicle, false, false) 
            DeleteVehicle(vehicle)
            if (DoesEntityExist(vehicle)) then 
                DeleteVehicle(vehicle)
            end
        end
    end
end)
RegisterNetEvent("Furious:EntityWipe")
AddEventHandler("Furious:EntityWipe", function()
    for object in EnumerateObjects() do
        DeletePed(ped)
        if (DoesEntityExist(ped)) then 
            DeletePed(ped)
        end
    end
    for ped in EnumeratePeds() do
        DeletePed(ped)
        if (DoesEntityExist(ped)) then 
            DeletePed(ped)
        end
    end
    for vehicle in EnumerateVehicles() do
        SetVehicleHasBeenOwnedByPlayer(vehicle, false) 
        SetEntityAsMissionEntity(vehicle, false, false) 
        DeleteVehicle(vehicle)
        if (DoesEntityExist(vehicle)) then 
            DeleteVehicle(vehicle)
        end
    end
end)
local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end
  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end