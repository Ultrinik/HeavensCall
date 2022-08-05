local mod = HeavensCall
local game = Game()
local rng = RNG()
local sfx = SFXManager()
local music = MusicManager()
local json = require("json")



--ENTITIES--------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--Statue----------------------------------------------------------------------------------------------------------------------------
local PickupPoolMin = 6
local PickupPoolMax = 10
local PickupPool = {}
for i=1,15 do PickupPool[#PickupPool+1]=PickupVariant.PICKUP_HEART end
for i=1,14 do PickupPool[#PickupPool+1]=PickupVariant.PICKUP_BOMB end
for i=1,14 do PickupPool[#PickupPool+1]=PickupVariant.PICKUP_KEY end
for i=1,15 do PickupPool[#PickupPool+1]=PickupVariant.PICKUP_COIN end
for i=1,10 do PickupPool[#PickupPool+1]=PickupVariant.PICKUP_TAROTCARD end
for i=1,5 do PickupPool[#PickupPool+1]=PickupVariant.PICKUP_TRINKET end
for i=1,10 do PickupPool[#PickupPool+1]=PickupVariant.PICKUP_PILL end
for i=1,7 do PickupPool[#PickupPool+1]=PickupVariant.PICKUP_GRAB_BAG end
for i=1,10 do PickupPool[#PickupPool+1]=PickupVariant.PICKUP_LIL_BATTERY end
function mod:SpawnPickup(entity)

	local pickup = PickupPool[mod:RandomInt(1,#PickupPool)]
	local pickupSub = 0
	--No troll bomb and maybe giga bomb
	if pickup == PickupVariant.PICKUP_BOMB then
		pickupSub = ({1,1,1,2,})[mod:RandomInt(1,4)]
		if mod:RandomInt(1,20)==7 then
			pickupSub = BombSubType.BOMB_GOLDEN
		elseif mod:RandomInt(1,2000)==777 then
			pickupSub = BombSubType.BOMB_GIGA
		end
	end
	--Increase red key chance
	if pickup == PickupVariant.PICKUP_TAROTCARD then
		if mod:RandomInt(1,25)==7 then
			pickupSub = Card.CARD_CRACKED_KEY
		end
	end

	local pickup = Isaac.Spawn(EntityType.ENTITY_PICKUP, pickup, pickupSub, entity.Position, Vector((rng:RandomFloat() * 4) + 3.5,0):Rotated(rng:RandomFloat()*360), nil)
	--pickup:GetData().isAstral = true --This was to transform it into pool if "exploit" is used
end

function mod:StatueUpdate(entity)
	
	if entity.Variant == mod.EntityInf[mod.Entity.Statue].VAR then
		entity.Velocity = Vector.Zero
		entity.Position = game:GetRoom():GetCenterPos(0)+Vector(0,-20)

		if entity:GetData().Initialized == nil then
			entity:GetData().Initialized = true
			entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
			entity:AddEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS)
			entity:AddEntityFlags(EntityFlag.FLAG_NO_TARGET)
			entity:AddEntityFlags(EntityFlag.FLAG_NO_FLASH_ON_DAMAGE)
			entity:AddEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK)
			entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
			entity:AddEntityFlags(EntityFlag.FLAG_NO_BLOOD_SPLASH)
			entity:AddEntityFlags(EntityFlag.FLAG_DONT_COUNT_BOSS_HP)
			entity:GetSprite():Play("Appear",true)
		end

		if entity:GetSprite():IsFinished("Ded") then
			entity:Remove()
		end
	end
end
function mod:StatueRenderUpdate(entity)
	if entity.Variant == mod.EntityInf[mod.Entity.Statue].VAR then
		--IAM DOING AN Isaac.FindByType EVERY RENDER, AND NOBODY CAN STOP ME!!!!!
		for _,pedestal in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0)) do
			pedestal:Remove()
			mod:StatueDie(entity)
			entity:GetSprite():Play("Ded")

			--Turn pickups into poop if the items was taken in the same frame... or not, cuz its commented :)
			--[[mod:scheduleForUpdate(function()
				for _, pickup in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
					if pickup:GetData().isAstral then
						pickup = pickup:ToPickup()
						pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_POOP, mod:RandomInt(0,1))
					end
				end
			end,0)]]--
		end
	end
end

function mod:StatueDie(entity)
	local room = game:GetRoom()
	local level = game:GetLevel()
	local roomdesc = level:GetCurrentRoomDesc()

	if mod:IsRoomDescAstralChallenge(roomdesc) and mod.savedata.planetNum and #(mod:FindByTypeMod(mod.savedata.planetNum))==0 then

		mod.savedata.planetAlive = true --Yes, I know about FLAG_PERSISTENT

		local planet = mod:SpawnEntity(mod.savedata.planetNum, entity.Position, Vector.Zero, entity)
		planet:GetData().SlowSpawn = true

		mod.savedata.planetHP = planet.HitPoints

		--Close door
		for i = 0, DoorSlot.NUM_DOOR_SLOTS do
			local door = room:GetDoor(i)
			if door then
				door:Close()
			end
		end
		sfx:Play(SoundEffect.SOUND_CASTLEPORTCULLIS,1)
		--Make room uncleared
		room:SetClear( false )

	else
		--LOL LMAO
	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.StatueUpdate, mod.EntityInf[mod.Entity.Statue].ID)
mod:AddCallback(ModCallbacks.MC_POST_NPC_RENDER, mod.StatueRenderUpdate, mod.EntityInf[mod.Entity.Statue].ID)
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, entity, _, damageFlag, _, _)
	if entity.Type == mod.EntityInf[mod.Entity.Statue].ID and  entity.Variant == mod.EntityInf[mod.Entity.Statue].VAR then
		if (damageFlag & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION) and not entity:GetData().Spawnflag then
			for _,pedestal in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
				for i=1, mod:RandomInt(PickupPoolMin,PickupPoolMax) do
					mod:SpawnPickup(pedestal)
				end
				Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pedestal.Position, Vector.Zero, nil)
				pedestal:Remove()
				sfx:Play(SoundEffect.SOUND_ULTRA_GREED_COIN_DESTROY,1)
			end

			entity:GetData().Spawnflag = true--For double in same frame explosions
			mod:StatueDie(entity)
			entity:GetSprite():Play("Ded")
		end
		return false
	end
end)
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, function(_, entity)--You can kill it with the Chaos card
	if entity.Type == mod.EntityInf[mod.Entity.Statue].ID and entity.Variant == mod.EntityInf[mod.Entity.Statue].VAR then
		game:SpawnParticles (entity.Position, EffectVariant.DIAMOND_PARTICLE, 75, 9)
		sfx:Play(SoundEffect.SOUND_MIRROR_BREAK,1)
		mod.savedata.planetKilled = true
		mod.savedata.planetAlive = false
	end
end)

mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, function(_,pickup,entity)
	if pickup.Type == EntityType.ENTITY_PICKUP and pickup.Variant == PickupVariant.PICKUP_COLLECTIBLE then
		if entity.Type == EntityType.ENTITY_PLAYER then
			local statues = mod:FindByTypeMod(mod.Entity.Statue)
			if #statues>0 then
				mod:StatueDie(statues[1])
				statues[1]:GetSprite():Play("Ded")
			end
		end
	end
end)

--IETDDATD (dont ask why this exists)-----------------------------------------------------------------------------------------------
function mod:DieInstantly(entity)
	if entity.Variant == mod.EntityInf[mod.Entity.IETDDATD].VAR then
		entity:Remove()
	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.DieInstantly, mod.EntityInf[mod.Entity.IETDDATD].ID)


--Hyperion---------------------------------------------------------------------------------------------------------------------------
--Nerfing hyperion (OLD)
--[[mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, entity, _, flags, source, frames)
	if entity.Type == EntityType.ENTITY_PLAYER and source.SpawnerType == EntityType.ENTITY_SUB_HORF and #(Isaac.FindByType(EntityType.SATURN_HC))>0 then
		mod:scheduleForUpdate(function()
			entity:TakeDamage (1,flags, source, frames)
		end, 0, ModCallbacks.MC_POST_UPDATE)
		return false
	end
end)--]]

--Ice turd---------------------------------------------------------------------------------------------------------------------------
function mod:IceTurdUpdate(entity)
	if mod.EntityInf[mod.Entity.IceTurd].VAR == entity.Variant then
		--Dont freeze the ice duh
		entity:ClearEntityFlags(EntityFlag.FLAG_ICE_FROZEN)
		entity:ClearEntityFlags(EntityFlag.FLAG_ICE)
		entity.Velocity = Vector.Zero

		local data = entity:GetData()
		if not data.Init then
			mod:IceTurdInit(entity)
		end

		if(entity:GetSprite():IsFinished("Appear")) then
			game:ShakeScreen(10);
			sfx:Play(Isaac.GetSoundIdByName("IceCrash"),1);
			mod:SpawnIceCreep(entity.Position, mod.UConst.turdIceSize, entity)
			mod:IceTurdFinishedAppear(entity)
		end
	end
end
function mod:IceTurdInit(entity)
	entity:GetData().Init = true
	
	entity.CollisionDamage = 0
	entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
	entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
	entity:AddEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS)
	entity:AddEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK)
	entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
	entity:AddEntityFlags(EntityFlag.FLAG_NO_BLOOD_SPLASH)

	--Mom's knife cant damage FLAG_NO_TARGET entities (Which is something good, but I dont care), probably not the only item with that side effect
	if not mod:SomebodyHasItem(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
		entity:AddEntityFlags(EntityFlag.FLAG_NO_TARGET)
	end

	entity:GetSprite():Play("Appear",true)
end
function mod:IceTurdFinishedAppear(entity)
	entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL

	--Crash damage
	for i, entity_ in ipairs(Isaac.FindInRadius(entity.Position, mod.UConst.turdRadius)) do
		if entity_.Type ~= EntityType.ENTITY_PLAYER and entity_.Type ~= mod.EntityInf[mod.Entity.Uranus].ID then
			entity_:TakeDamage(mod.UConst.turdDamage, DamageFlag.DAMAGE_CRUSH, EntityRef(entity), 0)
		elseif entity_.Type == EntityType.ENTITY_PLAYER and entity_.Type ~= mod.EntityInf[mod.Entity.Uranus].ID then
			entity_:TakeDamage(1, DamageFlag.DAMAGE_CRUSH, EntityRef(entity), 0)
		end
	end

	--Sprite
	local roomdesc = game:GetLevel():GetCurrentRoomDesc()
	if roomdesc and roomdesc.Data and ((roomdesc.Data.Type == RoomType.ROOM_DICE and roomdesc.Data.Variant >= mod.minvariant and roomdesc.Data.Variant <= mod.maxvariant) or (roomdesc.Data.Type == RoomType.ROOM_PLANETARIUM)) then
		entity:GetSprite():Play("IdlePlanetarium", true)
	else
		entity:GetSprite():Play("Idle", true)
	end

end
function mod:IceTurdDeath(entity)
	if mod.EntityInf[mod.Entity.IceTurd].VAR == entity.Variant then
		sfx:Play(Isaac.GetSoundIdByName("IceBreak"),1)
		game:SpawnParticles (entity.Position, EffectVariant.DIAMOND_PARTICLE, 50, 9)
		for i=0, mod.UConst.nTurdIcicles do
			local angle = i*360/mod.UConst.nTurdIcicles
			--Ring projectiles:
			local hail = mod:SpawnEntity(mod.Entity.Icicle, entity.Position, Vector(1,0):Rotated(angle)*mod.UConst.turdIcicleSpeed, entity):ToProjectile()
			hail:GetData().IsIcicle_HC = true
			--hail:GetSprite().Color = Colors.hailColor
			hail:GetData().iceSize = mod.UConst.turdIcicleIceSize
			hail:GetData().hailTrace = false
			hail:GetData().hailSplash = false
			
		end
	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.IceTurdUpdate, mod.EntityInf[mod.Entity.IceTurd].ID)
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.IceTurdDeath, mod.EntityInf[mod.Entity.IceTurd].ID)

--Ulcers---------------------------------------------------------------------------------------------------------------------------
function mod:UlcersUpdate(entity)
	if mod.EntityInf[mod.Entity.Ulcers].VAR == entity.Variant then
		local sprite = entity:GetSprite()
		local target = entity:GetPlayerTarget()

		if sprite:IsPlaying("Attack") and sprite:GetFrame() == 1 and rng:RandomFloat() < 0.67 then
			sprite:Play("Fly",true)
		end

		if sprite:IsEventTriggered("Fireball") then
			local velocity = (target.Position - entity.Position):Normalized()*mod.VConst.blazeSpeedSlow*(0.3 + 0.6*rng:RandomFloat())
			local fireball = mod:SpawnEntity(mod.Entity.Fireball, entity.Position, velocity, entity):ToProjectile()

			fireball:GetData().IsFireball_HC = true
			fireball:GetSprite().Scale = Vector(1,1)*0.75
			
			fireball.FallingSpeed = -10
			fireball.FallingAccel = 1.5
			
			fireball:AddProjectileFlags(ProjectileFlags.FIRE_SPAWN)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.UlcersUpdate, mod.EntityInf[mod.Entity.Ulcers].ID)

--Candles---------------------------------------------------------------------------------------------------------------------------
mod.CandleGirs = {
	[1] = mod.Entity.CandleSiren,
	[2] = mod.Entity.CandleGurdy,
	[3] = mod.Entity.CandleColostomia,
	[4] = mod.Entity.CandleMist
}


--States and matrix
mod.SirenMSTATE = {
	APPEAR = 0,
	SING = 1,
	ANNOYED = 2,
	AMBUSH = 3
}
mod.chainSiren = {          
	[mod.SirenMSTATE.APPEAR] = 	{0,  1,  0,  0},
	[mod.SirenMSTATE.SING] = 	{0,  1,  0,  0},
	[mod.SirenMSTATE.ANNOYED] = {0,  0,  0,  1},--This last two does nothing, I know why they do nothing, I just dont care anymore
	[mod.SirenMSTATE.AMBUSH] = 	{0,  1,  0,  0}
}

mod.GurdyMSTATE = {
	APPEAR = 0,
	TAUNT = 1,
	SUMMON = 2
}
mod.chainGurdy = {          
	[mod.GurdyMSTATE.APPEAR] = 	{0,  1,   0},
	[mod.GurdyMSTATE.TAUNT] = 	{0,  0.35,0.65},
	[mod.GurdyMSTATE.SUMMON] = 	{0,  1,   0}
}

mod.ColostomiaMSTATE = {
	APPEAR = 0,
	IDLE = 1,
	JUMP = 2,
	BOMB = 3
}
mod.chainColostomia = {          
	[mod.ColostomiaMSTATE.APPEAR] = 	{0,  1,    0,    0},
	[mod.ColostomiaMSTATE.IDLE] = 	{0,  0.7,  0.15, 0.15},
	[mod.ColostomiaMSTATE.JUMP] = 	{0,  1,    0,    0},
	[mod.ColostomiaMSTATE.BOMB] = 	{0,  1,    0,    0}
}

mod.MaidMSTATE = {
	APPEAR = 0,
	IDLE = 1,
	ATTACK = 2
}
mod.chainMaid = {          
	[mod.MaidMSTATE.APPEAR] = 	{0,  1,    0},
	[mod.MaidMSTATE.IDLE] = 	{0,  0.65, 0.35},
	[mod.MaidMSTATE.ATTACK] = 	{0,  1,    0}
}

function mod:CandleUpdate(entity)
	if mod.EntityInf[mod.Entity.Candle].VAR == entity.Variant then
		local sprite = entity:GetSprite()
		local data = entity:GetData()
        local target = entity:GetPlayerTarget()
        local room = game:GetRoom()

        if data.State == nil then data.State = 0 end
        if data.StateFrame == nil then data.StateFrame = 0 end

        --Frame
        data.StateFrame = data.StateFrame + 1

		if mod.EntityInf[mod.Entity.Candle].SUB == entity.SubType then

			if data.Init == nil then
				data.Init = true

				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
				entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
				entity:AddEntityFlags(EntityFlag.FLAG_NO_STATUS_EFFECTS)
				entity:AddEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK)
				entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
				entity:AddEntityFlags(EntityFlag.FLAG_NO_BLOOD_SPLASH)
			
				if not mod:SomebodyHasItem(CollectibleType.COLLECTIBLE_MOMS_KNIFE) then
					entity:AddEntityFlags(EntityFlag.FLAG_NO_TARGET)
				end

				sprite:Play("Appear", true) 
			end

			if sprite:IsFinished("Appear") then 
				sprite:Play("Idle", true) 
				entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
			elseif sprite:IsFinished("IdleLit") then 
				sprite:Play("Transform", true)
			elseif sprite:IsFinished("Transform") then

				
				local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, nil):ToEffect()
				sfx:Play(SoundEffect.SOUND_SUMMONSOUND,1)

				local entity2Transform = mod.CandleGirs[mod:RandomInt(1,#mod.CandleGirs)]
				--Dont spawn Siren if theres a Lilith
				if mod:IsThereLilith() then
					entity2Transform = mod.CandleGirs[mod:RandomInt(2,#mod.CandleGirs)]
				end
				
				local candleGirl = mod:SpawnEntity(entity2Transform, entity.Position, Vector.Zero, entity.Parent)
				candleGirl.Parent = entity.Parent

				entity:Remove()
			end
			
		elseif mod.EntityInf[mod.Entity.CandleSiren].SUB == entity.SubType then
			if data.SirenResummonCount == nil then data.SirenResummonCount = 0 end

			if data.State == mod.SirenMSTATE.APPEAR then
				if data.StateFrame == 1 then
					entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
					entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
					sprite:Play("Appear",true)
				elseif sprite:IsFinished("Appear") then
					data.State = mod:MarkovTransition(data.State, mod.chainSiren)
					data.StateFrame = 0
				end
				
			elseif data.State == mod.SirenMSTATE.SING then
				if data.StateFrame == 1 then
					sprite:Play("SingStart",true)
					for i=1, mod.VConst.sirenSummons*3 do
						local sirenRag = mod:SpawnEntity(mod.Entity.SirenRag, entity.Position, Vector.Zero, entity)
						sirenRag.Parent = entity
						local sprite = sirenRag:GetSprite()
						sprite:ReplaceSpritesheet (0, "gfx/effects/empty.png")
						sprite:ReplaceSpritesheet (1, "gfx/effects/empty.png")
						sprite:ReplaceSpritesheet (2, "gfx/effects/empty.png")
						sprite:ReplaceSpritesheet (3, "gfx/effects/empty.png")
						sprite:ReplaceSpritesheet (4, "gfx/effects/empty.png")
						sprite:LoadGraphics()
					end

				elseif sprite:IsFinished("SingStart") then
					sprite:Play("SingLoop",true)

				elseif sprite:IsFinished("SingLoop") then
					local sirenRags = mod:FindByTypeMod(mod.Entity.SirenRag)
					if #(sirenRags)>0 then
						sprite:Play("SingLoop",true)
						
						if data.SirenResummonCount >= mod.VConst.sirenResummonRate then

							if #sirenRags >= 50 then
								for _, e in ipairs(sirenRags) do
									e:Remove()
								end
							end

							for i=1, mod.VConst.sirenSummons do
								local sirenRag = mod:SpawnEntity(mod.Entity.SirenRag, entity.Position, Vector.Zero, entity)
								sirenRag.Parent = entity
								local sprite = sirenRag:GetSprite()
								sprite:ReplaceSpritesheet (0, "gfx/effects/empty.png")
								sprite:ReplaceSpritesheet (1, "gfx/effects/empty.png")
								sprite:ReplaceSpritesheet (2, "gfx/effects/empty.png")
								sprite:ReplaceSpritesheet (3, "gfx/effects/empty.png")
								sprite:ReplaceSpritesheet (4, "gfx/effects/empty.png")
								sprite:LoadGraphics()
							end

							data.SirenResummonCount = 0
						end

						data.SirenResummonCount = data.SirenResummonCount + 1
					else
						sprite:Play("SingEnd",true)
					end

				elseif sprite:IsFinished("SingEnd") then
					data.State = mod:MarkovTransition(data.State, mod.chainSiren)
					data.StateFrame = 0
					
				end

				--Movement
				if entity.Parent then
					local parent = entity.Parent
					--idleTime == frames moving in the same direction
					if not data.idleTime then 
						data.idleTime = mod:RandomInt(mod.VConst.idleTimeInterval.X, mod.VConst.idleTimeInterval.Y)

						if parent.Position:Distance(entity.Position) < 100 then
							data.targetvelocity = (-(parent.Position - entity.Position):Normalized()*2):Rotated(mod:RandomInt(-45, 45))
						else
							data.targetvelocity = ((parent.Position - entity.Position):Normalized()*2):Rotated(mod:RandomInt(-10, 10))
						end
					end
					
					--If run out of idle time
					if data.idleTime <= 0 and data.idleTime ~= nil then
						data.idleTime = nil
					else
						data.idleTime = data.idleTime - 1
					end
					
					--Do the actual movement
					entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * 1.2
					data.targetvelocity = data.targetvelocity * 0.99
				end

			elseif data.State == mod.SirenMSTATE.ANNOYED then
				if data.StateFrame == 1 then
					sprite:Play("Teleport",true)
					entity.Velocity = Vector.Zero
					entity.CollisionDamage = 0
				elseif sprite:IsFinished("Teleport") then
					data.State = mod:MarkovTransition(data.State, mod.chainSiren)
					data.StateFrame = 0
				end

			elseif data.State == mod.SirenMSTATE.AMBUSH then
				if data.StateFrame == 1 then
					sprite:Play("Revive",true)
					entity.Velocity = Vector.Zero
					entity.Position = target.Position
				elseif sprite:IsFinished("Revive") then
					data.State = mod:MarkovTransition(data.State, mod.chainSiren)
					data.StateFrame = 0
				
				elseif sprite:IsEventTriggered("Reappear") then
					entity.CollisionDamage = 1

				end

			end

		elseif mod.EntityInf[mod.Entity.CandleGurdy].SUB == entity.SubType then
			entity.Velocity = Vector.Zero
			if data.State == mod.GurdyMSTATE.APPEAR then
				if data.StateFrame == 1 then
					entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
					sprite:Play("Appear",true)
					entity:AddEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK)
					entity:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
				elseif sprite:IsFinished("Appear") then
					data.State = mod:MarkovTransition(data.State, mod.chainGurdy)
					data.StateFrame = 0
				end
				
			elseif data.State == mod.GurdyMSTATE.TAUNT then
				if data.StateFrame == 1 then
					sprite:Play("Idle"..tostring(mod:RandomInt(1,3)),true)
				elseif sprite:IsFinished("Idle1") or sprite:IsFinished("Idle2") or sprite:IsFinished("Idle3") then
					data.State = mod:MarkovTransition(data.State, mod.chainGurdy)
					data.StateFrame = 0
					
				end
				
			elseif data.State == mod.GurdyMSTATE.SUMMON then
				if data.StateFrame == 1 then
					sprite:Play("Attack"..tostring(mod:RandomInt(1,3)),true)
				elseif sprite:IsFinished("Attack1") or sprite:IsFinished("Attack2") or sprite:IsFinished("Attack3") then
					data.State = mod:MarkovTransition(data.State, mod.chainGurdy)
					data.StateFrame = 0

				elseif sprite:IsEventTriggered("Summon") then
					if #mod:FindByTypeMod(mod.Entity.Ulcers) < 7 then
						local butter = mod:SpawnEntity(mod.Entity.Ulcers, entity.Position, Vector.Zero, entity)
						sfx:Play(SoundEffect.SOUND_SUMMONSOUND,1)
					end
					
				end

			end
		elseif mod.EntityInf[mod.Entity.CandleColostomia].SUB == entity.SubType then
			if data.State == mod.ColostomiaMSTATE.APPEAR then
				if data.StateFrame == 1 then
					entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
					sprite:Play("Appear",true)
				elseif sprite:IsFinished("Appear") then
					data.State = mod:MarkovTransition(data.State, mod.chainColostomia)
					data.StateFrame = 0
				end
				
			elseif data.State == mod.ColostomiaMSTATE.IDLE then
				if data.StateFrame == 1 then
					sprite:Play("Idle",true)
				elseif sprite:IsFinished("Idle") then
					data.State = mod:MarkovTransition(data.State, mod.chainColostomia)
					data.StateFrame = 0
					
				end
				
			elseif data.State == mod.ColostomiaMSTATE.JUMP then
				if data.StateFrame == 1 then
					sprite:Play("Jump",true)
				elseif sprite:IsFinished("Jump") then
					data.State = mod:MarkovTransition(data.State, mod.chainColostomia)
					data.StateFrame = 0

				elseif sprite:IsEventTriggered("Land") then
					game:ShakeScreen(10)
					entity.Velocity = Vector.Zero

				elseif sprite:IsEventTriggered("Jump") then
					local direction = entity.Parent.Position - entity.Position
					local velocity = direction:Normalized()*mod.VConst.coloJumpSpeed
					entity.Velocity = velocity
					
				end
				
			elseif data.State == mod.ColostomiaMSTATE.BOMB then
				if data.StateFrame == 1 then
					
					if target.Position.X - entity.Position.X > 0 then
						sprite.FlipX = true
					else
						sprite.FlipX = false
					end

					sprite:Play("Attack",true)
				elseif sprite:IsFinished("Attack") then
					data.State = mod:MarkovTransition(data.State, mod.chainColostomia)
					data.StateFrame = 0
					
				elseif sprite:IsEventTriggered("Bomb") then
					
					if target.Position.X - entity.Position.X > 0 then
						sprite.FlipX = true
					else
						sprite.FlipX = false
					end
					
					local target_pos = target.Position - entity.Position
					local velocity = target_pos:Normalized()*15

					local bomb = Isaac.Spawn(EntityType.ENTITY_BOMBDROP, BombVariant.BOMB_BUTT, 0, entity.Position+velocity, velocity, entity):ToBomb()
					bomb:GetSprite().Color = mod.Colors.buttFire
					bomb:SetExplosionCountdown(120)
					bomb:AddTearFlags(TearFlags.TEAR_BURN)
				end

			end
		elseif mod.EntityInf[mod.Entity.CandleMist].SUB == entity.SubType then
			if data.State == mod.MaidMSTATE.APPEAR then
				if data.StateFrame == 1 then
					entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
					sprite:Play("Appear",true)
				elseif sprite:IsFinished("Appear") then
					data.State = mod:MarkovTransition(data.State, mod.chainMaid)
					data.StateFrame = 0
				end
				
			elseif data.State == mod.MaidMSTATE.IDLE then
				if data.StateFrame == 1 then
					sprite:Play("Idle",true)
				elseif sprite:IsFinished("Idle") then
					data.State = mod:MarkovTransition(data.State, mod.chainMaid)
					data.StateFrame = 0
					
				end

				--Movement
				if entity.Parent then
					local parent = entity.Parent
					--idleTime == frames moving in the same direction
					if not data.idleTime then 
						data.idleTime = mod:RandomInt(mod.VConst.idleTimeInterval.X, mod.VConst.idleTimeInterval.Y)

						if parent.Position:Distance(entity.Position) < 75 then
							data.targetvelocity = (-(parent.Position - entity.Position):Normalized()*3):Rotated(mod:RandomInt(-45, 45))
						else
							data.targetvelocity = ((parent.Position - entity.Position):Normalized()):Rotated(mod:RandomInt(-10, 10))
						end
					end
					
					--If run out of idle time
					if data.idleTime <= 0 and data.idleTime ~= nil then
						data.idleTime = nil
					else
						data.idleTime = data.idleTime - 1
					end
					
					--Do the actual movement
					entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * 1.2
					data.targetvelocity = data.targetvelocity * 0.99
				end
				
			elseif data.State == mod.MaidMSTATE.ATTACK then
				if data.StateFrame == 1 then
					data.TargetPos = target.Position
					if data.TargetPos.X - entity.Position.X > 0 then
						sprite:Play("AttackR",true)
					else
						sprite:Play("AttackL",true)
					end
				elseif sprite:IsFinished("AttackL") or sprite:IsFinished("AttackR") then
					data.State = mod:MarkovTransition(data.State, mod.chainMaid)
					data.StateFrame = 0

				elseif sprite:IsEventTriggered("Attack") then
					local direction = (data.TargetPos - entity.Position):Normalized()
					local velocity = direction*mod.VConst.flameSpeed*1.5
					local flame = mod:SpawnEntity(mod.Entity.Flame, entity.Position, velocity, entity):ToProjectile()
					flame.FallingAccel  = -0.1
					flame.FallingSpeed = 0
					flame.Scale = 2
			
					flame:GetData().IsFlamethrower_HC = true
					flame:GetData().NoGrow = true
					flame:GetData().EmberPos = -20
				end

			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.CandleUpdate, mod.EntityInf[mod.Entity.Candle].ID)
mod:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, function(_, tear, collider)
	if tear:GetData().IsKiss_HC then
		if collider.Type == mod.EntityInf[mod.Entity.Candle].ID then
			collider:GetSprite():Play("IdleLit",true)

			local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, tear.Position, Vector.Zero, nil):ToEffect()
			cloud:GetSprite().Color = mod.Colors.fire
			tear:Remove()
		end
	end
end)

mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, function(_,entity)
	if entity.Type == mod.EntityInf[mod.Entity.CandleSiren].ID and entity.Variant == mod.EntityInf[mod.Entity.CandleSiren].VAR and entity.SubType == mod.EntityInf[mod.Entity.CandleSiren].SUB then
		for _, e in ipairs(mod:FindByTypeMod(mod.Entity.SirenRag)) do
			e:Remove()
		end
	end
end)

--Siren rag doll (I just tought it was a good name)---------------------------------------------------------------------------------
function mod:SirenRagUpdate(entity)
	if mod.EntityInf[mod.Entity.SirenRag].VAR == entity.Variant and mod.EntityInf[mod.Entity.SirenRag].SUB == entity.SubType  then
		local sprite = entity:GetSprite()
		local data = entity:GetData()

		--Init
		if data.Skip == nil then 
			data.Skip = true 

			entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)

			entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

			--sprite:ReplaceSpritesheet (0, "gfx/effects/empty.png")
			--sprite:ReplaceSpritesheet (1, "gfx/effects/empty.png")
			--sprite:ReplaceSpritesheet (2, "gfx/effects/empty.png")
			--sprite:ReplaceSpritesheet (3, "gfx/effects/empty.png")
			--sprite:ReplaceSpritesheet (4, "gfx/effects/empty.png")
			--sprite:LoadGraphics()

			sprite:Play("Idle")
		end


		--Skip all animations until Siren decides to sing
		local animName = sprite:GetAnimation()
		if animName ~= "Attack2BStart" and animName ~= "Attack2BLoop" and animName ~= "Attack2BEnd" and data.Skip == true then
			sprite:SetLastFrame ()
			entity.Visible = false
		end

		--She singed and triggered the steal
		if sprite:IsEventTriggered("SingFlag") then
			data.Skip = false
		end

		--Loop that one animation
		if data.Skip == false then
			sprite:Play("Attack2BLoop",true)
		end

		--If Its going to attack stop her
		if animName == "Attack1Start" or animName == "Teleport" then
			entity:Remove()
		end

		if entity.Parent then
			entity.Position = entity.Parent.Position
			entity.Velocity = Vector.Zero
		end

	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.SirenRagUpdate, EntityType.ENTITY_SIREN)

--Deimos & Phobos-------------------------------------------------------------------------------------------------------------------
function mod:MartiansUpdate(entity)
	local data = entity:GetData()
	local sprite = entity:GetSprite()
	local target = entity:GetPlayerTarget()

    if entity.Variant == mod.EntityInf[mod.Entity.Deimos].VAR and entity.SubType == mod.EntityInf[mod.Entity.Deimos].SUB then
		if sprite:IsEventTriggered("SetAim") and entity.Parent:GetData().State ~= mod.MMSState.AIRSTRIKE then
			data.targetAim = target.Position
			local target = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TARGET, 0, target.Position, Vector.Zero, entity):ToEffect()
			target.Timeout = 38
		elseif sprite:IsEventTriggered("Shot") and data.targetAim then
			local direction = data.targetAim - entity.Position
			local laser = EntityLaser.ShootAngle(2, entity.Position + Vector(0,-10), direction:GetAngleDegrees(), 1, Vector.Zero, entity)
			data.targetAim = nil
		end

	elseif entity.Variant == mod.EntityInf[mod.Entity.Phobos].VAR and entity.SubType == mod.EntityInf[mod.Entity.Phobos].SUB then
		if sprite:IsEventTriggered("Shot") then
            sfx:Play(Isaac.GetSoundIdByName("EnergyShot"),1)

			local targetAim = target.Position - entity.Position
			local velocity = targetAim:Normalized()*mod.MConst.shotSpeed
			local shot = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, velocity, entity):ToProjectile()
			shot.FallingSpeed = 0
			shot.FallingAccel = -0.1
		end
	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, function(_, entity)
	if entity:GetData().IsMartian and entity.Variant ~= mod.EntityInf[mod.Entity.Mars].VAR then
		mod:OrbitParent(entity)
		mod:MartiansUpdate(entity)
	end
end)

--EFFECTS---------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------


--Red things updates----------------------------------------------------------------------------------------------------------------
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, redthing)
	if redthing.Variant == mod.EntityInf[mod.Entity.RedTrapdoor].VAR and redthing.SubType == mod.EntityInf[mod.Entity.RedTrapdoor].SUB then
		if redthing:GetSprite():IsEventTriggered("Sound") then
			sfx:Play(Isaac.GetSoundIdByName("TrapdoorOC"),1)
		end
	end
end)

--Thunder---------------------------------------------------------------------------------------------------------------------------
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, light)
	if light.Variant == mod.EntityInf[mod.Entity.Thunder].VAR and light.SubType == mod.EntityInf[mod.Entity.Thunder].SUB then
		if light:GetSprite():IsEventTriggered("Hit") then
			sfx:Play(Isaac.GetSoundIdByName("Thunder"),1)
		end
	end
end)

--Snowflake
function mod:SpawnSnowflake(entity, room, speed)
	if not mod.ModConfigs.noSnow then
		if not speed then speed = 1 end
		if rng:RandomFloat() < 0.6 then
			local position = room:GetRandomPosition(0)-Vector(room:GetCenterPos().X*3.1,0)
			position = position + position*(1-2*rng:RandomFloat())/2 + (speed-1)*Vector(speed*160,speed*85)
			local velocity = Vector(10*speed,rng:RandomFloat())
			local snowflake = mod:SpawnEntity(mod.Entity.Snowflake, position, velocity, entity)

			local sprite = snowflake:GetSprite()
			local randomAnim = tostring(mod:RandomInt(1,4))
			sprite:Play("Drop0"..randomAnim,true)
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, snow)
	if snow.Variant == mod.EntityInf[mod.Entity.Snowflake].VAR and snow.SubType == mod.EntityInf[mod.Entity.Snowflake].SUB then
		local sprite = snow:GetSprite()
		local finished = sprite:IsFinished("Drop01") or sprite:IsFinished("Drop02") or sprite:IsFinished("Drop03") or sprite:IsFinished("Drop04")
		if finished then
			snow:Remove()
		end
	end
end)

--Ice updates-----------------------------------------------------------------------------------------------------------------------
function mod:IceCreep(entity)
	entity:GetSprite().Color = Color(1,1,1,1)
	if entity:GetData().iceCount <= 0 then
		entity:GetData().isIce = false
	else
		entity:GetData().iceCount = entity:GetData().iceCount - 1
	end
end

mod:AddCallback(ModCallbacks.MC_POST_EFFECT_RENDER, function(_, creep)
	if creep:GetData().isIce then
		mod:IceCreep(creep)
	end
end)
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, function(_, creep)
	if creep:GetData().isIce then
		mod:IceCreep(creep)
	end
end)

--Tornado---------------------------------------------------------------------------------------------------------------------------
function mod:TornadoUpdate(entity)
	if entity.SubType == mod.EntityInf[mod.Entity.Tornado].SUB then
		local data = entity:GetData()
		local sprite = entity:GetSprite()

		if data.Lifespan == nil then data.Lifespan = 12 end
		if data.Height == nil then data.Height = 6 end
		if data.Scale == nil then data.Scale = 0.5 end
		if data.Duped == nil then data.Duped = false end
		if data.OriginalPos == nil then data.OriginalPos = entity.Position end
		if data.Frame == nil then data.Frame = 0 end
		if data.FlagForSpawn == nil then data.FlagForSpawn = false end

		if not data.Init then
			data.Init = true
			sprite.Scale = Vector(1,1)*data.Scale

			if game:GetLevel():GetStage()==LevelStage.STAGE4_1 or game:GetLevel():GetStage()==LevelStage.STAGE4_2 then
				
				sprite:ReplaceSpritesheet (0, "gfx/effects/tornado_shiny.png")
				sprite:LoadGraphics()
			end
		end

		if data.FlagForSpawn then
			data.FlagForSpawn = false
			if not data.Duped and data.Height > 0 then
				data.Duped = true
				local tornado = mod:SpawnEntity(mod.Entity.Tornado, data.OriginalPos+Vector(0,-32*data.Scale), Vector.Zero, entity)
				tornado:GetData().Lifespan = data.Lifespan
				tornado:GetData().Height = data.Height - 1
				tornado:GetData().Scale = data.Scale * 1.3
				tornado.DepthOffset = entity.DepthOffset + 44
			end
		end

		if sprite:IsFinished("Appear") then
			sprite:Play("Idle",true)
			data.FlagForSpawn = true
		elseif sprite:IsEventTriggered("FastSpawn") and data.FastSpawn then
			data.FlagForSpawn = true
		elseif sprite:IsFinished("Idle") then
			if data.Lifespan > 0 then
				data.Lifespan = data.Lifespan - 1
				sprite:Play("Idle",true)

			else
				sprite:Play("Death",true)
			end
		elseif sprite:IsFinished("Death") then
			entity:Remove()
		end

		--Waving
		local angle = data.Frame/(data.Scale)
		entity.Position = data.OriginalPos + Vector(10*data.Scale,0)*math.sin(angle)
		data.Frame = data.Frame + 1
	end
end

mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.TornadoUpdate, mod.EntityInf[mod.Entity.Tornado].VAR)

--Airstrike---------------------------------------------------------------------------------------------------------------------------
function mod:AirstrikeUpdate(entity)
	if entity.SubType == mod.EntityInf[mod.Entity.MarsTarget].SUB then
		local data = entity:GetData()
		local sprite = entity:GetSprite()

		if data.Init == nil then
			data.Init = true
			sprite:Play("Blink",true)
			sprite:SetFrame(mod:RandomInt(1,90))
		end

		if sprite:IsFinished("Blink") then

			local airstrike = mod:SpawnEntity(mod.Entity.MarsAirstrike, entity.Position, Vector.Zero, entity.Parent)

			entity:Remove()
		end

	elseif entity.SubType == mod.EntityInf[mod.Entity.MarsAirstrike].SUB then
		local data = entity:GetData()
		local sprite = entity:GetSprite()

		if sprite:IsFinished("Falling") then

			--Explosion:
			local explosion = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, entity.Position, Vector.Zero, entity.Parent):ToEffect()
			explosion:GetSprite().Scale = Vector.One*1.5
			--Explosion damage
			for i, entity_ in ipairs(Isaac.FindInRadius(entity.Position, mod.MConst.airstrikeExplosionRadius)) do
				if entity_.Type ~= EntityType.ENTITY_PLAYER and not entity_:GetData().IsMartian then
					entity_:TakeDamage(mod.MConst.explosionDamage/2, DamageFlag.DAMAGE_EXPLOSION, EntityRef(entity), 0)
				elseif entity_.Type == EntityType.ENTITY_PLAYER then
					entity_:TakeDamage(2, DamageFlag.DAMAGE_EXPLOSION, EntityRef(entity), 0)
				end
			end

			entity:Remove()
		end

	end
end

mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.AirstrikeUpdate, mod.EntityInf[mod.Entity.MarsTarget].VAR)

--Effects that dissapear after idle-------------------------------------------------------------------------------------------------

mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)
	local valid = effect.Variant == mod.EntityInf[mod.Entity.Aurora].VAR and effect.SubType == mod.EntityInf[mod.Entity.Aurora].SUB or
	effect.Variant == mod.EntityInf[mod.Entity.TimeFreezeSource].VAR and effect.SubType == mod.EntityInf[mod.Entity.TimeFreezeSource].SUB or
	effect.Variant == mod.EntityInf[mod.Entity.TimeFreezeObjective].VAR and effect.SubType == mod.EntityInf[mod.Entity.TimeFreezeObjective].SUB or
	effect.Variant == mod.EntityInf[mod.Entity.RedTrapdoor].VAR and effect.SubType == mod.EntityInf[mod.Entity.RedTrapdoor].SUB
	if valid then
		if effect:GetSprite():IsFinished("Idle") then
			effect:Remove()
		end
	end
end)

--PROJECTILES-----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------


--Key-------------------------------------------------------------------------------------------------------------------------------
function mod:KeyUpdate(key)
	local data = key:GetData()
	if data.isOrbiting then
		mod:OrbitKey(key)
	elseif data.Lifespan < 0 then
		key:Remove()
	else
		data.Lifespan = data.Lifespan-1
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, function(_, key)
	if key.Variant == mod.EntityInf[mod.Entity.KeyKnife].VAR or key.Variant == mod.EntityInf[mod.Entity.KeyKnifeRed].VAR then
		mod:KeyUpdate(key)
	end
end)
mod:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, function(_, key, collider)
	if key.Variant == mod.EntityInf[mod.Entity.KeyKnife].VAR or key.Variant == mod.EntityInf[mod.Entity.KeyKnifeRed].VAR then
		if collider.Type == EntityType.ENTITY_PLAYER then
			if  key.SubType == mod.EntityInf[mod.Entity.KeyKnife].SUB then
				game:SpawnParticles (key.Position, EffectVariant.NAIL_PARTICLE, 3, 9)
			else
				game:SpawnParticles (key.Position, EffectVariant.TOOTH_PARTICLE, 3, 9)
			end
		end
	end
end)

--Hail------------------------------------------------------------------------------------------------------------------------------
function mod:HailProjectile(tear,collided)
	local data = tear:GetData()
	local sprite = tear:GetSprite()
	if data.Init == nil then
		data.Init = true

		--Sprite
		if tear.Variant == mod.EntityInf[mod.Entity.Icicle].VAR and tear.SubType == mod.EntityInf[mod.Entity.Icicle].SUB or
		tear.Variant == mod.EntityInf[mod.Entity.BigIcicle].VAR and tear.SubType == mod.EntityInf[mod.Entity.BigIcicle].SUB then
			sprite:Play("Idle", true)
			sprite.Rotation = tear.Velocity:GetAngleDegrees()
		end
	end

	--This leaves a trace of slippery ice
	if(data.hailTrace and math.floor(tear.Position.X+tear.Position.Y)%5==0) then
		--Spawn ice creep
		mod:SpawnIceCreep(tear.Position, mod.UConst.shotTraceIceSize, tear)
	end
	
	--If tear collided then
	if tear:IsDead() or collided then
		
		game:SpawnParticles (tear.Position, EffectVariant.DIAMOND_PARTICLE, 3, 9)
		
		--Spawn ice creep
		mod:SpawnIceCreep(tear.Position, tear:GetData().iceSize, tear)
		
		--Splash of projectiles:
		if data.hailSplash then
			for i=0, mod.UConst.nShotIcicles do
				local angle = i*360/mod.UConst.nShotIcicles
				--Ring projectiles:
				local hail = mod:SpawnEntity(mod.Entity.Icicle, tear.Position, Vector(1,0):Rotated(angle)*mod.UConst.shotIcicleSpeed, tear.Parent):ToProjectile()
				hail:GetData().IsIcicle_HC = true
				--hail:GetSprite().Color = mod.Colors.hailColor
				hail:GetData().iceSize = mod.UConst.shotIcicleIceSize
				hail:GetData().hailTrace = false
				hail:GetData().hailSplash = false
				
			end
			
			sfx:Play(Isaac.GetSoundIdByName("IceBreak"),1);
		else
			
			sfx:Play(Isaac.GetSoundIdByName("HailBreak"),1);
		end
		
		tear:Die()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, function(_, tear)
	if tear:GetData().IsIcicle_HC then
		mod:HailProjectile(tear,false)
	end
end)
mod:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, function(_, tear, collider)
	if tear:GetData().IsIcicle_HC then
		if collider.Type == EntityType.ENTITY_PLAYER then
			mod:HailProjectile(tear,true)
		end
	end
end)


--Flame-----------------------------------------------------------------------------------------------------------------------------
function mod:FireUpdate(tear, collided)
	local sprite = tear:GetSprite()
	local data = tear:GetData()

	if data.Init == nil then
		sprite:Play("Appear")
		data.Init = true
		if data.EmberPos == nil then data.EmberPos = -10 end
	end

	if sprite:IsFinished("Appear") then sprite:Play("Flickering",true) end

	sprite.Rotation = tear.Velocity:GetAngleDegrees()

	if not data.NoGrow then sprite.Scale = sprite.Scale + 0.018*Vector(1,1) end
	

	if game:GetFrameCount()%5==0 then
		--For tracing
		local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DARK_BALL_SMOKE_PARTICLE, 0, tear.Position + Vector(0,data.EmberPos), Vector.Zero, nil):ToEffect()
		cloud:GetSprite().Scale = 0.8*Vector(1,1)
		cloud:GetSprite().Color = mod.Colors.superFire
	end

	--If tear collided then
	if tear:IsDead() or collided then
		
		local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DARK_BALL_SMOKE_PARTICLE, 0, tear.Position, Vector.Zero, nil):ToEffect()
		cloud:GetSprite().Scale = 1.6*Vector(1,1)
		cloud:GetSprite().Color = mod.Colors.superFire

		tear:Die()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, function(_, tear)
	if tear:GetData().IsFlamethrower_HC then
		mod:FireUpdate(tear,false)
	end
end)
mod:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, function(_, tear, collider)
	if tear:GetData().IsFlamethrower_HC then
		if collider.Type == EntityType.ENTITY_PLAYER then
			mod:FireUpdate(tear,true)
		end
	end
end)

--Fireball---------------------------------------------------------------------------------------------------------------------------
function mod:FireballUpdate(tear, collided)
	local sprite = tear:GetSprite()
	local data = tear:GetData()

	if data.Init == nil then
		sprite:Play("Idle")
		sprite:SetFrame(mod:RandomInt(1,12))
		sprite.PlaybackSpeed = 1.5
		data.Init = true
		data.Lifespan = mod:RandomInt(40,90)

		if tear.Velocity.X < 0 then
			sprite.FlipX = true
		end
		
        tear:AddProjectileFlags(ProjectileFlags.BOUNCE)
        tear:AddProjectileFlags (ProjectileFlags.BOUNCE_FLOOR)
	end

	data.Lifespan = data.Lifespan - 1
	
	if tear.Height >= 1 then
		tear.FallingSpeed = -5;
		tear.FallingAccel = 1.5;
		tear.Height = -23
        tear:AddProjectileFlags(ProjectileFlags.BOUNCE_FLOOR)
	end

	if game:GetFrameCount()%5==0 then
		--For tracing
		local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DARK_BALL_SMOKE_PARTICLE, 0, tear.Position, Vector.Zero, nil):ToEffect()
		cloud:GetSprite().Scale = 0.4*Vector(1,1)
		cloud:GetSprite().Color = mod.Colors.superFire
		
		game:SpawnParticles (tear.Position, EffectVariant.EMBER_PARTICLE, 3, 2)
	end

	--If tear collided then
	if tear:IsDead() or collided or data.Lifespan <= 0 then
		local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DARK_BALL_SMOKE_PARTICLE, 0, tear.Position, Vector.Zero, nil):ToEffect()
		cloud:GetSprite().Scale = 0.8*Vector(1,1)
		cloud:GetSprite().Color = mod.Colors.superFire

		tear:Die()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, function(_, tear)
	if tear:GetData().IsFireball_HC then
		mod:FireballUpdate(tear,false)
	end
end)
mod:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, function(_, tear, collider)
	if tear:GetData().IsFireball_HC then
		if collider.Type == EntityType.ENTITY_PLAYER then
			mod:FireballUpdate(tear,true)
		end
	end
end)


--Kiss---------------------------------------------------------------------------------------------------------------------------
function mod:KissUpdate(tear, collided)
	local sprite = tear:GetSprite()
	local data = tear:GetData()

	if data.Init == nil then
		sprite:Play("Idle")
		data.Init = true
	end

	if sprite:IsFinished("Appear") then sprite:Play("Idle",true) end

	sprite.Color = Color.Default

	if game:GetFrameCount()%2==0 then
		--For tracing
		local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DARK_BALL_SMOKE_PARTICLE, 0, tear.Position + Vector(0,-15), Vector.Zero, nil):ToEffect()
		cloud:GetSprite().Scale = 1.4*Vector(1,1)
		cloud:GetSprite().Color = mod.Colors.superFire
		
		game:SpawnParticles (tear.Position, EffectVariant.EMBER_PARTICLE, 3, 2)
	end

	--If tear collided then
	if tear:IsDead() or collided then
		local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, tear.Position, Vector.Zero, nil):ToEffect()
		cloud:GetSprite().Color = mod.Colors.fire

		tear:Die()
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, function(_, tear)
	if tear:GetData().IsKiss_HC then
		mod:KissUpdate(tear,false)
	end
end)
mod:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, function(_, tear, collider)
	if tear:GetData().IsKiss_HC then
		if collider.Type == EntityType.ENTITY_PLAYER then
			mod:KissUpdate(tear,true)
		end
	end
end)

--Missile---------------------------------------------------------------------------------------------------------------------------
function mod:MissileUpdate(tear, collided)
	local sprite = tear:GetSprite()
	local data = tear:GetData()

	if data.Init == nil then
		data.Trigger = false

		sprite:Play("Idle", true)
		tear:AddProjectileFlags(ProjectileFlags.NO_WALL_COLLIDE)

		tear.FallingSpeed = 0
		tear.FallingAccel = -0.1

		data.Init = true
		data.Counter = 0
		data.Flag = false
	end

	sprite.Rotation = tear.Velocity:GetAngleDegrees()
	data.Counter = data.Counter + 1

	if data.Counter >= mod.MConst.missileTime and not data.Flag then
		data.Flag = true
		tear:AddProjectileFlags(ProjectileFlags.SMART_PERFECT)
	end

	--To near!
	if game:GetFrameCount()%4==0 and not data.Trigger then
		for i=0, game:GetNumPlayers ()-1 do
			local player = game:GetPlayer(i)
			if tear.Position:Distance(player.Position) < 70 then
				sprite.Rotation = 0
				sprite:Play("Explosion", true)
				data.Trigger = true
				tear:ClearProjectileFlags (ProjectileFlags.SMART_PERFECT)
				tear:AddProjectileFlags(ProjectileFlags.CANT_HIT_PLAYER)
				tear.Velocity = Vector.Zero
				break
			end
		end
	end


	if sprite:IsFinished("Explosion") then
		--Explosion:
		local explosion = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, tear.Position, Vector.Zero, tear.Parent):ToEffect()
		--Explosion damage
		for i, entity in ipairs(Isaac.FindInRadius(tear.Position, mod.MConst.missileExplosionRadius)) do
			if entity.Type ~= EntityType.ENTITY_PLAYER and not entity:GetData().IsMartian then
				entity:TakeDamage(mod.MConst.missileExplosionDamage, DamageFlag.DAMAGE_EXPLOSION, EntityRef(tear.Parent), 0)
			elseif entity.Type == EntityType.ENTITY_PLAYER then
				entity:TakeDamage(1, DamageFlag.DAMAGE_EXPLOSION, EntityRef(tear.Parent), 0)
			end
		end

		--Projectile ring
		for i=1, mod.MConst.nMissileTears do
			local angle = i*360/mod.MConst.nMissileTears
			local shot = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, tear.Position, Vector(1,0):Rotated(angle)*mod.MConst.missileTearsSpeed, tear.Parent):ToProjectile()
			shot.FallingSpeed = 0
			shot.FallingAccel = -0.1
		end

		tear:Remove()
	end


end

mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, function(_, tear)
	if tear:GetData().IsMissile_HC then
		mod:MissileUpdate(tear,false)
	end
end)

--PLAYER----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--Burning effect
function mod:PlayerBurning(entity)
	local data = entity:GetData()
	local sprite = entity:GetSprite()
	if data.BurnTime and data.BurnTime >= 0 and entity:GetPlayerType() ~= PlayerType.PLAYER_THEFORGOTTEN_B then

		--Burning Color
		if data.BurnTime == mod.ModConstants.burningFrames then
			--data.PreBurnColor = sprite.Color
		elseif data.BurnTime <= 0 then
			sprite.Color = Color.Default
			local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, entity.Position, Vector.Zero, entity)
			cloud:GetSprite().Color = Color(0.03,0.03,0.03,1)
		else
			local color = Color(2*math.abs(math.sin(game:GetFrameCount()/1.5)),1.5*math.abs(math.sin(game:GetFrameCount()/1.5)),1*math.abs(math.sin(game:GetFrameCount()/1.5)),1)
			--color:SetColorize(+0.75,0.25,0.25,1)
			color:SetColorize(2*math.abs(math.sin(game:GetFrameCount()/1.5))+1,0.5,0,1)
			sprite.Color = color
		end

		--Timer
		data.BurnTime = data.BurnTime - 1

		--Movement
		if math.abs(entity:GetMovementInput().X) + math.abs(entity:GetMovementInput().Y) > 0 then 
			data.direction = entity:GetMovementInput():Normalized()
		elseif data.direction == nil then
			data.direction = Vector(1,0)
		end

		--Bounce
		if entity:CollidesWithGrid() then
			data.direction = - data.direction
		end

		--Move
		entity.Velocity = data.direction:Rotated(2*rng:RandomFloat()-1)*7
		
		--Its a me
		local cloud = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DARK_BALL_SMOKE_PARTICLE, 0, entity.Position + Vector(0,-20), Vector.Zero, entity):ToEffect()
		cloud:GetSprite().Scale = 0.8*Vector(1,1)
		cloud:GetSprite().Color = Color(0,0,0,1)
		if game:GetFrameCount()%15==0 then
            sfx:Play(SoundEffect.SOUND_FIREDEATH_HISS,0.5)
		elseif game:GetFrameCount()%2==0 then
			game:SpawnParticles (entity.Position, EffectVariant.EMBER_PARTICLE, 2, 2)
		end

	end
end

--Burn sfx and burning effect for venus
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, entity, _, _, ref, _)
    if entity.Type == EntityType.ENTITY_PLAYER and ref.Entity then
        if (ref.Entity:GetData().IsFlamethrower_HC or  ref.Entity:GetData().IsFireball_HC or ref.Entity.Type == mod.EntityInf[mod.Entity.Venus].ID ) then
            sfx:Play(SoundEffect.SOUND_FIREDEATH_HISS)
        elseif  ref.Entity.Type == EntityType.ENTITY_PROJECTILE and ref.Entity.Variant == mod.EntityInf[mod.Entity.Kiss].VAR and ref.Entity.SubType == mod.EntityInf[mod.Entity.Kiss].SUB then
			if not entity:ToPlayer():HasCollectible(CollectibleType.COLLECTIBLE_EVIL_CHARM) then
            	entity:GetData().BurnTime = mod.ModConstants.burningFrames
			end
            sfx:Play(SoundEffect.SOUND_FIREDEATH_HISS)
			return false
        end
    end
end)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.PlayerBurning, 0)

