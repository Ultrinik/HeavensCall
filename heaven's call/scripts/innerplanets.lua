local mod = HeavensCall
local game = Game()
local rng = RNG()
local sfx = SFXManager()
local music = MusicManager()
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
  
mod.MRMSState = {
    APPEAR = 0,
    IDLE = 1,
    CIRCLE = 2,
    LINES = 3,
    SPINDASH = 4,
    DOUBLESPINDASH = 5,
    HORN = 6,
    SIDEJUMPS = 7,
    DRILL = 8,
    BIRDS = 9
}
mod.chainMR = {--                        A     I      Circ   Line   Spin   DSpin   Horn   Side   Drill  Brid
    [mod.MRMSState.APPEAR] = 	        {0,     1,     0,     0,     0,     0,      0,     0,     0,     0},
    [mod.MRMSState.IDLE] = 	            {0, 	0.709, 0.025, 0.02,	 0.058,	0.058,	0.04,  0.035, 0.04,	 0.015},
    --[mod.MRMSState.IDLE] = 	            {0,     0,     0,     0,     0,     0,      0,     0,     0,     1},
    --[mod.MRMSState.IDLE] = 	            {0,     0,     0,     0,     0,     0,      0,     0,     1,     0},
    [mod.MRMSState.CIRCLE] = 	        {0,	    0.7,   0,	  0,	 0.15,	0.15,	0,	   0,	  0,	 0},
    [mod.MRMSState.LINES] = 	        {0,	    0.6,   0.03,  0.01,	 0.12,	0.12,	0.12,  0,	  0,	 0},
    [mod.MRMSState.SPINDASH] = 	        {0,	    0.4,   0,	  0,	 0.3,	0.3,    0,	   0,	  0,	 0},
    [mod.MRMSState.DOUBLESPINDASH] = 	{0,	    0.4,   0,	  0,	 0.3,	0.3,    0,	   0,	  0,	 0},
    [mod.MRMSState.HORN] = 	            {0,	    0.7,   0,	  0,	 0.15,	0.15,	0,	   0,	  0,	 0},
    [mod.MRMSState.SIDEJUMPS] = 	    {0,	    0.7,   0,	  0,	 0,	    0,	    0,	   0,	  0.2,	 0.1},
    [mod.MRMSState.DRILL] = 	        {0,	    0.5,   0,	  0,	 0,	    0,	    0.4,   0,	  0,	 0.1},
    [mod.MRMSState.BIRDS] = 	        {0,	    1,	   0,	  0,	 0,	    0,	    0,	   0,	  0,	 0}
    
}
mod.MRConst = {--Some constant variables of Mercury
    idleTimeInterval = Vector(5,10),
    speed = 1.7,

    nJumps = 3,
    jumpSpeed = 45,
    nJumpProj = 8,

    nDrills = 14,
    nDrillProjectiles = 10,
    drillRockSpeed = 12,
    drillShotSpeed = 10,

    spindashSpeed = 75,
    maxBounces = 3,

    nBirds = 10,
    idleBirdTimeInterval = Vector(10,20),
    birdShotSpeed = 10,
    birdSpeed = 1.45,

    nLines = 4,
    lineSpeed = 70,
    nLineShots = 4,
    lineShotSpeed = 15,

    nCircles = 35,
    circleSpeed = 100,
    circlingDistance = 575,
    angleSpeed = 20,
    circleShotSpeed = 8,

    hornSpeed = 18,
    nHornDivisions = 12,

    trainsSpeed = 70,
}

function mod:MercuryUpdate(entity)
    if entity.Variant == mod.EntityInf[mod.Entity.Mercury].VAR and entity.SubType == mod.EntityInf[mod.Entity.Mercury].SUB then
        local data = entity:GetData()
        local sprite = entity:GetSprite()
        local target = entity:GetPlayerTarget()
        local room = game:GetRoom()
        
        --Custom data:
        if data.State == nil then 
            data.State = 0 
            data.StateFrame = 0

            data.JumpCount = 0
            data.DrillCount = 0
            data.TargetPos = target.Position
            data.TargetVel = target.Velocity
            data.IsSpindashing = false
            data.BounceCount = 0
            data.IsLining = false
            data.LineCount = 0
            data.IsCircling = false
            data.CircleCount = 0
            data.IsExploded = false
            data.TrainFlag = false
            data.TrainReady = false
            data.TrainDirection = -1
            data.Regen = false
        end
        
        --Frame
        data.StateFrame = data.StateFrame + 1
        
        if not data.TrainFlag and entity.HitPoints < entity.MaxHitPoints * 0.12 and data.State ~= mod.MRMSState.BIRDS then
            data.TrainFlag = true
            data.StateFrame = 0
        end

        if data.TrainFlag then
            mod:MercuryTrain(entity, data, sprite, target,room)
        else
            if data.State == mod.MRMSState.APPEAR then
                if data.StateFrame == 1 then
                    mod:AppearPlanet(entity)
                    entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                    entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
                elseif sprite:IsFinished("Appear") or sprite:IsFinished("AppearSlow") then
                    data.State = mod:MarkovTransition(data.State, mod.chainMR)
                    data.StateFrame = 0
                elseif sprite:IsEventTriggered("EndAppear") then
                    entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
                end
                
            elseif data.State == mod.MRMSState.IDLE then
                if data.StateFrame == 1 then
                    sprite:Play("Idle",true)
                elseif sprite:IsFinished("Idle") then
                    data.State = mod:MarkovTransition(data.State, mod.chainMR)
                    data.StateFrame = 0
                    
                else
                    mod:MercuryMove(entity, data, room, target)
                end
                
            elseif data.State == mod.MRMSState.CIRCLE then
                mod:MercuryCircle(entity, data, sprite, target,room)
            elseif data.State == mod.MRMSState.LINES then
                mod:MercuryLines(entity, data, sprite, target,room)
            elseif data.State == mod.MRMSState.SPINDASH then
                mod:MercurySpindash(entity, data, sprite, target,room)
            elseif data.State == mod.MRMSState.DOUBLESPINDASH then
                mod:MercuryDoubleSpindash(entity, data, sprite, target,room)
            elseif data.State == mod.MRMSState.HORN then
                mod:MercuryHorn(entity, data, sprite, target,room)
            elseif data.State == mod.MRMSState.SIDEJUMPS then
                mod:MercurySideJumps(entity, data, sprite, target,room)
            elseif data.State == mod.MRMSState.DRILL then
                mod:MercuryDrill(entity, data, sprite, target,room)
            elseif data.State == mod.MRMSState.BIRDS then
                mod:MercuryBirds(entity, data, sprite, target,room)
            end
        end


    end
end
function mod:MercuryCircle(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Rainbow",true)
    elseif sprite:IsFinished("Rainbow") then
        entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_NONE
        data.IsCircling = true
        music:PitchSlide(3.5)
        sprite:Play("Circle",true)
    elseif sprite:IsFinished("Circle") then
        if data.CircleCount >= mod.MRConst.nCircles then
            entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
            data.IsCircling = false
            data.MercuryTargetVector = nil
            data.CircleCount = 0
            music:ResetPitch()

            data.State = mod:MarkovTransition(data.State, mod.chainMR)
            data.StateFrame = 0
        else
            data.CircleCount = data.CircleCount + 1
            sprite:Play("Circle",true)


            local direction = (target.Position - entity.Position):Normalized()

            local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, direction*mod.MRConst.circleShotSpeed, entity):ToProjectile()
            tear:GetSprite().Color = mod.Colors.mercury
            tear.Height = -30
        end

    end

    local player = Isaac.GetPlayer(0)
    if data.IsCircling then
        if data.MercuryTargetVector == nil then
            data.MercuryTargetVector = (entity.Position - player.Position):Normalized() * mod.MRConst.circlingDistance
            data.MercuryTargetAngle = 0
        end
        
        data.MercuryTarget = player.Position + data.MercuryTargetVector:Rotated(data.MercuryTargetAngle)
        data.MercuryTargetAngle = (data.MercuryTargetAngle + mod.MRConst.angleSpeed)%360


        data.targetvelocity = ((data.MercuryTarget - entity.Position):Normalized()):Rotated(mod:RandomInt(-10, 10))

		--Do the actual movement
		entity.Velocity = data.targetvelocity * mod.MRConst.circleSpeed

    end

end
function mod:MercuryLines(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Rainbow",true)
    elseif sprite:IsFinished("Rainbow") then
        entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS_X
        data.IsLining = true
        music:PitchSlide(3.5)
        sprite:Play("Lines",true)
    elseif sprite:IsFinished("Lines") then
        if data.LineCount >= mod.MRConst.nLines then
            entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
            data.IsLining = false
            data.LineCount = 0
            music:ResetPitch()

            data.State = mod:MarkovTransition(data.State, mod.chainMR)
            data.StateFrame = 0
        else
            data.LineCount = data.LineCount + 1
            sprite:Play("Lines",true)


            for i=0, mod.MRConst.nLineShots-1 do
                mod:scheduleForUpdate(function()
                    local direction = (target.Position - entity.Position):Normalized()
                    local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, direction*mod.MRConst.lineShotSpeed, entity):ToProjectile()
                    tear:GetSprite().Color = mod.Colors.mercury
                end,i*5)
            end
        end

    end

    if data.IsLining then
        entity.Velocity = Vector(0, -mod.MRConst.lineSpeed)

        if entity.Position.Y < room:GetCenterPos().Y and mod:IsOutsideRoom(entity.Position + Vector(0,100), room) then
            if room:GetRoomShape() >= RoomShape.ROOMSHAPE_2x2 or room:GetRoomShape() == RoomShape.ROOMSHAPE_1x2 or room:GetRoomShape() == RoomShape.ROOMSHAPE_IIV then
                entity.Position = Vector(entity.Position.X, 696+ 300)
            else
                entity.Position = Vector(entity.Position.X, 417 + 300)
            end
        end
    end

end
function mod:MercurySpindash(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Spindash",true)
    elseif sprite:IsFinished("Spindash") or data.BounceCount >= mod.MRConst.maxBounces then
        data.IsSpindashing = false
        data.BounceCount = 0
        entity.CollisionDamage = 0
        data.State = mod:MarkovTransition(data.State, mod.chainMR)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("StartSpin") then
        entity.Velocity = Vector.Zero
        sfx:Play(Isaac.GetSoundIdByName("Spindash"),1)
        data.TargetPos = target.Position

    elseif sprite:IsEventTriggered("ReleaseSpin") then
        sfx:Play(Isaac.GetSoundIdByName("SpindashRelease"),1)
        data.IsSpindashing = true
        entity.CollisionDamage = 1

        local direction = (data.TargetPos - entity.Position):Normalized()
        entity.Velocity = direction * mod.MRConst.spindashSpeed

    elseif sprite:IsEventTriggered("Spin") then
        mod:MercurySplash(entity, 2, 2, (-data.TargetPos + entity.Position):GetAngleDegrees())
    end

    if data.IsSpindashing and entity:CollidesWithGrid() then
        entity.CollisionDamage = 0
        data.BounceCount = data.BounceCount + 1
        entity.Velocity = entity.Velocity:Normalized() * (mod.MRConst.spindashSpeed) * (mod.MRConst.maxBounces - data.BounceCount) / mod.MRConst.maxBounces
    end

end
function mod:MercuryDoubleSpindash(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Spindash",true)
    elseif sprite:IsFinished("Spindash2") then
        data.IsSpindashing = false
        entity.CollisionDamage = 0
        data.State = mod:MarkovTransition(data.State, mod.chainMR)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("StartSpin") then
        entity.Velocity = Vector.Zero
        sfx:Play(Isaac.GetSoundIdByName("Spindash"),1)
        data.TargetPos = target.Position

        
        --local laser = EntityLaser.ShootAngle(2,entity.Position , (target.Position - entity.Position):GetAngleDegrees(), 120, Vector.Zero, entity)

    elseif sprite:IsEventTriggered("ReleaseSpin") and sprite:GetAnimation() == "Spindash" then
        sprite:Play("Spindash2",true)
        entity.Velocity = Vector.Zero
        sfx:Play(Isaac.GetSoundIdByName("Spindash"),1)
        data.TargetPos2 = target.Position

        local a = data.TargetPos - entity.Position
        local b = data.TargetPos2 - entity.Position

        local cross = a:Cross(b)
        local extraAngle = math.asin( math.abs(cross) / (a:Length() * b:Length()) )
        extraAngle = extraAngle * 180 / math.pi
        if cross < 0 then extraAngle = - extraAngle end
        data.ExtraAngle = extraAngle
        
        --local laser = EntityLaser.ShootAngle(2,entity.Position , (target.Position - entity.Position):GetAngleDegrees(), 120, Vector.Zero, entity)

    elseif sprite:IsEventTriggered("ReleaseSpin") and sprite:GetAnimation() == "Spindash2" then
        data.IsSpindashing = true
        sfx:Play(Isaac.GetSoundIdByName("SpindashRelease"),1)
        entity.CollisionDamage = 1


        local direction = (data.TargetPos2 - entity.Position):Normalized():Rotated(data.ExtraAngle)

        --local laser = EntityLaser.ShootAngle(2,entity.Position , direction:GetAngleDegrees(), 120, Vector.Zero, entity)

        entity.Velocity = direction * mod.MRConst.spindashSpeed

    elseif sprite:IsEventTriggered("Spin") and sprite:GetAnimation() == "Spindash" then
        mod:MercurySplash(entity, 2, 2, (-data.TargetPos + entity.Position):GetAngleDegrees())
    elseif sprite:IsEventTriggered("Spin") and sprite:GetAnimation() == "Spindash2" then
        mod:MercurySplash(entity, 2, 2, (- (data.TargetPos2 - entity.Position):Rotated(data.ExtraAngle)):GetAngleDegrees())

    end

    if data.IsSpindashing and entity:CollidesWithGrid() then
        sprite:SetLastFrame()
        mod:MercurySplash(entity, 4, 0.8)
        entity.Velocity = Vector.Zero
        game:ShakeScreen(20)
    end

end
function mod:MercuryHorn(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Horn",true)
    elseif sprite:IsFinished("Horn") then
        data.State = mod:MarkovTransition(data.State, mod.chainMR)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Shot") then
        local direction = (target.Position - entity.Position):Normalized()
        local horn = mod:SpawnEntity(mod.Entity.Horn, entity.Position, direction*mod.MRConst.hornSpeed, entity):ToProjectile()
        horn:GetData().IsHorn_HC = true
        horn.Parent = entity
    end

end
function mod:MercurySideJumps(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        data.JumpCount = data.JumpCount + 1
        sprite:Play("Jumps",true)
    elseif sprite:IsFinished("Jumps") then
        data.StateFrame = 0
        if data.JumpCount > mod.MRConst.nJumps then
            data.JumpCount = 0
            data.State = mod:MarkovTransition(data.State, mod.chainMR)
        end
    
    elseif sprite:IsEventTriggered("StartInvulnerable") then
        local direction = (target.Position - entity.Position):Normalized()
        entity.Velocity = direction * mod.MRConst.jumpSpeed
        sfx:Play(Isaac.GetSoundIdByName("Spring"),0.2, 2,false, 1 + 0.5*rng:RandomFloat())
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
        
    elseif sprite:IsEventTriggered("EndInvulnerable") then
        entity.Velocity = Vector.Zero
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL

        if data.JumpCount > 1 then
            game:ShakeScreen(10)
            mod:MercurySplash(entity, 2, 0.75)
        end
    end

end
function mod:MercuryDrill(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("DrillStart",true)
    elseif sprite:IsFinished("DrillStart") then
        sprite:Play("Drill",true)

        for i = 1, mod.MRConst.nDrillProjectiles do
            mod:scheduleForUpdate(function()
                local offset = i*180/mod.MRConst.nDrillProjectiles
                for j = 1, 4 do
                    local angle = j*360/4 + offset
                    local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_ROCK, 0, entity.Position, Vector.FromAngle(angle)*mod.MRConst.drillRockSpeed, entity):ToProjectile()
                    
                    --Color
                    local roomdesc = game:GetLevel():GetCurrentRoomDesc()
                    if roomdesc and roomdesc.Data and ((roomdesc.Data.Type == RoomType.ROOM_DICE and roomdesc.Data.Variant >= mod.minvariant and roomdesc.Data.Variant <= mod.maxvariant) or (roomdesc.Data.Type == RoomType.ROOM_PLANETARIUM)) then
                        local newColor = Color(1,1,1,0.65)
                        newColor:SetColorize(1,1,1.2,1)
                        tear:GetSprite().Color = newColor
                    end

                end
            end, i*6)

        end

    elseif sprite:IsFinished("Drill") then
        if data.DrillCount < mod.MRConst.nDrills then
            sprite:Play("Drill",true)
            data.DrillCount = data.DrillCount + 1
        else
            sprite:Play("DrillEnd",true)
        end

        if data.DrillCount % 3 == 0 then
            for i = 1, 8 do
                local angle = i*360/8
                local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, Vector.FromAngle(angle)*mod.MRConst.drillShotSpeed, entity):ToProjectile()
                tear:GetSprite().Color = mod.Colors.mercury

            end
        end
    elseif sprite:IsFinished("DrillEnd") then
        data.DrillCount = 0
        data.State = mod:MarkovTransition(data.State, mod.chainMR)
        data.StateFrame = 0


    end

end
function mod:MercuryBirds(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Bird",true)
    elseif sprite:IsFinished("Bird") then

        entity.Visible = true
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
        data.IsExploded = false
        data.Regen = false

        for _, e in ipairs(mod:FindByTypeMod(mod.Entity.MercuryBird)) do
            e:Remove()
        end

        data.State = mod:MarkovTransition(data.State, mod.chainMR)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Explosion") then
        data.IsExploded = true
        entity.Visible = false
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

        --Tear explosion
        local bouncer = Isaac.Spawn(EntityType.ENTITY_BOUNCER, 0, 0, entity.Position, Vector.Zero, entity):ToNPC()
        bouncer.SpriteScale = Vector.Zero
        bouncer.Visible = false
        bouncer.State = 16
        bouncer:AddEntityFlags(EntityFlag.FLAG_NO_BLOOD_SPLASH)
        bouncer:AddEntityFlags(EntityFlag.FLAG_NO_DEATH_TRIGGER)
        bouncer:AddEntityFlags(EntityFlag.FLAG_REDUCE_GIBS)
        bouncer:Die()
        
		mod:scheduleForUpdate(function()
            for _, t in ipairs(Isaac.FindByType(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL)) do
                t:GetSprite().Color = mod.Colors.mercury
            end
		end, 3)

		--Particles
		game:SpawnParticles (entity.Position, EffectVariant.BLOOD_PARTICLE, 20, 13, mod.Colors.mercury)
		local bloody = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.LARGE_BLOOD_EXPLOSION, 0, entity.Position, Vector.Zero, entity)
		bloody:GetSprite().Color = mod.Colors.mercury

        for i=1, mod.MRConst.nBirds do
            local velocity = Vector(0.25 + 0.5*rng:RandomFloat(),0):Rotated(360*rng:RandomFloat())
            bird = mod:SpawnEntity(mod.Entity.MercuryBird, entity.Position+3*velocity, velocity, entity)
            bird.Parent = entity
            bird:GetSprite():Play("Flying")
        end 

    elseif sprite:IsEventTriggered("Regen") then
        entity.Velocity = Vector.Zero
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
        entity.Visible = true
        data.IsExploded = false
        data.Regen = true

    end

    if data.IsExploded then
        mod:MercuryMove(entity, data, room, target)
    end

end
function mod:MercuryTrain(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("MorphingTime",true)
    elseif sprite:IsFinished("MorphingTime") then
        entity.Position = Vector(-100, target.Position.Y)
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
        entity.CollisionDamage = 1
        data.TrainReady = true
        
		sprite:Load("gfx/entity_TankEngine.anm2", true)
		sprite:LoadGraphics()
		sprite:Play("Train", true)

    elseif sprite:IsEventTriggered("Jump") then
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
        entity.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_NONE
        entity.Velocity = Vector(mod.MRConst.jumpSpeed*2, 0)

    elseif sprite:IsFinished("Train") then
        
		sprite:Play("Train", true)

    end

    if data.TrainDirection == 1 then
        if (room:GetRoomShape() >= RoomShape.ROOMSHAPE_2x1 and entity.Position.X > 1900) or (room:GetRoomShape() < RoomShape.ROOMSHAPE_2x1 and entity.Position.X > 1500) then
            data.TrainDirection = - data.TrainDirection
            sprite.FlipX = true
            entity.Position = Vector(entity.Position.X, target.Position.Y)
        end
    else
        if entity.Position.X < -641 then
            data.TrainDirection = - data.TrainDirection
            sprite.FlipX = false
            entity.Position = Vector(entity.Position.X, target.Position.Y)
        end
    end

    if data.TrainReady then
        entity.Velocity = Vector(mod.MRConst.trainsSpeed * data.TrainDirection, 0)

        mod:MercurySplash(entity, 2, 2, (-entity.Velocity):GetAngleDegrees())
        
        local posOffset = Vector(80,-120)
        if sprite.FlipX then
            posOffset = Vector(-posOffset.X, posOffset.Y)
        end

		local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DARK_BALL_SMOKE_PARTICLE, 0, entity.Position + posOffset, Vector.Zero, nil):ToEffect()
		cloud:GetSprite().Scale = 0.8*Vector(1,1)
		cloud:GetSprite().Color = Color(10,10,10,1)

        game:ShakeScreen(10)
    end

end

--Move
function mod:MercuryMove(entity, data, room, target)   
    if speed == nil then speed = 1 end
    --idle move taken from 'Alt Death' by hippocrunchy
    
	--idleTime == frames moving in the same direction
	if not data.idleTime then 
		data.idleTime = mod:RandomInt(mod.MRConst.idleTimeInterval.X, mod.MRConst.idleTimeInterval.Y)
		--V distance of Jupiter from the center of the room
		local distance = room:GetCenterPos():Distance(entity.Position)
		
		--If its too far away, return to the center
		if distance > 40 then
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
    entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * mod.MRConst.speed
    data.targetvelocity = data.targetvelocity * 0.99
end

--Splash
function mod:MercurySplash(entity, amount, range, angle)
    local projectileParams = ProjectileParams()
    projectileParams.Variant = ProjectileVariant.PROJECTILE_NORMAL
    projectileParams.Color = mod.Colors.mercury
    projectileParams.FallingAccelModifier = 1/range

    if angle == nil then
        local offset = 360*rng:RandomFloat()
        for i = 1, mod.MRConst.nJumpProj do
            local newAngle = i*360/mod.MRConst.nJumpProj + offset
            entity:FireBossProjectiles (amount, entity.Position + Vector(1,0):Rotated(newAngle), 0, projectileParams )
        end
    else
        entity:FireBossProjectiles (amount, entity.Position + Vector(1,0):Rotated(angle), 0, projectileParams )
    end

end

--ded
function mod:MercuryDeath(entity)
    if entity.Variant == mod.EntityInf[mod.Entity.Mercury].VAR then
        for _, e in ipairs(mod:GetCandles()) do
            e:Die()
        end

        --Fart:
        mod:NormalDeath(entity)
    end
end
--deding
function mod:MercuryDying(entity)
    
    local sprite = entity:GetSprite()
    local data = entity:GetData()

end

--Callbacks
--Mercury updates
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.MercuryUpdate, mod.EntityInf[mod.Entity.Mercury].ID)
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.MercuryDeath, mod.EntityInf[mod.Entity.Mercury].ID)

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
    [mod.VMSState.IDLE] = 	    {0,	  0.30, 0.01, 0.3,	0.005,0.01,	0.02, 0.145,0.005,0.005,0.2},
    --[mod.VMSState.IDLE] = 	    {0,	  0,	0,    0,	0,    1,	0.08, 0.1,	0.04,0.05,0.1},
    --[mod.VMSState.IDLE] = 	    {0,	  0,	0,    0,	0,    0,	1, 0.1,	0.04,0.05,0.1},
    --[mod.VMSState.IDLE] = 	    {0,	  0,	0,    0,	0,    0,	0,    1,	0.04,0.05,0.1},
    [mod.VMSState.FLAME] =  	{0,   1,    0,    0,    0,    0,    0,    0,    0,   0,   0},
    [mod.VMSState.SUMMON] = 	{0,   0.1,  0,    0,    0,    0,    0,    0,    0,   0,   0.9},
    [mod.VMSState.IPECAC] = 	{0,   0.8,  0,    0,    0,    0,    0.2,  0,    0,   0,   0},
    [mod.VMSState.JUMPS] =  	{0,   0.4,  0,    0,    0.1,  0,    0.1,  0.2,  0,   0.2, 0},
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

    kissSpeed = 35,
    kissHomming = 0.7,

    nSlamFireRing = 12,
    nSlamFireball = 8,

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
        if data.State == nil then 
            data.State = 0 
            data.StateFrame = 0

            data.Flamethrower = false
            data.FlameSlide = false
            data.TargetPos = target.Position
            data.FireWaveType = 0
            data.FlameAngle = mod.VConst.flameAngleStart
        end
        
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
        sfx:Play(Isaac.GetSoundIdByName("Flames"),4)
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
        
        sfx:Play(Isaac.GetSoundIdByName("Fireball"),1)
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
    for _, e in ipairs(mod:GetCandles()) do
        e:Die()
    end

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
		if player:GetData().BurnTime == nil or player:GetData().BurnTime <= 1 then 
			unburnedPlayers[#unburnedPlayers+1]=player
		end
	end
    if #unburnedPlayers > 0 then
        local player = unburnedPlayers[mod:RandomInt(1,#unburnedPlayers)]
        return player
    end
    return nil
end

--Get candle summons
function mod:GetCandles()
    local candles = Isaac.FindByType(mod.EntityInf[mod.Entity.Candle].ID)
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
    [mod.MMSState.ATTACK] =     {0,    0,     0,     0,     0,     0,     0,     0.05,  0.14,   0.1,    0.1,    0.1,    0.14,   0.3,   0.07},
    --[mod.MMSState.ATTACK] =     {0,    0,     0,     0,     0,     0,     0,     0,  0,   0,    0,    0,    0,   0,   1},
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
    shotAngle = 35,
    shotSpeed = 6,

    missileExplosionDamage = 50,
    missileExplosionRadius = 20,
    nMissileTears = 8,
    missileTearsSpeed = 15,
    missileSpeed = 9,
    missileTime = 20,

    nTargets = 6,
    airstrikeExplosionRadius = 70,
}

local PickedIndexes = {}
local RandomDists = {}
local airstrikesIndexes = { 
    32, 35, 39, 42,  
    --62, 65, 69, 72,  
    92, 95, 99, 102}

function mod:MarsUpdate(entity)
    if entity.Variant == mod.EntityInf[mod.Entity.Mars].VAR and entity.SubType == mod.EntityInf[mod.Entity.Mars].SUB then
        local data = entity:GetData()
        local sprite = entity:GetSprite()
        local target = entity:GetPlayerTarget()
        local room = game:GetRoom()
        
        --Custom data:
        if data.State == nil then 
            data.State = 0
            data.SecondState = 0 
            data.StateFrame = 0 

            data.TargetPos = Vector.Zero 
            data.ExtraLaserCount = 0 
            data.ExtraLaserWarningCount = 0 
            data.Laser = false
            data.TargetDirection = Vector.Zero 
            data.Move = false 
            data.IsMartian = true 
        end
        
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
        data.ExtraLaserWarningCount = 0
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("SetAim") then
        sfx:Play(Isaac.GetSoundIdByName("LaserCharge"),5)
        data.TargetPos = target.Position
        entity.Velocity = Vector.Zero
    elseif sprite:IsEventTriggered("Laser") then
        sfx:Play(Isaac.GetSoundIdByName("LaserShot"),7, 2, false, 1.3)
        data.Laser = true
        data.TargetDirection = (data.TargetPos - entity.Position):Normalized()
        local direction = data.TargetDirection
		local laser = EntityLaser.ShootAngle(1, entity.Position + Vector(0,-40) + direction*45 , direction:GetAngleDegrees(), 85, Vector.Zero, entity)

        local sprite = laser:GetSprite()
        sprite:ReplaceSpritesheet (0, "gfx/effects/energy_laser.png")
		sprite:LoadGraphics()
        sprite.Scale = Vector.One*2

        RandomDists = {mod:RandomInt(-30,30), mod:RandomInt(-30,30), mod:RandomInt(-30,30), mod:RandomInt(-30,30)}


    elseif sprite:IsEventTriggered("ExtraLaserWarning") then
        data.ExtraLaserWarningCount = data.ExtraLaserWarningCount + 1
        local distance = 140*data.ExtraLaserWarningCount + RandomDists[data.ExtraLaserWarningCount]
        local direction = data.TargetDirection
        local position = entity.Position + Vector(0,-40) + direction*distance
        if not mod:IsOutsideRoom(position, room) then
            for i = 0, 1 do
                local laser = EntityLaser.ShootAngle(7,position , direction:GetAngleDegrees() + 90*(2*i-1), 9, Vector.Zero, entity)

                laser:GetSprite().Color = Color(2,0,0,1)
            end
    
        end

    elseif sprite:IsEventTriggered("ExtraLaser") then
        data.ExtraLaserCount = data.ExtraLaserCount + 1
        local distance = 140*data.ExtraLaserCount + RandomDists[data.ExtraLaserCount]
        local direction = data.TargetDirection
        local position = entity.Position + Vector(0,-40) + direction*distance
        if not mod:IsOutsideRoom(position, room) then
            for i = 0, 1 do
                sfx:Play(Isaac.GetSoundIdByName("LaserShotMini"),7, 2, false, 0.75 + 0.35*rng:RandomFloat())
                local laser = EntityLaser.ShootAngle(1,position , direction:GetAngleDegrees() + 90*(2*i-1), 10, Vector.Zero, entity)
                local sprite = laser:GetSprite()
                sprite:ReplaceSpritesheet (0, "gfx/effects/energy_laser.png")
                sprite:LoadGraphics()
            end
    
        end
    end
    sfx:Stop (SoundEffect.SOUND_BLOOD_LASER)

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

    --mod:MarsMove(entity, data, room, target, true)

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

    elseif sprite:IsEventTriggered("Missile") then
        local direction = Vector(1,0)
        local flag = false
        if entity.Position.X > target.Position.X then
            direction = Vector(-1,0)
            flag = true
        end

        local rocketType = mod.Entity.MarsRocket
        if rng:RandomFloat() <= 0.02 then
            rocketType = mod.Entity.MarsGigaRocket
        end

        local rocket = mod:SpawnEntity(rocketType, entity.Position + direction*50, direction, entity):ToBomb()
        if flag then 
            rocket:GetData().ToTheLeft = true 
            rocket:GetSprite().FlipX = true
        end
        if rocketType == mod.Entity.MarsGigaRocket then
            rocket.RadiusMultiplier = 1.5
            rocket:GetData().IsMartian = true
        end
    end
end
function mod:MarsDrones(entity, data, sprite, target,room)
    if data.StateFrame == 1 then--Now the moons always attack
        data.State = mod:MarkovTransition(data.State, mod.chainM)
        data.StateFrame = 0
        --sprite:Play("Idle",true)
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
            sfx:Play(Isaac.GetSoundIdByName("EnergyShotTriple"),1)

            for j=1, mod.MConst.nRowShots do
                local targetAim = target.Position - entity.Position
                for i=0, mod.MConst.nShots-1 do
                    local angle = -mod.MConst.shotAngle/2 + mod.MConst.shotAngle / (mod.MConst.nShots-1) * i
                    local velocity = targetAim:Normalized():Rotated(angle)*mod.MConst.shotSpeed*(1/(j^0.5))
                    local shot = mod:SpawnMarsShot(entity.Position, velocity, entity)
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

        for _, e in ipairs(Isaac.FindByType(mod.EntityInf[mod.Entity.Mars].ID)) do
            if e.Variant ~= mod.EntityInf[mod.Entity.Mars].VAR then
                e:Die()
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

function mod:Lerp(a,b,p)
    return p*b + (1-p)*a
end

function mod:RocketLeft(bomb)
    if bomb:GetData().ToTheLeft then--From Samael
        local targetVel = 20*Vector(-1,0)
        local startVel = targetVel*0.25
        local framesUntilFullSpeed = 15
        local counter = bomb.FrameCount
        local percent = math.min(counter / framesUntilFullSpeed, 1)
        bomb.Velocity = mod:Lerp(startVel,targetVel,percent)
        bomb.SpriteRotation = targetVel:GetAngleDegrees()
    end
end

function mod:SpawnMarsShot(position, velocity, origin)
    local shot = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, position, velocity, origin):ToProjectile()
    shot.FallingSpeed = 0
    shot.FallingAccel = -0.1

    local energy = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TECH_DOT, 0, shot.Position, Vector.Zero, origin):ToEffect()
    energy.LifeSpan = 1000
    energy.Parent = shot
    energy.DepthOffset = 5
    energy:GetData().MarsShot_HC = true
    energy:FollowParent(shot)

    return shot
end

--Callbacks
--Mars updates
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.MarsUpdate, mod.EntityInf[mod.Entity.Mars].ID)
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.MarsDeath, mod.EntityInf[mod.Entity.Mars].ID)

--Rocket
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, mod.RocketLeft, BombVariant.BOMB_ROCKET)