local special = false
local specialactive = false
local specialtouse = 2

RegisterNetEvent('basics:specialAbility')
AddEventHandler('basics:specialAbility', function(bool, which)
    if bool then 
        special = true
        if which then
            if which == "t" then
                TriggerEvent('chat:addMessage', { args = { '^4Dein Helfer', '^5 Du kannst jetzt Special Abilitys nutzen (T)!'}})
                specialtouse = 3
            end
            if which == "m" then
                TriggerEvent('chat:addMessage', { args = { '^4Dein Helfer', '^5 Du kannst jetzt Special Abilitys nutzen (M)!'}})
                specialtouse = 1
            end
            if which == "f" then
                TriggerEvent('chat:addMessage', { args = { '^4Dein Helfer', '^5 Du kannst jetzt Special Abilitys nutzen (F)!'}})
                specialtouse = 2
            end
        else
            TriggerEvent('chat:addMessage', { args = { '^4Dein Helfer', '^5 Du kannst jetzt Special Abilitys nutzen (F)!'}})
            specialtouse = 2
        end
    else 
        special = false
        TriggerEvent('chat:addMessage', { args = { '^4Dein Helfer', '^5 Du hast Special Abilitys deaktiviert!'}})
        specialtouse = 2
    end    
end)

RegisterCommand('special', function(source, args, rawCommand)
    if special then
        special = false
        TriggerEvent('basics:specialAbility', false)
    else
        special = true
        TriggerEvent('basics:specialAbility', true, args[1])
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if special then
            if IsControlJustReleased(0, 171) then
                if specialactive then
                    specialactive = false
                    --disable the special abilitys
                    if specialtouse == 2 then  --Franklins
                        SetSpecialAbility(PlayerId(), 2, 0)
                        SpecialAbilityActivate(PlayerId(), 2)
                        SetSpecialAbility(PlayerId(), 3, 0)
                        SpecialAbilityActivate(PlayerId(), 3)
                    end
                    if specialtouse == 1 then  --Michaels
                        SetSpecialAbility(PlayerId(), 3, 0)
                        SpecialAbilityActivate(PlayerId(), 3)
                    end
                    if specialtouse == 3 then  --Trevors
                        SetSpecialAbility(PlayerId(), 5, 0)
                        SpecialAbilityActivate(PlayerId(), 5)
                    end
                else
                    specialactive = true
                    --enable the special abilitys
                    if specialtouse == 2 then  --Franklins
                        SetSpecialAbility(PlayerId(), 0, 0)
                        SpecialAbilityActivate(PlayerId(), 0)
                    end
                    if specialtouse == 1 then  --Michaels
                        SetSpecialAbility(PlayerId(), 2, 0)
                        SpecialAbilityActivate(PlayerId(), 2)
                    end
                    if specialtouse == 3 then  --Trevors
                        SetSpecialAbility(PlayerId(), 1, 0)
                        SpecialAbilityActivate(PlayerId(), 1)
                    end
                end
            end
        end
    end
end)
