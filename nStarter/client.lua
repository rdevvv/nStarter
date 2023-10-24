
local carGive = {}
local utiliser = nil

CreateThread(function()

    ESX = exports["es_extended"]:getSharedObject()

        while ESX == nil do Wait(0) end

    while ESX.GetPlayerData().job == nil do
        Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

if Starter.Point.Blips == true then
    CreateThread(function()

        local startermap = AddBlipForCoord(Starter.Point.Position)
    
        SetBlipSprite(startermap, 586)
        SetBlipColour(startermap, 47)
        SetBlipScale(startermap, 0.8)
        SetBlipAsShortRange(startermap, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(Starter.Point.BlipsName)
        EndTextCommandSetBlipName(startermap)
    end)
end


function MenuStarter()
local MainMenu = RageUI.CreateMenu(Starter.Traduction.MenuName, Starter.Traduction.SubMenuName)
MainMenu:SetRectangleBanner(11, 11, 11, 0)
	        RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
            while MainMenu do
            Wait(0)

RageUI.IsVisible(MainMenu, true, true, true, function()
    RageUI.Separator("~s~ →→ ~b~ Votre ID : ~y~"..GetPlayerServerId(PlayerId())..' ~s~←←')
    RageUI.Separator("~s~ →→ ~b~ Votre Nom : ~y~"..GetPlayerName(PlayerId())..' ~s~←←')

    if utiliser == false then
        RageUI.ButtonWithStyle(Starter.Traduction.ButtonName, Starter.Traduction.DescriptionName , {RightLabel = "→→"}, true, function(Hovered, Active, Selected)
            if (Selected) then

                TriggerServerEvent('NeVo:starterpack_item')
                TriggerServerEvent('NeVo:starterpack')
                TriggerServerEvent('NeVo:vachercherlacaisse')
                TriggerServerEvent('NeVo:validhavepack', 1)
                ESX.ShowAdvancedNotification(Starter.Traduction.NotificationName, "Pack Démarrage", Starter.Traduction.NotificationDescription, Starter.Traduction.NotificationLogo, 1)
                utiliser = true
            end
        end)
    else
        RageUI.Separator("")
        RageUI.Separator(Starter.Traduction.HavePack)
        RageUI.Separator("")
    end
end, function()
end)
    if not RageUI.Visible(MainMenu) then
        MainMenu = RMenu:DeleteType("MainMenu", true)
    end
end
end

RegisterNetEvent('NeVo:prendlavoiture')
AddEventHandler('NeVo:prendlavoiture', function()
    giveCarStarter(Starter.Voiture.VehiculeStarter)
end)


function giveCarStarter(model)
    Citizen.Wait(10)
    ESX.Game.SpawnVehicle(model, {x = Starter.Voiture.Position.x ,y = Starter.Voiture.Position.y , z = Starter.Voiture.Position.z }, Starter.Voiture.Position.h , function(vehicle) 
        local plate = GeneratePlate()
        table.insert(carGive, vehicle)
        local vehicleProps = ESX.Game.GetVehicleProperties(carGive[#carGive])
        SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
        vehicleProps.plate = plate
        SetVehicleNumberPlateText(carGive[#carGive] , plate)
        TriggerServerEvent('NeVo:VehicleStarter', vehicleProps, plate, name)
        TriggerServerEvent('MXXR_RegisterNewKey', plate, GetPlayerServerId(PlayerId())) -- Add key (Cle)
	end)
end


CreateThread(function()
    while true do
        local Timer = 500
        local plyPos = GetEntityCoords(PlayerPedId())
        local dist = #(plyPos-Starter.Point.Position)
        if dist <= 10.0 then
         Timer = 0
         DrawMarker(22, Starter.Point.Position, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
        end
        if dist <= 3.0 then
            Timer = 0
            RageUI.Text({ message = Starter.Point.Texte, time_display = 1 })
            if IsControlJustPressed(1,51) then
                ESX.TriggerServerCallback('NeVo:getplayerstarter', function(starter)
                    utiliser = starter
                    MenuStarter()
                end)
            end
         end
    Wait(Timer)
    end
end)

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())

			generatedPlate = string.upper(GetRandomLetter(4) .. GetRandomNumber(4))

		ESX.TriggerServerCallback('NeVo:verifierplaquedispo', function (isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('NeVo:verifierplaquedispo', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end