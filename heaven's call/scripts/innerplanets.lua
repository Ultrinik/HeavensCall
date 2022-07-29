local mod = HeavensCall
local game = Game()
local rng = RNG()
local sfx = SFXManager()
local json = require("json")


--VENUS---------------------------------------------------------------------------------------------------
--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@&%#((((((((((((((((##%&@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@&%((/////((((((((((((((((((((((#&@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@%(((//////,,,,,,,*************/(((((((#%&@@@@@@@@@@@@@
@@@@@@@@@@@@&#((((///,,,,,,,,,,,,,,,,,,,,,,********(((((((#%@@@@@@@@@@
@@@@@@@@@@%((((((*,,,,,,,,,,,,,,,,,,,,,,,,,***********((((((%@@@@@@@@@
@@@@@@@@&#(((((***********,,,,,,,,,,,,,,,,,,*,***********(((((&@@@@@@@
@@@@@@@%(((((********,,,,,,,,,,,,,,,,,,,,,,,,***,,,********((((#@@@@@@
@@@@@@%((((******,,,,,,,,,,,,,,,,,,,,,,**,,,,,,,,,,*********((((#&@@@@
@@@@@%((((,***********/****,,,,,,,,,,,,,,(*******************/((((%@@@
@@@@%((((*******((//*,,,,,,,,,,,,,,,,,,,,,,********(*****,,,,,/(((#&@@
@@@&#(((/*//***/(((((*,,,,,,,,,,,,,,,,,,,/(((((((((/,,,*,......///(&@@
@@@%((((**/((#####(/(#/,,(,,,,,,,,,,*,,,*##*/(#((/#(((((,....,,*(((%@@
@@@%(((((((,*##*.  ,##,,,,,,,,,,,,,,*,,,,(##,../##*,,,((((,,,,,,(((#@@
@@@&#(((((,,,,,*##/#,,,,,,,,,,,,,,,*,,,,,,*/#(#/*,,,,,,((((,,,,,(((#@@
@@@@#(((((((,,,,/(*,,,/,,,,,/,,,,*,,,,,,,,,,*/,,,,,,,*(((,..,,,//((%@@
@@@@&((((,,,/,,,,*,,,*,,,,,/,,,,/,,,,,,/,,,,,/,,,,((((,,,,,,,,,((((@@@
@@@@@%((((,,,,,,,,,,,,,,,,*,,,,/,,,,,,/,,,,,*,,,,*,,,,,,,,,,,,((((%@@@
@@@@@@#(((/,,,*,,,*,,,,,,/(((((((((//*,,,,*,,,,*,,,,,,,,,,,,,((((&@@@@
@@@@@@@#((((,,,,,*,,,**((////(////////(*,,,,,,,,,,,,,,,,,,,*((((&@@@@@
@@@@@@@@#((((/,,,,,,,,,//////(/////(///,,,,,,,,,,,,,,,,***((((#@@@@@@@
@@@@@@@@@&#((((/*,,,,,,,(#(((*##(##(//,,,,,,**,,,,,*****((((#&@&@@@@@@
@@@@@@@@@@@@%(((((***,,,*(((((((((##*,,***,,,,,,,,,,,/((((#@@@@@@@@@@@
@@@@@@@@@@@@@@@%((((((*,,(#((((((((,,,,,,,,,,,,,,*////((&@@@@@@@@@@@@@
@@@@@@@@@&@@@@@@@@%#(((((((((((##*,,,,,,,,,/((((((((%&@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@%#(((((((((((((((((((((#%&@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&@@@@@@@@&@@@&@&#%@@@@@@@@@@@@@
]]--
    
mod.VMSState = {
    APPEAR = 0,
    IDLE = 1,
    FLAME = 2,
    SUMMON = 3,
    IPECAC = 4,
    JUMPS = 5,
    BLAZE = 6,
    KISS = 7,
    SWARM = 8,
    SLAM = 9,
    LIT = 10
}
mod.chainV = {--                 A    I     F     S     Ip    J     B     K     Sw   Sl   Lit 
    [mod.VMSState.APPEAR] = 	{0,   0,    0,    1,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.IDLE] = 	    {0,	  0.3,	0.05, 0.2,	0.04, 0.04,	0.08, 0.1,	0.04,0.05,0.1},
    [mod.VMSState.FLAME] =  	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.SUMMON] = 	{0,   0.1,  0,    0,    0,    0,    0,    0,    0,   0,   0.9},
    [mod.VMSState.IPECAC] = 	{0,   0.8,  0,    0,    0,    0,    0.2,  0,    0,   0,   0},
    [mod.VMSState.JUMPS] =  	{0,   0.6,  0,    0,    0.1,  0,    0.1,  0,    0,   0.2, 0},
    [mod.VMSState.BLAZE] =  	{0,   0.75, 0,    0,    0,    0,    0,    0.25, 0,   0,   0},
    [mod.VMSState.KISS] = 	    {0,   0.1,  0.45, 0,    0,    0,    0,    0,    0,   0.45,0},
    [mod.VMSState.SWARM] =  	{0,   0.8,  0,    0,    0.15, 0,    0,    0,    0.05,0,   0},
    [mod.VMSState.SLAM] =   	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.LIT] =    	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0}
    
}
mod.VConst = {--Some constant variables of Venus

}

function mod:VenusUpdate(entity)
    if entity.Variant == mod.EntityInf[mod.Entity.Venus].VAR and entity.SubType == mod.EntityInf[mod.Entity.Venus].SUB then
        local data = entity:GetData()
        local sprite = entity:GetSprite()
        local target = entity:GetPlayerTarget()
        local room = game:GetRoom()
        
        --Custom data:
        if data.State == nil then data.State = 0 end
        if data.StateFrame == nil then data.StateFrame = 0 end
        
        
        --Frame
        data.StateFrame = data.StateFrame + 1
        
        if data.State == mod.VMSState.APPEAR then
            if data.StateFrame == 1 then
                mod:AppearPlanet(entity)
                entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
            elseif sprite:IsFinished("Appear") or sprite:IsFinished("AppearSlow") then
                data.State = mod:MarkovTransition(data.State, mod.chainV)
                data.StateFrame = 0
            elseif sprite:IsEventTriggered("EndAppear") then
                entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
            end
            
        elseif data.State == mod.VMSState.IDLE then
            if data.StateFrame == 1 then
                sprite:Play("Idle",true)
            elseif sprite:IsFinished("Idle") then
                data.State = mod:MarkovTransition(data.State, mod.chainV)
                data.StateFrame = 0
                
            else
                mod:VenusMove(entity, data, room, target)
            end
            
        elseif data.State == mod.VMSState.FLAMES then
            mod:VenusFlamethrower(entity, data, sprite, target,room)
        end
    end
end
function mod:VenusFlamethrower(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Flame",true)
    elseif sprite:IsFinished("Flame") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0


    end
end

--Move
function mod:VenusMove(entity, data, room, target)
    --idle move taken from 'Alt Death' by hippocrunchy
    --It just basically stays around the center of the room
    
    --idleTime == frames moving in the same direction
    if not data.idleTime then 
        data.idleTime = mod:RandomInt(mod.JConst.idleTimeInterval.X, mod.JConst.idleTimeInterval.Y)
        --V distance of Jupiter from the center of the room
        local distance = room:GetCenterPos():Distance(entity.Position)
        
        --If its too far away, return to the center
        if distance > 100 then
            data.targetvelocity = ((room:GetCenterPos() - entity.Position):Normalized()*2):Rotated(mod:RandomInt(-10, 10))
        --Else, get closer to the player
        else
            data.targetvelocity = ((target.Position - entity.Position):Normalized()*2):Rotated(mod:RandomInt(-50, 50))
        end
    end
    
    --If run out of idle time
    if data.idleTime <= 0 and data.idleTime ~= nil then
        data.idleTime = nil
    else
        data.idleTime = data.idleTime - 1
    end
    
    --Do the actual movement
    entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * mod.JConst.speed
    data.targetvelocity = data.targetvelocity * 0.99
end

--ded
function mod:VenusDeath(entity)
    --Fart:
    mod:NormalDeath(entity)
end
--deding
function mod:VenusDying(entity)
    
    local sprite = entity:GetSprite()
    local data = entity:GetData()

end

--Callbacks
--Venus updates
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.VenusUpdate, mod.EntityInf[mod.Entity.Venus].ID)
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.VenusDeath, mod.EntityInf[mod.Entity.Venus].ID)
