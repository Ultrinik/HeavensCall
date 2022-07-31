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
    --[mod.VMSState.IDLE] = 	    {0,	  0,	0,    0,	0,    1,	0.08, 0.1,	0.04,0.05,0.1},
    --[mod.VMSState.IDLE] = 	    {0,	  0,	0,    0,	0,    0,	1, 0.1,	0.04,0.05,0.1},
    --[mod.VMSState.IDLE] = 	    {0,	  0,	0,    0,	0,    0,	0,    1,	0.04,0.05,0.1},
    [mod.VMSState.FLAME] =  	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.SUMMON] = 	{0,   0.1,  0,    0,    0,    0,    0,    0,    0,   0,   0.9},
    [mod.VMSState.IPECAC] = 	{0,   0.8,  0,    0,    0,    0,    0.2,  0,    0,   0,   0},
    [mod.VMSState.JUMPS] =  	{0,   0.6,  0,    0,    0.1,  0,    0.1,  0,    0,   0.2, 0},
    [mod.VMSState.BLAZE] =  	{0,   0.75, 0,    0,    0,    0,    0,    0.25, 0,   0,   0},
    [mod.VMSState.KISS] = 	    {0,   0.1,  0.3,  0,    0,    0.3,  0,    0,    0,   0.3,0},
    --[mod.VMSState.KISS] = 	    {0,	  0,	0,    0,	0,    0,	0,    1,	0.04,0.05,0.1},
    [mod.VMSState.SWARM] =  	{0,   0.8,  0,    0,    0.15, 0,    0,    0,    0.05,0,   0},
    [mod.VMSState.SLAM] =   	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.LIT] =    	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0}
    
}
mod.VConst = {--Some constant variables of Venus
    idleTimeInterval = Vector(5,10),
    speed = 1.5,

    nBlazesFast = 2,
    blazeAngleFast = 20,
    blazeSpeedFast = 7.5,
    nBlazesSlow = 2,
    blazeAngleSlow = 25,
    blazeSpeedSlow = 6.5,

    flameAngle = 20,
    flameAngleStart = 80,
    flameSpeed = 6,

    jumpSpeed = 15,

    kissSpeed = 20,
    kissHomming = 10,

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
        if data.Flamethrower == nil then data.Flamethrower = false end
        if data.FlameSlide == nil then data.FlameSlide = false end
        if data.TargetPos == nil then data.TargetPos = target.Position end
        if data.FireWaveType == nil then data.FireWaveType = 0 end
        if data.FlameAngle == nil then data.FlameAngle = mod.VConst.flameAngleStart end
        
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
            
        elseif data.State == mod.VMSState.FLAME then
            mod:VenusFlamethrower(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.SUMMON then
            mod:VenusSummon(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.IPECAC then
            mod:VenusIpecac(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.JUMPS then
            --mod:VenusJumps(entity, data, sprite, target,room) --Too many attacks, need to make space for the summons
            data.State = mod:MarkovTransition(data.State, mod.chainV)
            data.StateFrame = 0
        elseif data.State == mod.VMSState.BLAZE then
            mod:VenusBlaze(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.KISS then
            mod:VenusKiss(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.SWARM then
            mod:VenusSwarm(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.SLAM then
            mod:VenusSlam(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.LIT then
            mod:VenusLit(entity, data, sprite, target,room)
        end

        
	--if game:GetFrameCount()%3==0 then
	--	game:SpawnParticles (entity.Position + Vector(0,-100), EffectVariant.EMBER_PARTICLE, 9, 5)
	--end
    end
end
function mod:VenusFlamethrower(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Flame",true)
    elseif sprite:IsFinished("Flame") then
        data.FlameAngle = mod.VConst.flameAngleStart
        data.Flamethrower = false
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("SetAim") then
        entity.Velocity = Vector.Zero
        data.TargetPos = target.Position
    elseif sprite:IsEventTriggered("FlameStart") then
        data.Flamethrower = true
    elseif sprite:IsEventTriggered("Shot") then
		local player_direction = target.Position - entity.Position
        local velocity = player_direction:Normalized()*mod.VConst.flameSpeed*1.5
        local flame = mod:SpawnEntity(mod.Entity.Flame, entity.Position, velocity, entity):ToProjectile()
		flame.FallingAccel  = -0.1
		flame.FallingSpeed = 0
        flame.Scale = 2

        flame:GetData().IsFlamethrower = true
        flame:GetData().EmberPos = -20
    end

    if data.Flamethrower then
        data.FlameAngle = data.FlameAngle - 1
        if data.FlameAngle < mod.VConst.flameAngle then data.FlameAngle = mod.VConst.flameAngle end

        local velocity = Vector.Zero
        for i=0, 1 do
            if data.StateFrame%3 == 0 then
                
                velocity = (data.TargetPos - entity.Position):Normalized()*mod.VConst.flameSpeed
                velocity = velocity:Rotated((data.FlameAngle + 10*rng:RandomFloat())*(2*i-1))
                local flame = mod:SpawnEntity(mod.Entity.Flame, entity.Position, velocity, entity):ToProjectile()

                flame.FallingAccel  = -0.1
                flame.FallingSpeed = 0
                flame.Height = -5

                flame:GetData().IsFlamethrower = true

                flame:AddProjectileFlags(ProjectileFlags.ACCELERATE)
                flame:AddProjectileFlags(ProjectileFlags.MEGA_WIGGLE)
            end
        end
        
        --Do the actual movement
        entity.Velocity = ((-velocity * 0.3) + (entity.Velocity * 0.7)) * mod.VConst.speed

    end

end
function mod:VenusSummon(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Summon",true)
    elseif sprite:IsFinished("Summon") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0


    end
    
    mod:VenusMove(entity, data, room, target, 0.8)
end
function mod:VenusBlaze(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Blaze",true)
    elseif sprite:IsFinished("Blaze") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Blaze") then
        for i=1, mod.VConst.nBlazesSlow do
            local targetPos = target.Position:Rotated((2*rng:RandomFloat()-1)*mod.VConst.blazeAngleSlow)
            local velocity = (targetPos - entity.Position):Normalized()*mod.VConst.blazeSpeedSlow*(0.6 + 0.7*rng:RandomFloat())
            local fireball = mod:SpawnEntity(mod.Entity.Fireball, entity.Position, velocity, entity):ToProjectile()

            fireball:GetData().IsFireball = true
            
            fireball.FallingSpeed = -10
            fireball.FallingAccel = 1.5
            
            fireball:AddProjectileFlags(ProjectileFlags.FIRE_SPAWN)
        end
        
        for i=1, mod.VConst.nBlazesFast do
            local targetPos = target.Position:Rotated((2*rng:RandomFloat()-1)*mod.VConst.blazeAngleFast)
            local velocity = (targetPos - entity.Position):Normalized()*mod.VConst.blazeSpeedFast*(0.5 + 0.7*rng:RandomFloat())
            local fireball = mod:SpawnEntity(mod.Entity.Fireball, entity.Position, velocity, entity):ToProjectile()

            fireball:GetData().IsFireball = true

            fireball.FallingSpeed = -10
            fireball.FallingAccel = 1.5
            
            fireball:AddProjectileFlags(ProjectileFlags.DECELERATE)
            fireball:AddProjectileFlags(ProjectileFlags.FIRE_SPAWN)
        end
    end
end
function mod:VenusIpecac(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Ipecac",true)
    elseif sprite:IsFinished("Ipecac") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0
        data.FireWaveType = 1 - data.FireWaveType

    elseif sprite:IsEventTriggered("Ipecac") then
        
        --Ipecac-like projectile technique from Alt Horsemen
        local variance = (Vector(mod:RandomInt(-15, 15),mod:RandomInt(-15, 15))*0.1)
        local vector = (target.Position-entity.Position)*0.028 + variance
        
        local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, vector, entity):ToProjectile();
        tear:GetSprite().Color = mod.Colors.fire
        tear.Scale = 2
        tear.FallingSpeed = -45;
        tear.FallingAccel = 1.5;

        tear:AddProjectileFlags(ProjectileFlags.EXPLODE)
        tear:AddProjectileFlags(ProjectileFlags.FIRE_SPAWN)
        
        if data.FireWaveType == 1 then
            tear:AddProjectileFlags(ProjectileFlags.FIRE_WAVE)
        else
            tear:AddProjectileFlags(ProjectileFlags.FIRE_WAVE_X)
        end

    end
end
function mod:VenusJumps(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Jumps",true)
    elseif sprite:IsFinished("Jumps") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0
    
    elseif sprite:IsEventTriggered("Slam") then
        entity.Velocity = Vector.Zero
        local flame = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_FIRE, 0, entity.Position, Vector.Zero, entity):ToProjectile()
        if data.FireWaveType == 1 then
            flame:AddProjectileFlags(ProjectileFlags.FIRE_WAVE)
            data.FireWaveType = 0
        else
            flame:AddProjectileFlags(ProjectileFlags.FIRE_WAVE_X)
            data.FireWaveType = 1
        end
        flame:Die()
    elseif sprite:IsEventTriggered("Jump") then
		local player_direction = target.Position - entity.Position
        local velocity = player_direction:Normalized()*mod.VConst.jumpSpeed
        entity.Velocity = velocity

    end
end
function mod:VenusKiss(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Kiss",true)
    elseif sprite:IsFinished("Kiss") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Kiss") then
		local player_direction = target.Position - entity.Position
        local velocity = player_direction:Normalized()*mod.VConst.kissSpeed
        local kiss = mod:SpawnEntity(mod.Entity.Kiss, entity.Position, velocity, entity):ToProjectile()
		kiss.FallingAccel  = -0.1
		kiss.FallingSpeed = 0
        kiss.HomingStrength = mod.VConst.kissHomming

        local sprite = kiss:GetSprite()
        sprite:Play("Idle",true)

    end
end
function mod:VenusSwarm(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Swarm",true)
    elseif sprite:IsFinished("Swarm") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0


    end
end
function mod:VenusSlam(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Slam",true)
    elseif sprite:IsFinished("Slam") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0


    end
end
function mod:VenusLit(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Kiss",true)
    elseif sprite:IsFinished("Kiss") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0


    end
end

--Move
function mod:VenusMove(entity, data, room, target, speed)
    if speed == nil then speed = 1 end
    --idle move taken from 'Alt Death' by hippocrunchy
    --It just basically stays around the center of the room
    
    --idleTime == frames moving in the same direction
    if not data.idleTime then 
        data.idleTime = mod:RandomInt(mod.VConst.idleTimeInterval.X, mod.VConst.idleTimeInterval.Y)

        local antipode = (target.Position - room:GetCenterPos()):Rotated(180):Normalized()*150 + room:GetCenterPos()
        --V distance of Venus from the oposite place of the player
        local distance = antipode:Distance(entity.Position)
        
        --If its too far away, return to the center
        if distance > 40 then
            data.targetvelocity = ((antipode - entity.Position):Normalized()*2):Rotated(mod:RandomInt(-10, 10))
        end

        --Not that close to the plater
        if target.Position:Distance(entity.Position) < 100 then
            data.targetvelocity = (-(target.Position - entity.Position):Normalized()*6):Rotated(mod:RandomInt(-45, 45))
        end
    end
    
    --If run out of idle time
    if data.idleTime <= 0 and data.idleTime ~= nil then
        data.idleTime = nil
    else
        data.idleTime = data.idleTime - 1
    end
    
    --Do the actual movement
    entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * mod.VConst.speed * speed
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
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, entity, _, flags, _, _)
	if entity.Variant == mod.EntityInf[mod.Entity.Venus].VAR and entity.SubType == mod.EntityInf[mod.Entity.Venus].SUB and (flags & DamageFlag.DAMAGE_FIRE == DamageFlag.DAMAGE_FIRE) then
		return false
	end
end)

