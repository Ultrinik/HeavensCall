local mod = HeavensCall
local game = Game()
local rng = RNG()
local sfx = SFXManager()
local json = require("json")


--MERCURY---------------------------------------------------------------------------------------------------
--[[
@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@&%###&&@&@@@@@&@@@@@@@@@@@&@@@@@@@@@
@@@@@@@&@@@@@@@@@@@@@@@@@#(((((((((((((((((((((((%@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@%(((///(##(((((((((((((((//////(((@&@@&@@@@@@@@@@@
@@@@@@@@@@@@@@@@@((((///*/(###(//(/((((((/(((((//////////%@@@@@@@@@@@@
@@@@@@@@@@@@@@%((///***//((#((**//////(/..(((((///*/////////@@@@@@@@@@
@@@@@@@@@@@@%(///********/(((***//////((((((//////****////////@@@@@@@@
@@@@@@@@@@@#(/#%*&&******////*****///(//((((%%%%%%%%%%%%*//////(@@@@&@
@@@@@@@@@%(//#%%%&&//*..*///**,**//(((((((%&&&&&&&%%&&%%%%#//////@@@@@
@@@@@@@@%(((/%%%&&&((/%&%/%%%#,///(((((((%%&&&%%%%%%%%&%%%%%(/////@@@@
@@@@@@@&(((//%%%&&%((&&&%(%&&&*%%((((((#(%%&&%%((((((/%%%%%%%//////@@@
@@@@@@@#((///(&%%%#(%&&&(((&%(*&&%((((((/%%&&%/(##/(&(/%%%%%%%/////%@@
@@@@@@@((((#//#&%%*/&&&((((&&&&&&&%#((((//%%%%%((#@&((#%%%%%%%//////@@
@@@@@@(((#&&///////(((((#&&&%&&&&&&#(((////%%%%%%%%%%%%%%%%%%///////@@
@@@@@@(((%&%//%#///(@%&@((&&&&&&&&&%((((////(%%%%%%%%%%%%%%%////////@@
@@@@@@%((%%#(#&%#(((#@@#(%&&&&&&&&&&((#%%(///*//%%%%%&%&%(//(///////@@
@@@@@@@((/&&&&&&&(/#&%%%&&&&&&&&&&&%(%&&&%#//////////////*((((/////@@@
@@@@@@@#((/&&&%&&%(#&&&&&&&&&&&&&&&##(%&&#(((/((/((((/////((#(////#@@@
@@@@@@@@((((&&&&&&(#%&&&&&&&%&&&&&&######((((((((((((////((((////(@@@@
@@@@@@@@#((/(&&&&&%##&&&&&&&%&&&&&%/(##%%&&&&%((((////%%%%((////&@@@@@
@@@@@@@%#(@&/(&&&&###(&&&&&%%%&&%%%//%%&&&%&&%((&&&&&&%%%%(////@@@@@@@
@@@@@@@(((@@@#/(((##(((%&&&&%%&&%%///&&%&&&&&&&&&&&&&&%%%(///@@@@@@@@@
@@@@@@(///@@&@@@/###(((((&&&&&%%%///*#&&%&&&&&&&&%%%&%%(///@@@@@@@@@@@
@@@@@@////&@@@@@@%####(((((((((////////&&%&&%%%%////////@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@##%@%(((((((((/////////(((////////@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@##@@@((@@@%(///////////////(@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@#(@@@((@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&/
@@@@@@@@@@@@@@@@@@((@@#((#@@@@@@&@@@@@@@@@@@@@@@@@@%@@@@@@@@///@@@/&@@
@@@@@@@@@@@@@@@@@((((@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@/(///(@@/(@@@@@@((@
@@@@@@@@@@@@@@@@%((//@@@@@@@@&@@@@//@@@@@@@/////@@@@/%@@@@@/(@@@@@@@@@
@@@@@@@@@@@@@@@@@/***@@@@@@@%//(@(/(/@@@@#/#(//(%@@@&/&@@@@@//#(/#@@@@
]]--


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
    [mod.VMSState.IDLE] = 	    {0,	  0.605,0.01, 0.2,	0.005,0.01,	0.02, 0.04, 0.005,0.005,0.1},
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
--[[mod.chainV = {--                 A    I     F     S     Ip    J     B     K     Sw   Sl   Lit 
    [mod.VMSState.APPEAR] = 	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.IDLE] = 	    {0,   0.3,	0.15, 0,	0.14, 0,	0.18, 0.1,	0.08,0.05,0},
    --[mod.VMSState.IDLE] = 	    {0,	  0,	0,    0,	0,    1,	0.08, 0.1,	0.04,0.05,0.1},
    --[mod.VMSState.IDLE] = 	    {0,	  0,	0,    0,	0,    0,	1, 0.1,	0.04,0.05,0.1},
    --[mod.VMSState.IDLE] = 	    {0,	  0,	0,    0,	0,    0,	0,    1,	0.04,0.05,0.1},
    [mod.VMSState.FLAME] =  	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.SUMMON] = 	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.IPECAC] = 	{0,   0.8,  0,    0,    0,    0,    0.2,  0,    0,   0,   0},
    [mod.VMSState.JUMPS] =  	{0,   0.6,  0,    0,    0.1,  0,    0.1,  0,    0,   0.2, 0},
    [mod.VMSState.BLAZE] =  	{0,   0.75, 0,    0,    0,    0,    0,    0.25, 0,   0,   0},
    [mod.VMSState.KISS] = 	    {0,   0.1,  0.45,  0,    0,    0,   0,    0,    0,   0.45,0},
    --[mod.VMSState.KISS] = 	    {0,	  0,	0,    0,	0,    0,	0,    1,	0.04,0.05,0.1},
    [mod.VMSState.SWARM] =  	{0,   0.8,  0,    0,    0.15, 0,    0,    0,    0.05,0,   0},
    [mod.VMSState.SLAM] =   	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.LIT] =    	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0}
    
}--]]
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

    kissSpeed = 25,
    kissHomming = 0.7,

    nSlamFireRing = 10,
    nSlamSpinRing = 5,
    nSlamFireball = 6,

    sirenResummonRate = 7,
    sirenSummons = 8,
    coloJumpSpeed = 15,

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
            
        elseif data.State == mod.VMSState.KISS then
            mod:VenusKiss(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.FLAME then
            mod:VenusFlamethrower(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.IPECAC then
            mod:VenusIpecac(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.BLAZE then
            mod:VenusBlaze(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.SWARM then
            mod:VenusSwarm(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.SLAM then
            mod:VenusSlam(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.LIT then
            mod:VenusLit(entity, data, sprite, target,room)
        elseif data.State == mod.VMSState.JUMPS then
            --mod:VenusJumps(entity, data, sprite, target,room) --Too many attacks, need to make space for the summons
            data.State = mod:MarkovTransition(data.State, mod.chainV)
            data.StateFrame = 0
        elseif data.State == mod.VMSState.SUMMON then
            mod:VenusSummon(entity, data, sprite, target,room)
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

        flame:GetData().IsFlamethrower_HC = true
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

                flame:GetData().IsFlamethrower_HC = true

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
        if #mod:GetCandles() == 0 then
            sprite:Play("Summon",true)
        else
            data.State = mod.VMSState.IDLE
            data.State = mod:MarkovTransition(data.State, mod.chainV)
            data.StateFrame = 0
        end
    elseif sprite:IsFinished("Summon") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0
    
    elseif sprite:IsEventTriggered("Summon") and #mod:GetCandles() == 0 then
        candle = mod:SpawnEntity(mod.Entity.Candle, game:GetRoom():GetRandomPosition(0), Vector.Zero, entity)
        candle.Parent = entity
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

            fireball:GetData().IsFireball_HC = true
            
            fireball.FallingSpeed = -5
            fireball.FallingAccel = 1.5
            
            fireball:AddProjectileFlags(ProjectileFlags.FIRE_SPAWN)
        end
        
        for i=1, mod.VConst.nBlazesFast do
            local targetPos = target.Position:Rotated((2*rng:RandomFloat()-1)*mod.VConst.blazeAngleFast)
            local velocity = (targetPos - entity.Position):Normalized()*mod.VConst.blazeSpeedFast*(0.5 + 0.7*rng:RandomFloat())
            local fireball = mod:SpawnEntity(mod.Entity.Fireball, entity.Position, velocity, entity):ToProjectile()

            fireball:GetData().IsFireball_HC = true

            fireball.FallingSpeed = -5
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
        local variance = (Vector(mod:RandomInt(-15, 15),mod:RandomInt(-15, 15))*0.03)
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
        if mod:GetUnburnedPlayer() ~= nil then
            sprite:Play("Kiss",true)
        else
            data.State = mod:MarkovTransition(data.State, mod.chainV)
            data.StateFrame = 0
        end
    elseif sprite:IsFinished("Kiss") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Kiss") then
        local target = mod:GetUnburnedPlayer()
        if target == nil then target = game:GetPlayer(0) end

		local player_direction = target.Position - entity.Position
        local velocity = player_direction:Normalized()*mod.VConst.kissSpeed
        local kiss = mod:SpawnEntity(mod.Entity.Kiss, entity.Position, velocity, entity):ToProjectile()
		kiss.FallingAccel  = -0.1
		kiss.FallingSpeed = 0
        kiss.HomingStrength = mod.VConst.kissHomming

        kiss:AddProjectileFlags(ProjectileFlags.SMART)
        --kiss:AddProjectileFlags(ProjectileFlags.FIRE_SPAWN)

        kiss:GetData().IsKiss_HC = true

    end
end
function mod:VenusSwarm(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        if #(mod:FindByTypeMod(mod.Entity.Ulcers)) >= 4 then
            data.State = mod:MarkovTransition(data.State, mod.chainV)
            data.StateFrame = 0
        else
            sprite:Play("Swarm",true)
        end
    elseif sprite:IsFinished("Swarm") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Summon") then
        if #(mod:FindByTypeMod(mod.Entity.Ulcers))<4 then
            local butter = mod:SpawnEntity(mod.Entity.Ulcers, entity.Position, Vector.Zero, entity)
            sfx:Play(SoundEffect.SOUND_SUMMONSOUND,1)
        end
    end
end
function mod:VenusSlam(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Slam",true)
    elseif sprite:IsFinished("Slam") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Slam") then
        local flame = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_FIRE, 0, entity.Position, Vector.Zero, entity):ToProjectile()
        flame:AddProjectileFlags(ProjectileFlags.FIRE_WAVE)
        flame:Die()
        
        local flame = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_FIRE, 0, entity.Position, Vector.Zero, entity):ToProjectile()
        flame:AddProjectileFlags(ProjectileFlags.FIRE_WAVE_X)
        flame:Die()

        game:ShakeScreen(20)
    elseif sprite:IsEventTriggered("Slam2") then
        for i=1, mod.VConst.nSlamFireRing do
            local angle = i*360/mod.VConst.nSlamFireRing
            local velocity = Vector(1,0):Rotated(angle)*mod.VConst.flameSpeed*1.5
            local flame = mod:SpawnEntity(mod.Entity.Flame, entity.Position, velocity, entity):ToProjectile()
            flame.FallingAccel  = -0.1
            flame.FallingSpeed = 0
            flame.Scale = 2
    
            flame:GetData().IsFlamethrower_HC = true
            flame:GetData().NoGrow = true
            flame:GetData().EmberPos = -20
        end
    elseif sprite:IsEventTriggered("Slam3") then
        for i=1, mod.VConst.nSlamFireball do
            local angle = i*360/mod.VConst.nSlamFireball
            local velocity = Vector(1,0):Rotated(angle)*mod.VConst.blazeSpeedSlow
            local fireball = mod:SpawnEntity(mod.Entity.Fireball, entity.Position, velocity, entity):ToProjectile()

            fireball:GetData().IsFireball_HC = true
            
            fireball.FallingSpeed = -10
            fireball.FallingAccel = 1.5
            
            fireball:AddProjectileFlags(ProjectileFlags.FIRE_SPAWN)
        end

    end
end
function mod:VenusLit(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        local candleList = Isaac.FindByType(mod.EntityInf[mod.Entity.Candle].ID,mod.EntityInf[mod.Entity.Candle].VAR,mod.EntityInf[mod.Entity.Candle].SUB)
        if #(candleList) > 0 and not candleList[1]:GetSprite():IsPlaying("IdleLit") then
            sprite:Play("Kiss",true)
        else
            data.State = mod.VMSState.IDLE
            data.State = mod:MarkovTransition(data.State, mod.chainV)
            data.StateFrame = 0
        end
    elseif sprite:IsFinished("Kiss") then
        data.State = mod:MarkovTransition(data.State, mod.chainV)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Kiss") and #mod:GetCandles() > 0 then
		local candle_direction = mod:GetCandles()[1].Position - entity.Position
        local velocity = candle_direction:Normalized()*mod.VConst.kissSpeed
        local kiss = mod:SpawnEntity(mod.Entity.Kiss, entity.Position+velocity*2, velocity, entity):ToProjectile()
		kiss.FallingAccel  = -0.1
		kiss.FallingSpeed = 0

        kiss:AddProjectileFlags(ProjectileFlags.HIT_ENEMIES)

        kiss:GetData().IsKiss_HC = true
    end
end

--Move
function mod:VenusMove(entity, data, room, target, speed)   
    if speed == nil then speed = 1 end
    --idle move taken from 'Alt Death' by hippocrunchy
    --It just basically stays around a something
    
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

--Get random player thats not burning
function mod:GetUnburnedPlayer()
    local unburnedPlayers = {}
	for i=0, game:GetNumPlayers ()-1 do
		local player = game:GetPlayer(i)
		if player:GetData().BurnTime and player:GetData().BurnTime <= 0 then 
			unburnedPlayers[#unburnedPlayers+1]=player
		end
	end
    if #unburnedPlayers > 0 then
        local player =  unburnedPlayers[mod:RandomInt(1,#unburnedPlayers)]
        return player
    end
    return nil
end

--Get candle summons
function mod:GetCandles()
    local candles = Isaac.FindByType(mod.EntityInf[mod.Entity.Candle].ID,mod.EntityInf[mod.Entity.Candle].VAR)
    return candles
end

--Is there a Lilith?
function mod:IsThereLilith()
    for i=0, game:GetNumPlayers ()-1 do
		local player = game:GetPlayer(i)
		if player:GetPlayerType() == PlayerType.PLAYER_LILITH then 
			return true
		end
	end
    return false
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


--TERRA---------------------------------------------------------------------------------------------------
--[[
@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@&%%%%%%@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@############%%%%%%%%&&%&&&@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@%################%%#####%%%%%%&@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@
@@@@%################%%%%%%%%%%%%%###&@@@@@@@@@@@@@@@@&@@@@@@@@@@@@&@@@@@@@@@@@@
@@@@%#############%%%%%%%%%%%%###&&%%%&&&@@@&%%&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@%###########%%%%%%%%%%%%%%%#&#((/*****************/((#(%&@@@@@@@@@@@@@@@@@@@@
@@@%##########%%%%%%%%%%%%%%%%(/*,.,,.  ..          ..,,,,,,**(&@@@@@@@@@@@@@@&@
@@@&(#####%##%%%%%%&&&%&&%(/,,,,,,,,                 ..... .,,,,*#&&%@@@@@@@@@@@
@@@#(####%%%%%%%%%&%%&%#(*,....,,,,,,,,,,,                     .,,,*(##&@@@@@@@@
@@%#####%%%%%%&%&&&%%#(*,..........,,,,,,,,,***,*****,            ...*(#%@@@@@@@
@@######%%&&&&&&&&&%#(///*,,,,,,,,,,,,,,,,,,,,,,,*********    .. ,,,,,,*(%@&@@@@
@@@####%%%&&&&&&@%%((/////*,,,***///////***/*****////,,***********.,,,***(@@@@@@
@@@%####%%%&&&&&%/*,,*****//////////////////////((/((((/*******,,***,,****(@@@@@
@@@%####%%%&&&&%/,,****/*//((((//(((((((((((((((((((((((((((((((/*,*****,,*/%@@@
@@@%%%%%%&&&&@&#/*(////(((((((((((((((((((((((((((##############((//////,,,*(#@@
@@@@&&&&&&&&&@%(/((((((#%%&&%((((#######(((((((#(######%%%%%%%#####(//***,,,/#%@
@@@@@@@@%%%@@@#(/###%%&&&&&&@@@@%###############%%@@@@@@@&&&&&%%%%#%(////*,*/(#@
@@@@@@@@@@@@@&#((%&&&&&&@@@@@@@@@@%%%%%%%%%%%%%%@@@@@@@@@@@&&&&%#####/////**/#@@
@@@@@@@@@@@@@&#((%&&&&@@@@&@@@@@@@@%%%%%%%%%%%%@@@@@@@@@@@@@&&&&&%%%#%((((((#@@@
@@@@@@@@@@@@@@#///%&&&&&/(&(*&@@@@&%%%%%%%%%%%%&@@@@((#(&@@@&&&&&#(//((((((#%@@@
@@@@@@@@@@@@@&%/**/(/((#%%#%&&&@@&%%%%%%%%%%%%%%%@@@@#(&@@@&##(#//(((((((((#&@@@
@@@@@@@@@@@@@@&#/**(/.,.,..*(&&%%%%%%%%%%%%%%%%%%%%%@(..,,((/((#((((((((((#&@@@@
@@@@@@@@@@@@@@@@%(///./(((((%%%%%%%%%%%%%%%%%%%%%%%##((*((/(,///////*****/&@@@@@
@@@@@@@@@@@@@@@@&%(***,/,,/((%&&&@@@@@@@&&%&%%&@@@@&#(((////,///********/(&@@@@@
@@@@@@@@@@@@@@@@@@&#**. ,*///##%%&&@@@@@@@@@@@@@@@&%//(/((,*////*****,*/((@@@@@@
@@@@@@@@@@@@@@@@@@@@&(****///*/(%%%%%&&&&@@@@@@@@@/**(#,.(..((//***,*/((@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@#%%(/////////(%%%%&&&&&&&&&(/////##(((/////***(%@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@##(////(((((((((((((((((/////(/(/(///*#&@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#&#((///////(//((//((((((((////((/*@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&%%###(((((#######%%&%@@&%@@@@@@@@@@@%%@@@%%@%%
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%@%@@@@%@@@@
]]--


--MARS---------------------------------------------------------------------------------------------------
--[[
@@@@@@@@@@@@@@@@@@@@@@@@&@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@&&&&&&&&&@@@/@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@&@@@@@@@@@@@@@@@@&&&&&&&&&&&&&&&&&@@*@@@@,@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@&@@&@@@@@@@@@@&&&&&&&&&&&&&&&&&&&&&&&@@%%@@&*@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@&&&&&&@@@&&&&&&&&&&&&&&&&&&@@@@%%@@@@@@@@@@@@@@@@@@@@%@@@%@
@@@@@@@@@@@@&&@@@@@@@@@@@&&&@@&&&@&&&&&&&&&&&&&&&&@@&@@@@@@@@@@@@&&&&@@@@#@@#@##
@@@@@@@@@@@&@@@@@@@@@@@@@&&&@&&&@@&&&@@@@@@@@@@&&&&&@@@@@@@@@@@@@@@&&&@@@@#@@@@#
@@@@@@@@@@@@@@@@@@@@@@@@@&&@@&&&@&@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@&@@@@
@@@@@@&@@@@@@@@@@@@@@@@@@&&@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@@@@@@@@@@@@
@@@@@@@@@@@&@@@@@@@@@@@@@@&%########%&@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&@@@@@@@@@&
@@@@@@@@@&&&&@@@@@@@@/%%(  (#############%#@@@@@@@@@@@@@@@@@&&&&&&&&&&&&@@@@@@@@
@@@@@@@@&&&&&@@@&@@@@@#(###&@@#@@@########@@@@@@@& &@@@@@&&&&&&&&&&&&&&&&&@&@@@@
@@@@@@@@&&&&&&&@@@@@@&  (#@@#&@@@@@@######&&@@@@@@@@@&&&&&&&&&&&&&&&&&&&&&&&&@@@
@@@@@@@@@&&&&&&&&&&&&&###%@@#@&@@&&@######&@&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&@@@@@@
@@@@@@@@@@&&&&&&&&&&@@&####@@@#@@@%#### ,%@&&&&&&&&&&&&&&&&&&&&&&&&&&&@@@@@@@@@@
@@@@@@@@@@@@&&&&&@@#&&@@%###########,  #@@@@&#@@@@&&&&&&&&&&&&&&&&@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@&/&&&&&@@@@@@@@@@@@@@@&&&&@@%(#.&@@@@@@&&&&&&@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@*&&&@@&&&&&&&&&&&&&&&&&&&&&&&@@@//%*@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@&&&@@@@@@&&&&&&&&&&@@@@@@@@@&&@@&(%#@&*@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&@@@@@@@@@@@@@@@@&@@@(@*@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@@@(@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
]]--

mod.MMSState = {
    APPEAR = 0,
    MOVE = 1,
    UP = 2,
    DOWN = 3,
    LEFT = 4,
    RIGHT = 5,
    ATTACK = 6,
    CLOCK = 7,
    LASER = 8,
    MISSILES = 9,
    AIRSTRIKE = 10,
    DRONES = 11,
    CHARGE = 12,
    SHOTS = 13,
    HOMING = 14
}
mod.chainM = {--                 App   Mov    UP     DOWN   LEFT   RIGHT  Atk    Clock  Laser   Miss    Air     Drone   Charge  Shot   Hom
    [mod.MMSState.APPEAR] =     {0,    1,     0,     0,     0,     0,     0,     0,     0,      0,      0,      0,      0,      0,     0},
    [mod.MMSState.MOVE] =       {0,    0,     0.25,  0.25,  0.25,  0.25,  0,     0,     0,      0,      0,      0,      0,      0,     0},
    --[mod.MMSState.UP] =         {0,    0,     0.18,  0.22,  0.25,  0.25,  0.1,   0,     0,      0,      0,      0,      0,      0,     0},
    --[mod.MMSState.DOWN] =       {0,    0,     0.22,  0.18,  0.25,  0.25,  0.1,   0,     0,      0,      0,      0,      0,      0,     0},
    --[mod.MMSState.LEFT] =       {0,    0,     0.25,  0.25,  0.18,  0.22,  0.1,   0,     0,      0,      0,      0,      0,      0,     0},
    --[mod.MMSState.RIGHT] =      {0,    0,     0.25,  0.25,  0.22,  0.18,  0.1,   0,     0,      0,      0,      0,      0,      0,     0},
    [mod.MMSState.UP] =         {0,    0,     0.24,  0.22,  0.22,  0.22,  0.10,  0,     0,      0,      0,      0,      0,      0,     0},
    [mod.MMSState.DOWN] =       {0,    0,     0.22,  0.24,  0.22,  0.22,  0.10,  0,     0,      0,      0,      0,      0,      0,     0},
    [mod.MMSState.LEFT] =       {0,    0,     0.22,  0.22,  0.24,  0.22,  0.10,  0,     0,      0,      0,      0,      0,      0,     0},
    [mod.MMSState.RIGHT] =      {0,    0,     0.22,  0.22,  0.22,  0.24,  0.10,  0,     0,      0,      0,      0,      0,      0,     0},
    [mod.MMSState.ATTACK] =     {0,    0,     0,     0,     0,     0,     0,     0.05,  0.14,   0.1,    0.1,    0.1,    0.14,   0.3,   0.7},
    [mod.MMSState.CLOCK] =      {0,    1,     0,     0,     0,     0,     0,     0,     0,      0,      0,      0,      0,      0,     0},
    [mod.MMSState.LASER] =      {0,    0.3,   0,     0,     0,     0,     0,     0,     0.3,    0.3,    0,      0,      0.1,    0,     0},
    [mod.MMSState.MISSILES] =   {0,    0.5,   0,     0,     0,     0,     0,     0,     0,      0.2,    0.2,    0,      0.1,    0,     0},
    [mod.MMSState.AIRSTRIKE] =  {0,    1,     0,     0,     0,     0,     0,     0,     0,      0,      0,      0,      0,      0,     0},
    [mod.MMSState.DRONES] =     {0,    0.5,   0,     0,     0,     0,     0,     0.2,   0,      0,      0,      0,      0,      0.1,   0.2},
    [mod.MMSState.CHARGE] =     {0,    0.2,   0,     0,     0,     0,     0,     0,     0.4,    0.4,    0,      0,      0,      0,     0},
    [mod.MMSState.SHOTS] =      {0,    0.15,  0,     0,     0,     0,     0,     0,     0,      0,      0.25,   0,      0,      0.6,   0},
    [mod.MMSState.HOMING] =     {0,    1,     0,     0,     0,     0,     0,     0,     0,      0,      0,      0,      0,      0,     0}
}
mod.MConst = {
    speed = 2.1,

    chargeSpeed = 70,
    chargeExplosionRadius = 50,
    explosionDamage = 300,

    nRowShots = 3,
    nShots = 3,
    shotAngle = 20,
    shotSpeed = 6,

    missileExplosionDamage = 50,
    missileExplosionRadius = 20,
    nMissileTears = 8,
    missileTearsSpeed = 15,
    missileSpeed = 9,
    missileTime = 20,

    nTargets = 6,
    airstrikeExplosionRadius = 90,
}

local PickedIndexes = {}

local airstrikesIndexes = { 
    32, 35, 39, 42,  
    62, 65, 69, 72,  
    92, 95, 99, 102}

function mod:MarsUpdate(entity)
    if entity.Variant == mod.EntityInf[mod.Entity.Mars].VAR and entity.SubType == mod.EntityInf[mod.Entity.Mars].SUB then
        local data = entity:GetData()
        local sprite = entity:GetSprite()
        local target = entity:GetPlayerTarget()
        local room = game:GetRoom()
        
        --Custom data:
        if data.State == nil then data.State = 0 end
        if data.SecondState == nil then data.SecondState = 0 end
        if data.StateFrame == nil then data.StateFrame = 0 end
        if data.TargetPos == nil then data.TargetPos = Vector.Zero end
        if data.ExtraLaserCount == nil then data.ExtraLaserCount = 0 end
        if data.Laser == nil then data.Laser = false end
        if data.TargetDirection == nil then data.TargetDirection = Vector.Zero end
        if data.Move == nil then data.Move = false end
        if data.IsMartian == nil then data.IsMartian = true end
        
        --Frame
        data.StateFrame = data.StateFrame + 1
        
        if data.State == mod.MMSState.APPEAR then
            if data.StateFrame == 1 then
                mod:AppearPlanet(entity)
                entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
            elseif sprite:IsFinished("Appear") or sprite:IsFinished("AppearSlow") then
                data.State = mod:MarkovTransition(data.State, mod.chainM)
                data.StateFrame = 0
            elseif sprite:IsEventTriggered("EndAppear") then
                entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL

                local deimos = mod:SpawnEntity(mod.Entity.Deimos, entity.Position, Vector.Zero, entity)
                deimos.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                deimos.Parent = entity
                deimos:GetSprite():Play("Idle",true)
                deimos:GetSprite().PlaybackSpeed = 0.5
                local data = deimos:GetData()
                data.IsMartian = true
                data.orbitIndex = 0
                data.orbitTotal = 2
                data.orbitSpin = 1
                data.orbitSpeed = 3.1891
                data.orbitDistance = 23.436
                
                local phobos = mod:SpawnEntity(mod.Entity.Phobos, entity.Position, Vector.Zero, entity)
                phobos.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                phobos.Parent = entity
                phobos:GetSprite():Play("Idle",true)
                phobos:GetSprite().PlaybackSpeed = 0.5
                local data = phobos:GetData()
                data.IsMartian = true
                data.orbitIndex = 1
                data.orbitTotal = 2
                data.orbitSpin = 1
                data.orbitSpeed = 12.6244
                data.orbitDistance = 9.377
            end  
        elseif data.State == mod.MMSState.UP or data.State == mod.MMSState.DOWN or data.State == mod.MMSState.LEFT or data.State == mod.MMSState.RIGHT then
            if data.StateFrame == 1 then
                sprite:Play("Idle",true)
            elseif sprite:IsFinished("Idle") then
                data.SecondState = data.State
                data.State = mod:MarkovTransition(data.State, mod.chainM)
                data.StateFrame = 0
            else
                mod:MarsMove(entity, data, room, target)
            end
        elseif data.State == mod.MMSState.MOVE or data.State == mod.MMSState.ATTACK then
            data.State = mod:MarkovTransition(data.State, mod.chainM)
            data.StateFrame = 0

        elseif data.State == mod.MMSState.CLOCK then
            mod:MarsClock(entity, data, sprite, target,room)
        elseif data.State == mod.MMSState.LASER then
            mod:MarsLaser(entity, data, sprite, target,room)
        elseif data.State == mod.MMSState.MISSILES then
            mod:MarsRocket(entity, data, sprite, target,room)
        elseif data.State == mod.MMSState.AIRSTRIKE then
            mod:MarsAirstrike(entity, data, sprite, target,room)
        elseif data.State == mod.MMSState.DRONES then
            mod:MarsDrones(entity, data, sprite, target,room)
        elseif data.State == mod.MMSState.CHARGE then
            mod:MarsCharge(entity, data, sprite, target,room)
        elseif data.State == mod.MMSState.SHOTS then
            mod:MarsShots(entity, data, sprite, target,room)
        elseif data.State == mod.MMSState.HOMING then
            mod:MarsHoming(entity, data, sprite, target,room)
        end
    end
end
function mod:MarsCharge(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Charge",true)
    elseif sprite:IsFinished("Charge") then
        entity.Velocity = Vector.Zero
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0
    elseif entity:CollidesWithGrid() then
        game:ShakeScreen(35)
		sfx:Play(SoundEffect.SOUND_ROCK_CRUMBLE,1.5);

		--Explosion:
		local explosion = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, entity.Position, Vector.Zero, entity):ToEffect()
        explosion.DepthOffset = 10
		--Explosion damage
		for i, entity in ipairs(Isaac.FindInRadius(entity.Position, mod.MConst.chargeExplosionRadius)) do
			if entity.Type ~= EntityType.ENTITY_PLAYER and not entity:GetData().IsMartian then
				entity:TakeDamage(mod.MConst.explosionDamage, DamageFlag.DAMAGE_EXPLOSION, EntityRef(entity), 0)
			end
		end

        entity.Velocity = Vector.Zero
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0
        
    elseif sprite:IsEventTriggered("SetAim") then
        data.TargetPos = target.Position
        entity.Velocity = Vector.Zero
    elseif sprite:IsEventTriggered("Charge") then
        entity.Velocity = (data.TargetPos - entity.Position):Normalized()*mod.MConst.chargeSpeed
    end
end
function mod:MarsLaser(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Laser",true)
    elseif sprite:IsFinished("Laser") then
        data.Laser = false
        data.ExtraLaserCount = 0
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("SetAim") then
        data.TargetPos = target.Position
        entity.Velocity = Vector.Zero
    elseif sprite:IsEventTriggered("Laser") then
        data.Laser = true
        data.TargetDirection = (data.TargetPos - entity.Position):Normalized()
        local direction = data.TargetDirection
		local laser = EntityLaser.ShootAngle(1, entity.Position + Vector(0,-40) + direction*45 , direction:GetAngleDegrees(), 85, Vector.Zero, entity)
        --data.LaserEnd = laser.EndPoint()
    elseif sprite:IsEventTriggered("ExtraLaser") then
        data.ExtraLaserCount = data.ExtraLaserCount + 1
        local distance = 140*data.ExtraLaserCount + mod:RandomInt(-40,40)
        local direction = data.TargetDirection
        local position = entity.Position + Vector(0,-40) + direction*distance
        if not mod:IsOutsideRoom(position, room) then 
            local laser1 = EntityLaser.ShootAngle(1,position , direction:GetAngleDegrees()+90, 25, Vector.Zero, entity)
            local laser2 = EntityLaser.ShootAngle(1,position , direction:GetAngleDegrees()-90, 25, Vector.Zero, entity)
        end
    end

    if data.Laser then
        data.targetvelocity = -data.TargetDirection
        entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * mod.MConst.speed
    end

    if entity:CollidesWithGrid() then
        entity.Velocity = Vector.Zero
    end
end
function mod:MarsAirstrike(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Airstrike",true)
    elseif sprite:IsFinished("Airstrike") then
        for n,i in pairs(PickedIndexes) do
            PickedIndexes[n] = nil
        end
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("EndIdle") then
        data.SecondState = mod.chainM2[mod:RandomInt(1,#mod.chainM2)]

    elseif sprite:IsEventTriggered("Missile") then
        --[[
        for i=1, mod.MConst.nTargets do
            --local position = room:GetRandomTileIndex(mod:RandomInt(1,1000))
            local position = mod:RandomInt(16,118)

            local flag = false
            if PickedIndexes[position] == nil then
                PickedIndexes[position]=true
            else
                flag = true
            end

            if position%3 == 0 and not flag then
                local target = mod:SpawnEntity(mod.Entity.MarsTarget, room:GetGridPosition(position), Vector.Zero, entity)
                target.Parent = entity
            end
        end]]
        for n,i in pairs(airstrikesIndexes) do
            local target = mod:SpawnEntity(mod.Entity.MarsTarget, room:GetGridPosition(airstrikesIndexes[n]), Vector.Zero, entity)
            target.Parent = entity
        end
        --local target = mod:SpawnEntity(mod.Entity.MarsTarget, room:GetCenterPos(), Vector.Zero, entity)
        --target.Parent = entity
    end

    mod:MarsMove(entity, data, room, target, true)

end
function mod:MarsClock(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Idle",true)
    elseif sprite:IsFinished("Idle") then
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0
    end
end
function mod:MarsRocket(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Rocket",true)
    elseif sprite:IsFinished("Rocket") then
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0
    end
end
function mod:MarsDrones(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Idle",true)
    elseif sprite:IsFinished("Idle") then
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0
    end
end
function mod:MarsShots(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Shot",true)
    elseif sprite:IsFinished("Shot") then
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0
        
    elseif sprite:IsEventTriggered("Shot") then
        if (target.Position - entity.Position):Length() >= 200 then
            for j=1, mod.MConst.nRowShots do
                local targetAim = target.Position - entity.Position
                for i=0, mod.MConst.nShots-1 do
                    local angle = -mod.MConst.shotAngle/2 + mod.MConst.shotAngle / (mod.MConst.nShots-1) * i
                    local velocity = targetAim:Normalized():Rotated(angle)*mod.MConst.shotSpeed*(1/(j^0.5))
                    local shot = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, velocity, entity):ToProjectile()
                    shot.FallingSpeed = 0
                    shot.FallingAccel = -0.1
                    shot:AddProjectileFlags(ProjectileFlags.ACCELERATE)
                    shot.Acceleration = 1.02
                end
            end
        end
    end
    
    mod:MarsMove(entity, data, room, target, true)

end
function mod:MarsHoming(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Homing",true)
    elseif sprite:IsFinished("Homing") then
        data.Move = false 
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0
        
    elseif sprite:IsEventTriggered("StartIdle") then
        data.Move = true

    elseif sprite:IsEventTriggered("EndIdle") then
        data.SecondState = mod.chainM2[mod:RandomInt(1,#mod.chainM2)]

    elseif sprite:IsEventTriggered("Missile") then
        for i=0, 1 do
            local angle = (1 + i)*180
            local velocity = Vector(1,0):Rotated(angle+mod:RandomInt(-30,30))*mod.MConst.missileSpeed*(0.5*rng:RandomFloat()+0.5)
            local missile = mod:SpawnEntity(mod.Entity.Missile, entity.Position, velocity, entity)
            missile.Parent = entity

            missile:GetData().IsMissile_HC = true
        end
    end

    if data.Move then
        mod:MarsMove(entity, data, room, target, true)
    end
end

--Move
mod.marsDirections = {
    [mod.MMSState.UP] = Vector(0,1),
    [mod.MMSState.DOWN] = Vector(0,-1),
    [mod.MMSState.RIGHT] = Vector(1,0),
    [mod.MMSState.LEFT] = Vector(-1,0)
}
mod.chainM2 = {
    [1] = mod.MMSState.UP,
    [2] = mod.MMSState.DOWN,
    [3] = mod.MMSState.LEFT,
    [4] = mod.MMSState.RIGHT
}
mod.marsMovesOposites = {
    [mod.MMSState.UP] = mod.MMSState.DOWN,
    [mod.MMSState.DOWN] = mod.MMSState.UP,
    [mod.MMSState.RIGHT] = mod.MMSState.LEFT,
    [mod.MMSState.LEFT] = mod.MMSState.RIGHT
}
function mod:MarsMove(entity, data, room, target, secondState)
    local state = data.State
    if secondState then state = data.SecondState end

    local speed = 1
    local distanceFromPlayer = entity.Position:Distance(target.Position)
    if distanceFromPlayer < 150 then
        local varX = entity.Position.X - target.Position.X
        local varY = entity.Position.Y - target.Position.Y

        if varX > 0 then --player left
            if varY > 0 then--player down
                if math.abs(varX) > math.abs(varY) then
                    state = mod.MMSState.RIGHT
                    --state = mod.MMSState.UP
                else
                    state = mod.MMSState.UP
                    --state = mod.MMSState.RIGHT
                end
            else--player up
                if math.abs(varX) > math.abs(varY) then
                    state = mod.MMSState.RIGHT
                    --state = mod.MMSState.DOWN
                else
                    state = mod.MMSState.DOWN
                    --state = mod.MMSState.RIGHT
                end
            end
        else --player right
            if varY > 0 then--player down
                if math.abs(varX) > math.abs(varY) then
                    state = mod.MMSState.LEFT
                    --state = mod.MMSState.UP
                else
                    state = mod.MMSState.LEFT
                    --state = mod.MMSState.UP
                end
            else--player up
                if math.abs(varX) > math.abs(varY) then
                    state = mod.MMSState.LEFT
                    --state = mod.MMSState.DOWN
                else
                    state = mod.MMSState.DOWN
                    --state = mod.MMSState.LEFT
                end
            end
        end

        if distanceFromPlayer < 80 then 
            entity.Velocity = Vector.Zero 
            speed = 10
        end
    end

    data.targetvelocity = mod.marsDirections[state]
    if state == mod.MMSState.LEFT or state == mod.MMSState.RIGHT then
        entity.Velocity = Vector(entity.Velocity.X,0)
    else
        entity.Velocity = Vector(0,entity.Velocity.Y*0.95)
    end
    
	--Change direction if collision
	if entity:CollidesWithGrid() then
        entity.Velocity = Vector.Zero
        --state = mod.marsMovesOposites[state]
        state = mod.marsMovesOposites[mod:RandomInt(2,5)]
    end

    --Do the actual movement
    entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * mod.MConst.speed * speed
    if entity.Velocity:Length() > 20 then entity.Velocity = entity.Velocity:Normalized()*20 end

    if secondState then 
        data.SecondState = state
    else
        data.State = state
    end

    
    local hemo = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HAEMO_TRAIL, 0, entity.Position + Vector(0,-50), Vector.Zero, entity)
    hemo:GetSprite().Scale = Vector.One * 0.8
    hemo:GetSprite().PlaybackSpeed = 0.6
    hemo:GetSprite().Color = Color(10,0,0,1)
end

--ded
function mod:MarsDeath(entity)
    if entity.Variant == mod.EntityInf[mod.Entity.Mars].VAR then

        for _, e in ipairs(mod:FindByTypeMod(mod.Entity.Mars)) do
            if e.Variant ~= mod.EntityInf[mod.Entity.Mars].VAR then
                e.Die()
            end
        end

        --Fart:
        mod:NormalDeath(entity)
    end
end
--deding
function mod:MarsDying(entity)
    
    local sprite = entity:GetSprite()
    local data = entity:GetData()

end


function mod:OrbitParent(entity)
	local data = entity:GetData()
	if (not data.orbitAngle) then
	  data.orbitAngle = data.orbitIndex*360/data.orbitTotal
	end
	if entity.Parent then
		entity.Position  = entity.Parent.Position + Vector.FromAngle(data.orbitAngle):Resized(data.orbitDistance*3)
		data.orbitAngle = (data.orbitAngle + data.orbitSpin*data.orbitSpeed) % 360
	end

end

--Callbacks
--Mars updates
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.MarsUpdate, mod.EntityInf[mod.Entity.Mars].ID)
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.MarsDeath, mod.EntityInf[mod.Entity.Mars].ID)