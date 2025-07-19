local QBCore = exports['qb-core']:GetCoreObject()
local isLoggedIn = false
local PlayerGang = {}
local spawnedVehicles = {}
local speedLimitedVehicles = {}
local vehicleGangOwnership = {} -- Track which gang owns each vehicle

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerGang = QBCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
    PlayerGang = {}
    -- Clean up spawned vehicles
    for _, vehicle in pairs(spawnedVehicles) do
        if DoesEntityExist(vehicle) then
            DeleteEntity(vehicle)
        end
    end
    spawnedVehicles = {}
    speedLimitedVehicles = {}
    vehicleGangOwnership = {}
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(GangInfo)
    local oldGang = PlayerGang.name
    PlayerGang = GangInfo
    isLoggedIn = true
    
    -- If gang changed, check if player is in a vehicle from their old gang
    if oldGang and oldGang ~= "none" and PlayerGang.name ~= oldGang then
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            if vehicleGangOwnership[vehicle] and vehicleGangOwnership[vehicle] == oldGang then
                -- Only eject if player is the driver
                if GetPedInVehicleSeat(vehicle, -1) == ped then
                    TaskLeaveVehicle(ped, vehicle, 0)
                end
            end
        end
    end
end)

-- Function to check if player can access gang vehicles
local function CanAccessGangVehicles()
    if not isLoggedIn or not PlayerGang or PlayerGang.name == "none" then
        QBCore.Functions.Notify("You are not part of any gang!", "error")
        return false
    end
    
    if not Config.Gangs[PlayerGang.name] then
        QBCore.Functions.Notify("Invalid gang configuration!", "error")
        return false
    end
    
    return true
end

function GangMenu()
    if not CanAccessGangVehicles() then
        return
    end
    
    exports['qb-menu']:openMenu({
        {
            header = "Gang Vehicle",
            icon = "fab fa-whmcs",
            isMenuHeader = true
        },
        {
            header = "Vehicle List ",
            txt = "  ",
            icon = "fas fa-car",
            params = {
                event = "tech-garagegangs:client:VehicleList"
            }
        },
        {
            header = "Store Vehicle",
            txt = "  ",
            icon = "fas fa-arrow-right-to-bracket",
            params = {
                event = "tech-garagegangs:client:VehicleDelet"
            }
        },
        {
            header = "Close",
            txt = "",
            icon = "fas fa-circle-right",
            params = {
            event = "qb-menu:closeMenu"
            }
        },
        })
    end
    
RegisterNetEvent("tech-garagegangs:client:VehicleList", function()
    if not CanAccessGangVehicles() then
        return
    end
    
    local VehicleList = {
    {
        header = " Vehicle List",
        icon = "fab fa-whmcs",
        isMenuHeader = true
    },
    }
    for k, v in pairs(Config.Gangs[PlayerGang.name]["vehicles"]) do
        table.insert(VehicleList, {
        header = v,
        icon = "fas fa-circle",
        params = {
            event = "tech-garagegangs:client:SpawnListVehicle",
            args = k
            }
        })
    end
        table.insert(VehicleList, {
        header = "Close",
        txt = "",
        icon = "fas fa-circle-xmark",
        params = {
            event = "qb-menu:closeMenu",
            }
        })
        exports['qb-menu']:openMenu(VehicleList)
end)



-- Vehicle spawner thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isLoggedIn and PlayerGang.name ~= "none" then
            local v = Config.Gangs[PlayerGang.name]["VehicleSpawner"]
            if v then
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local vehdist = #(pos - vector3(v.x, v.y, v.z))
                if vehdist < 20.0 then
                    DrawMarker(2, v.x, v.y, v.z - 0.2 , 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 200, 200, 222, false, false, false, true, false, false, false)
                    if vehdist < 1.5 then
                        exports['qb-core']:DrawText('<b style=color:rgb(255,0,0);>[E]</b> - Garage','left')
                        if IsControlJustPressed(0, 38) then                                         
                            GangMenu()
                        end
                    else
                        exports['qb-core']:HideText()
                    end
                else
                    Citizen.Wait(1000)
                end
            else
                Citizen.Wait(1000)
            end
        else
            Citizen.Wait(2500)
        end
    end
end)

RegisterNetEvent("tech-garagegangs:client:VehicleDelet", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= 0 then
        -- Check if this is a gang vehicle
        local plate = GetVehicleNumberPlateText(vehicle)
        if string.find(plate, "GANG") then
            DeleteVehicle(vehicle)
            -- Remove from spawned vehicles list
            for i, spawnedVehicle in pairs(spawnedVehicles) do
                if spawnedVehicle == vehicle then
                    table.remove(spawnedVehicles, i)
                    break
                end
            end
            -- Remove from speed limited vehicles list
            speedLimitedVehicles[vehicle] = nil
            -- Remove from gang ownership tracking
            vehicleGangOwnership[vehicle] = nil
            QBCore.Functions.Notify("Vehicle stored!", "success")
        else
            QBCore.Functions.Notify("This is not a gang vehicle!", "error")
        end
    else
        QBCore.Functions.Notify("You are not in a vehicle!", "error")
    end
end)

RegisterNetEvent("tech-garagegangs:client:SpawnListVehicle", function(model)
    -- Trigger server-side validation first
    TriggerServerEvent('tech-garagegangs:server:SpawnVehicle', model)
end)

RegisterNetEvent("tech-garagegangs:client:SpawnVehicleConfirmed", function(model)
    local coords = {
        x = Config.Gangs[PlayerGang.name]["VehicleSpawner"].x,
        y = Config.Gangs[PlayerGang.name]["VehicleSpawner"].y,
        z = Config.Gangs[PlayerGang.name]["VehicleSpawner"].z,
        w = Config.Gangs[PlayerGang.name]["VehicleSpawner"].w,
    }
    
    QBCore.Functions.SpawnVehicle(model, function(veh)
        if veh then
            local plate = "GANG"..tostring(math.random(1000, 9999))
            SetVehicleNumberPlateText(veh, plate)
            SetEntityHeading(veh, coords.w)
            exports[Config.Fuel]:SetFuel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            SetVehicleColours(veh, Config.Gangs[PlayerGang.name]["colors"][1], Config.Gangs[PlayerGang.name]["colors"][2])
            TriggerEvent("vehiclekeys:client:SetOwner", plate)
            SetVehicleEngineOn(veh, true, true)
            SetVehicleDirtLevel(veh, 0.0)
            
            -- Add to spawned vehicles list
            table.insert(spawnedVehicles, veh)
            
            -- Track gang ownership of this vehicle
            vehicleGangOwnership[veh] = PlayerGang.name
            
            -- Check if this vehicle has a speed limit
            if Config.SpeedLimits[model] then
                speedLimitedVehicles[veh] = {
                    model = model,
                    limit = Config.SpeedLimits[model]
                }
                QBCore.Functions.Notify("Speed limit set to " .. Config.SpeedLimits[model] .. " km/h", "info")
            end
            
            -- Log the vehicle usage
            TriggerServerEvent('tech-garagegangs:server:LogVehicleUsage', model, "spawned")
            
            QBCore.Functions.Notify("Vehicle spawned successfully!", "success")
        else
            QBCore.Functions.Notify("Failed to spawn vehicle!", "error")
        end
    end, coords, true)
end)

-- Gang vehicle restriction system
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if isLoggedIn then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                local plate = GetVehicleNumberPlateText(vehicle)
                
                -- Check if this is a gang vehicle
                if string.find(plate, "GANG") then
                    -- Check if player is in a gang
                    if PlayerGang.name == "none" then
                        -- Only eject if player is the driver
                        if GetPedInVehicleSeat(vehicle, -1) == ped then
                            TaskLeaveVehicle(ped, vehicle, 0)
                        end
                    else
                        -- Check if this vehicle belongs to player's current gang
                        local vehicleGang = vehicleGangOwnership[vehicle]
                        if vehicleGang and vehicleGang ~= PlayerGang.name then
                            -- Only eject if player is the driver
                            if GetPedInVehicleSeat(vehicle, -1) == ped then
                                TaskLeaveVehicle(ped, vehicle, 0)
                            end
                        elseif not vehicleGang then
                            -- Fallback check for spawned vehicles list
                            local isGangVehicle = false
                            for _, spawnedVehicle in pairs(spawnedVehicles) do
                                if spawnedVehicle == vehicle then
                                    isGangVehicle = true
                                    break
                                end
                            end
                            
                            if not isGangVehicle then
                                -- Only eject if player is the driver
                                if GetPedInVehicleSeat(vehicle, -1) == ped then
                                    TaskLeaveVehicle(ped, vehicle, 0)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Speed limit enforcement system
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if isLoggedIn then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local vehicle = GetVehiclePedIsIn(ped, false)
                
                -- Check if this vehicle has a speed limit
                if speedLimitedVehicles[vehicle] then
                    local speedLimit = speedLimitedVehicles[vehicle].limit
                    local currentSpeed = GetEntitySpeed(vehicle) * 3.6 -- Convert to km/h
                    
                    -- If speed exceeds limit, reduce it silently
                    if currentSpeed > speedLimit then
                        local newSpeed = speedLimit / 3.6 -- Convert back to m/s
                        SetVehicleForwardSpeed(vehicle, newSpeed)
                    end
                end
            end
        end
    end
end)


