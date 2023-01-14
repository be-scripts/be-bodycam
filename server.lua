Core = exports[''..Config.Core]:GetCoreObject()

 RegisterServerEvent("be-bodycam:add")
 AddEventHandler("be-bodycam:add", function(playerId)
     local data = {}

     for k,v in pairs(Core.Functions.GetPlayers()) do
         local xPlayer = Core.Functions.GetPlayer(v)

          local name = xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname
          local grade = xPlayer.PlayerData.job.grade.name
          local jobName = xPlayer.PlayerData.job.name

          local item = xPlayer.Functions.GetItemByName(Config.Item)
          if item ~= nil and item.amount > 0 then
                if jobName == "police" then
                        table.insert(data, {
                                src = v,
                                name = name,
                                grade = grade,
                        })
                end
          end


     end
     TriggerClientEvent("be-bodycam:update", playerId, data)
 end)


Core.Functions.CreateUseableItem(""..Config.Item, function(source, item)
        local src = source
        local xPlayer = Core.Functions.GetPlayer(src)
        local isallowed = false
        if xPlayer.Functions.GetItemByName(item.name) then
                local grade = xPlayer.PlayerData.job.grade.level
                local jobName = xPlayer.PlayerData.job.name
                if jobName == "police" then
                        for k,i in pairs(Config.GradeAllowed) do
                                if(grade == i) then
                                        TriggerClientEvent("be-bodycam:open", source, source)
                                        isallowed = true
                                end
                        end
                        if isallowed == false then
                                TriggerClientEvent(Config.CoreName..':Notify', source, "You must to have specific police grade", 'error', 1500)
                        end
                else
                        TriggerClientEvent(Config.CoreName..':Notify', source, "You must to have police job", 'error', 1500)
                end
            end
    end)
    
