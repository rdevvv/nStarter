local ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent("NeVo:starterpack")
AddEventHandler("NeVo:starterpack", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local identifier = xPlayer.identifier

        xPlayer.addAccountMoney("bank", Starter.Moneycount.BankCount)
        xPlayer.addAccountMoney("black_money", Starter.Moneycount.BlackMoneyCount)
        xPlayer.addMoney(Starter.Moneycount.CashCount)

    MySQL.Async.execute("UPDATE `users` SET `".. Starter.Coin.NameCoin .."` = '".. Starter.Coin.Count .."' WHERE `identifier` = '"..identifier.."'", {}, function() end)
    sendToDiscordWithSpecialURL(Starter.Weebhook.Name, xPlayer.getName()..Starter.Weebhook.Description, Starter.Weebhook.Color, Starter.Weebhook.weebhookLink)
end)

RegisterNetEvent("NeVo:starterpack_item")
AddEventHandler("NeVo:starterpack_item", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local identifier = xPlayer.identifier

    for k, v in pairs(Starter.Item) do 
        xPlayer.addInventoryItem(v.name, v.count)
    end    
end)

CreateThread(function()
    if GetCurrentResourceName() ~= "nStarter" then
        os.exit()
    end
end)

RegisterServerEvent('NeVo:vachercherlacaisse')
AddEventHandler('NeVo:vachercherlacaisse', function(price, mode)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    TriggerClientEvent('NeVo:prendlavoiture', source)
end)

RegisterServerEvent('NeVo:VehicleStarter')
AddEventHandler('NeVo:VehicleStarter', function(vehicleProps, plate, name)
        local _src = source
        local xPlayer = ESX.GetPlayerFromId(_src)

        MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
                ['@owner']   = xPlayer.identifier,
                ['@plate']   = vehicleProps.plate,
                ['@vehicle'] = json.encode(vehicleProps)
        })
end)

local function getDate()
    return os.date("*t", os.time()).day.."/"..os.date("*t", os.time()).month.."/"..os.date("*t", os.time()).year.." à "..os.date("*t", os.time()).hour.."h"..os.date("*t", os.time()).min
end

function sendToDiscordWithSpecialURL(name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= getDate(),
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

ESX.RegisterServerCallback('NeVo:getplayerstarter', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
    local starter = false
    MySQL.Async.fetchAll(
        'SELECT identifier FROM nstarter WHERE identifier = @identifier',
        {
          ['@identifier'] = identifier,
        },
          function(res)
            if res[1] then
                starter = true
            else
                starter = false
            end
            
            cb(starter)
    end
        )
end)

RegisterNetEvent("NeVo:validhavepack")
AddEventHandler("NeVo:validhavepack", function(info)
    local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
    MySQL.Async.execute('INSERT INTO nstarter (identifier, starter) VALUES (@identifier, @starter)', {
        ['@identifier'] = identifier,
        ['@starter'] = info,
    })
end)

ESX.RegisterServerCallback('NeVo:verifierplaquedispo', function (source, cb, plate)
    MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }, function (result)
        cb(result[1] ~= nil)
    end)
end)
