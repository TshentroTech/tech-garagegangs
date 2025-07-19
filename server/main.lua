local QBCore = exports['qb-core']:GetCoreObject()

-- Server-side gang vehicle validation
RegisterNetEvent('tech-garagegangs:server:ValidateGangVehicle', function(vehicleModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        TriggerClientEvent('QBCore:Notify', src, "Player not found!", "error")
        return false
    end
    
    local gang = Player.PlayerData.gang
    if not gang or gang.name == "none" then
        TriggerClientEvent('QBCore:Notify', src, "You are not part of any gang!", "error")
        return false
    end
    
    -- Check if vehicle is allowed for this gang
    if not Config.Gangs[gang.name] or not Config.Gangs[gang.name]["vehicles"][vehicleModel] then
        TriggerClientEvent('QBCore:Notify', src, "This vehicle is not available for your gang!", "error")
        return false
    end
    
    return true
end)

-- Server-side vehicle spawn validation
RegisterNetEvent('tech-garagegangs:server:SpawnVehicle', function(vehicleModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if not Player then
        TriggerClientEvent('QBCore:Notify', src, "Player not found!", "error")
        return
    end
    
    local gang = Player.PlayerData.gang
    if not gang or gang.name == "none" then
        TriggerClientEvent('QBCore:Notify', src, "You are not part of any gang!", "error")
        return
    end
    
    -- Check if vehicle is allowed for this gang
    if not Config.Gangs[gang.name] or not Config.Gangs[gang.name]["vehicles"][vehicleModel] then
        TriggerClientEvent('QBCore:Notify', src, "This vehicle is not available for your gang!", "error")
        return
    end
    
    -- Allow the vehicle spawn
    TriggerClientEvent('tech-garagegangs:client:SpawnVehicleConfirmed', src, vehicleModel)
end)

-- Log gang vehicle usage
RegisterNetEvent('tech-garagegangs:server:LogVehicleUsage', function(vehicleModel, action)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    
    if Player then
        local gang = Player.PlayerData.gang
        local playerName = Player.PlayerData.name
        local gangName = gang and gang.name or "none"
        
        print(string.format("[tech-garagegangs] Player %s (%s) %s gang vehicle: %s", 
            playerName, gangName, action, vehicleModel))
    end
end)

-- Clean up when player disconnects
AddEventHandler('playerDropped', function()
    local src = source
    -- Any cleanup needed when player disconnects
end) 