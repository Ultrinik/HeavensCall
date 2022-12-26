HeavensCall = RegisterMod("Heaven's call", 1)
local mod = HeavensCall
local game = Game()
local rng = RNG()
local sfx = SFXManager()
local music = MusicManager()
local json = require("json")

if mod:HasData() then
	mod.savedata = json.decode(mod:LoadData())
else
	mod.savedata = {}
end
mod.savedataOld = {}

include("scripts.roomgen")
include("scripts.roomsdata")

--GLOBAL STUFF----------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--Colors
mod.Colors = {
	boom = Color(1,1,1,1),
	boom2 = Color(1,1,1,1),
	jupiterShot = Color(2,2,2,1),
	jupiterLaser1 = Color(0.5,0.5,0.5,1),
	jupiterLaser2 = Color(1,1,1,0.95),
	hail = Color(1,1,1,0.9),
	poop = Color(1,1,1,1),
	pee = Color(1,1,1,1),
	ice = Color(1,1,1,0.7),
	frozen = Color(1,1,1,1),
	timeChanged = Color(1,1,1,1),
	fire = Color(1,1,1,1),
	superFire = Color(0.75,0.75,0.75,1),
	buttFire = Color(1,1,1,1),
	mercury = Color(0.3,0.3,0.3,1),
	tar = Color(0.5,0.5,0.5, 1, 0,0,0),
	black = Color(0,0,0,1,0,0,0),
	ghost = Color(1,1,1,0.6,1,1,1),
	greenEden = Color(0.5,1,0.5,0.6,0.4,1,0.4),
	wax = Color(1,1,1,1,1,0.85,0.8),
	booger = Color(1,1,1,1),
	white = Color(1,1,1,1),
	red = Color(10,0.5,0.5,1),
	whiteish = Color(1,1,1,1,0.1,0.1,0.1),
	redlight = Color(3,0.75,0.75,1),
	parasite = Color(0.9, 0.3, 0.08, 1, 0, 0, 0),
}
function mod:ColorizeColors()
	mod.Colors.boom:SetColorize(1.3,2,0.7,1)
	mod.Colors.boom2:SetColorize(1.9,2.5,1.4,1)
	mod.Colors.jupiterShot:SetColorize(1.9,2.5,1.4,1)
	mod.Colors.jupiterLaser1:SetColorize(1.9,2.5,1.4,1)
	mod.Colors.jupiterLaser2:SetColorize(3.75,3.75,6.5,1)
	mod.Colors.hail:SetColorize(1,1.5,2.5,1)
	mod.Colors.poop:SetColorize(1.2,0.7,0.6,1)
	mod.Colors.pee:SetColorize(3,2.7,0.1,1)
	mod.Colors.ice:SetColorize(5,7,10,1)
	mod.Colors.frozen:SetColorize(1.5,2,3,1)
	mod.Colors.timeChanged:SetColorize(1,0.2,0.2,1)
	mod.Colors.fire:SetColorize(5,2.5,0,1)
	mod.Colors.superFire:SetColorize(20,7,0,1)
	mod.Colors.buttFire:SetColorize(2,1,0,1)
	mod.Colors.mercury:SetColorize(7,5,7,1)
	mod.Colors.tar:SetColorize(1, 1, 1, 1)
	mod.Colors.booger:SetColorize(0.3, 2, 0.2, 1)
	mod.Colors.red:SetColorize(5, 0, 0, 1)
	mod.Colors.white:SetColorize(10, 10, 10, 1)
	mod.Colors.whiteish:SetColorize(5, 5, 5, 1)
	mod.Colors.redlight:SetColorize(4, 1, 1, 1)
end
mod:ColorizeColors()

--Collectibles that can spawn
mod.AstralChallengePoolExtras = {
	[1] = CollectibleType.COLLECTIBLE_ARIES,
	[2] = CollectibleType.COLLECTIBLE_TAURUS,
	[3] = CollectibleType.COLLECTIBLE_GEMINI,
	[4] = CollectibleType.COLLECTIBLE_LEO,
	[5] = CollectibleType.COLLECTIBLE_CANCER,
	[6] = CollectibleType.COLLECTIBLE_VIRGO,
	[7] = CollectibleType.COLLECTIBLE_LIBRA,
	[8] = CollectibleType.COLLECTIBLE_SCORPIO,
	[9] = CollectibleType.COLLECTIBLE_SAGITTARIUS,
	[10] = CollectibleType.COLLECTIBLE_CAPRICORN,
	[11] = CollectibleType.COLLECTIBLE_AQUARIUS,
	[12] = CollectibleType.COLLECTIBLE_PISCES,
	[13] = CollectibleType.COLLECTIBLE_ZODIAC
}
function mod:AddItemToPool(item)
	mod.AstralChallengePoolExtras[#(mod.AstralChallengePoolExtras)+1] = item
end

--Flags and things that are not flags lol
mod.ModFlags = {
	globalTimestuck = false,
	glowingHourglass = 0,
	currentMusic = nil,
	noPool = false,
	forceSpawn = false,

	ErrorRoom = false,
	ErrorRoomSource = -2,
	ErrorRoomSlot = -1,

	venusCounter = 0,
	venusPosition = Vector.Zero,
	venusHeat = false,

	SpikeHits = 0,
}
mod.ModConfigs = {
	noRain = false,
	noSnow = false,
	roomSpawnChance = 7,
	roomSpawnChance2 = 30,
	altUranus = false,
}
mod.ModConstants = {
	burningFrames = 300
}

include("scripts.findentities")

--Room and planet
mod.RoomsPlanet = {
	[8500] = mod.Entity.Jupiter,
	[8501] = mod.Entity.Saturn,
	[8502] = mod.Entity.Uranus,
	[8503] = mod.Entity.Neptune,
	[8505] = mod.Entity.Mercury,
	[8506] = mod.Entity.Venus,
	[8507] = mod.Entity.Terra1,
	[8508] = mod.Entity.Mars,
}

--SILLY FUCTIONS--------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

-- Random int between Min and Max, both inclusive
function mod:RandomInt(Min, Max)
    if Min > Max then 
        print("El minimo ta' ma grande Ñ")
    else
        return Min + rng:RandomInt(Max + 1 - Min)
    end
end

--Return the nearest integer from n in a list
function mod:Takeclosest(list, n)
    local difference = math.abs(list[1]-n)
	local current = list[1]
	for i=2, #list do
		if (math.abs(list[i]-n) < difference) then
			difference = math.abs(list[i]-n)
			current = list[i]
		end
	end
	return current
end

--Somebody as X item?
function mod:SomebodyHasItem(item)
	for i=0, game:GetNumPlayers ()-1 do
		local player = game:GetPlayer(i)
		if player:HasCollectible (item,true) then 
			return true
		end
	end
	return false
end
--Somebody as X trinket?
function mod:SomebodyHasTrinket(trinket)
	for i=0, game:GetNumPlayers ()-1 do
		local player = game:GetPlayer(i)
		if player:HasTrinket(trinket,false) then 
			return true
		end
	end
	return false
end

-- Move to a specific position
function mod:MoveTowards(entity, data, objective, velocity)
	if entity.Position:Distance(objective) < 45 then
		entity.Velocity = Vector.Zero
		--entity.Position = objective
		data.MoveTowards = false
	else
		data.targetvelocity = (objective - entity.Position):Normalized()*2
		--Do the actual movement
		entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * velocity
	end
end

function mod:IsOutsideRoom(point, room)
	local marginX = 50
	local marginY = 50

	local varX = room:GetCenterPos(0).X - point.X
	local varY = room:GetCenterPos(0).Y - point.Y
	if varX > 0 then --p left
		if varY > 0 then--p up
			point = Vector(point.X - 1.65*marginX , point.Y - 1.65*marginY)
		else--p down
			point = Vector(point.X - 1.65*marginX , point.Y + marginY)
		end
	else --p right
		if varY > 0 then--p up
			point = Vector(point.X + 0.95*marginX , point.Y - 1.65*marginY)
		else--p down
			point = Vector(point.X + 0.95*marginX , point.Y + marginY)
		end
	end

	if room:GetGridIndex(point) == -1 then 
		return true 
	else
		return false
	end
end

--ded
function mod:NormalDeath(entity, notExplosion, mamaMega)
	mod.ModFlags.SpikeHits = 0

	local data = entity:GetData()

	if mod.ModFlags.currentMusic then
		music:Crossfade (mod.ModFlags.currentMusic, 1)
		mod.ModFlags.currentMusic = nil
	end

	--Explosion
	if not notExplosion then
		mod:SpawnGlassFracture(entity, 1.5)

		if mamaMega then
			game:GetRoom():MamaMegaExplosion(entity.Position)

			if mod.savedata.planetAlive then
				local center = game:GetRoom():GetCenterPos()

				mod:PausePool()
				local reward = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, -1, entity.Position, Vector.Zero, nil)

				if game:GetLevel():GetStage() == LevelStage.STAGE5 then
					local winChest = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_BIGCHEST, 0, center, Vector.Zero, nil)
					if rng:RandomFloat() <= 0.5 then
						
						local voidPortal = Isaac.GridSpawn(GridEntityType.GRID_TRAPDOOR, 1, center + Vector(0,75), true)
						voidPortal.VarData = 1
						
						-- Replace the spritesheet to make it look like a Void Portal
						local sprite = voidPortal:GetSprite()
						sprite:Load("gfx/grid/voidtrapdoor.anm2", true)
					end
				end

			end
		else
			--local gigaBomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_GIGA, 0, entity.Position, Vector.Zero, entity ):ToBomb()
			--gigaBomb:SetExplosionCountdown(0)
			--game: BombExplosionEffects  ( entity.Position, 100, 120, true, entity, TearFlags.TEAR_NORMAL, DamageFlag.DAMAGE_EXPLOSION, false )

			game:BombExplosionEffects ( entity.Position, 100, TearFlags.TEAR_NORMAL, Color.Default, nil, 1.45, true, false, DamageFlag.DAMAGE_EXPLOSION )

			--local bomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_BIG, 0, entity.Position, Vector.Zero, entity ):ToBomb()
			--bomb:SetExplosionCountdown(0)
			--bomb.ExplosionDamage = 150
			--bomb.RadiusMultiplier = 1.45
			--bomb.Visible = false
		end
		sfx:Play(Isaac.GetSoundIdByName("SuperExplosion"),0.6)
        game:ShakeScreen(60)

	
		if mod.savedata.planetAlive then
			mod:RemoveCallback(ModCallbacks.MC_POST_NPC_RENDER, mod.Dyings)
			if mamaMega then
				mod.savedata.planetKilled2 = true
			else
				mod.savedata.planetKilled1 = true
			end
		end
		mod.savedata.planetAlive = false
	end
end
--deding
function mod:Dyings(entity)
	if entity:GetData().HeavensCall then
		if entity.Type == mod.EntityInf[mod.Entity.Jupiter].ID and entity.Variant == mod.EntityInf[mod.Entity.Jupiter].VAR then
			mod:JupiterDying(entity)
		elseif entity.Type == mod.EntityInf[mod.Entity.Saturn].ID and entity.Variant == mod.EntityInf[mod.Entity.Saturn].VAR then
			mod:SaturnDying(entity)
		elseif entity.Type == mod.EntityInf[mod.Entity.Uranus].ID and entity.Variant == mod.EntityInf[mod.Entity.Uranus].VAR then
			mod:UranusDying(entity)
		elseif entity.Type == mod.EntityInf[mod.Entity.Neptune].ID and entity.Variant == mod.EntityInf[mod.Entity.Neptune].VAR then
			mod:NeptuneDying(entity)
		elseif entity.Type == mod.EntityInf[mod.Entity.Mercury].ID and entity.Variant == mod.EntityInf[mod.Entity.Mercury].VAR then
			mod:MercuryDying(entity)
		elseif entity.Type == mod.EntityInf[mod.Entity.Venus].ID and entity.Variant == mod.EntityInf[mod.Entity.Venus].VAR then
			mod:VenusDying(entity)
		elseif entity.Type == mod.EntityInf[mod.Entity.Terra1].ID then
			mod:TerraDying(entity)
		elseif entity.Type == mod.EntityInf[mod.Entity.Mars].ID and entity.Variant == mod.EntityInf[mod.Entity.Mars].VAR then
			mod:MarsDying(entity)
		end
	end
end

--U know this thing
function mod:MarkovTransition(state, chain)
	local roll = math.random()
	for i = 1, #chain+1 do
		roll = roll - chain[state][i]
		if roll <= 0 then
			return i - 1
		end
	end
	return "lol lmao"
end

--Shuffles a list, from Tainted Treasure
function mod:Shuffle(list)
	for i = #list, 2, -1 do
		local j = mod:RandomInt(1, i)
		list[i], list[j] = list[j], list[i]
	end
	return list
end

--Look at the correct direction
function mod:FaceTarget(entity, target)
	if entity.Position.X < target.Position.X then
		entity:GetSprite().FlipX = true
	else
		entity:GetSprite().FlipX = false
	end
end

--Some callbacks can't execute certain functions at the time they are execute, so we delay them
function mod:runUpdates(delayedFuncs) --This is from Fiend Folio
    for i = #delayedFuncs, 1, -1 do
        local f = delayedFuncs[i]
        f.Delay = f.Delay - 1
        if f.Delay <= 0 then
            f.Func()
            table.remove(delayedFuncs, i)
        end
    end
end
mod.delayedFuncs = {}
function mod:scheduleForUpdate(foo, delay, callback)
    callback = callback or ModCallbacks.MC_POST_UPDATE
    if not mod.delayedFuncs[callback] then
        mod.delayedFuncs[callback] = {}
        mod:AddCallback(callback, function()
            mod:runUpdates(mod.delayedFuncs[callback])
        end)
    end

    table.insert(mod.delayedFuncs[callback], { Func = foo, Delay = delay })
end

--Random Element from table
function mod:random_elem(tb)
    local keys = {}
    for k in pairs(tb) do table.insert(keys, k) end
    return tb[keys[math.random(#keys)]]
end

--Save
mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function(_, shouldSave)
	if shouldSave then
		if mod.savedata.planetAlive and mod.savedata.planetNum then
			local planet = mod:FindByTypeMod(mod.savedata.planetNum)
			if planet~=nil and #planet>0 and planet[1]~=nil then
				mod.savedata.planetHP = planet[1].HitPoints --There should not be more than 1 planet at the same time so... (we dont talk about meat cleaver)
				--print(mod.savedata.planetHP)
			end
		end

		mod:SaveData(json.encode(mod.savedata))
	end
end)

--Equals two saves
function mod:EqualSaves(save1, save2)
	if save2.planetNum ~= nil then save1.planetNum = save2.planetNum end
	if save2.planetAlive ~= nil then save1.planetAlive = save2.planetAlive end
	if save2.planetKilled1 ~= nil then save1.planetKilled1 = save2.planetKilled1 end
	if save2.planetKilled2 ~= nil then save1.planetKilled2 = save2.planetKilled2 end
	if save2.planetHP ~= nil then save1.planetHP = save2.planetHP end
	if save2.spawnchancemultiplier ~= nil then save1.spawnchancemultiplier = save2.spawnchancemultiplier end
end

--Spawn entity from mod
function mod:SpawnEntity(entityNum, position, velocity, origin)
	local entity = Isaac.Spawn(mod.EntityInf[entityNum].ID, mod.EntityInf[entityNum].VAR, mod.EntityInf[entityNum].SUB, position, velocity, origin)
	entity:GetData().HeavensCall = true
	return entity
end

--Find mod entity
function mod:FindByTypeMod(entityNum)
	return Isaac.FindByType(mod.EntityInf[entityNum].ID, mod.EntityInf[entityNum].VAR, mod.EntityInf[entityNum].SUB)
end

--Spawn
function mod:AppearPlanet(entity)
	local sprite = entity:GetSprite()
	local data = entity:GetData()
	if data.SlowSpawn then
		sprite:Play("AppearSlow",true)
		mod:scheduleForUpdate(function()
			local game = Game()
			local hud = game:GetHUD()
	
			local planetName = mod.PlanetName[mod.savedata.planetNum]
			if planetName then
				hud:ShowItemText(planetName.." has awakened","")
			end
		end, 95)
	else
		sprite:Play("Appear",true)
		local trapdoor = mod:SpawnEntity(mod.Entity.RedTrapdoor, entity.Position, Vector.Zero, entity)

		if entity.Type == mod.EntityInf[mod.Entity.Luna].ID then
			trapdoor:GetSprite():Play("BigIdle", true)
		end

		if mod.ModFlags.glowingHourglass > 0 then
			local timestuck = mod:SpawnEntity(mod.Entity.TimeFreezeObjective, entity.Position, Vector.Zero, entity)
			timestuck:GetSprite().Scale = Vector(1,1)*0.5
			sfx:Play(Isaac.GetSoundIdByName("TimeResume"),2)
		end
	end
	mod.ModFlags.glowingHourglass = 0


	entity:AddEntityFlags(EntityFlag.FLAG_NO_BLOOD_SPLASH)

	mod:scheduleForUpdate(function()
		--Pedestals
		for _,pedestal in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0)) do
				pedestal:Remove()
		end

		--Music
		if mod.savedata.planetAlive then
			if data.SlowSpawn then
				mod.ModFlags.currentMusic = music:GetCurrentMusicID ()
	
				local customMusic = Isaac.GetMusicIdByName("Supernova")
				music:Crossfade (customMusic, 2)
				music:Queue(Isaac.GetMusicIdByName("Supernova_loop"))
			else
				local customMusic = Isaac.GetMusicIdByName("Supernova_loop")
				music:Crossfade (customMusic, 2)
			end
		end

	end,5)


end

include("scripts.otherentities")
include("scripts.outerplanets")
include("scripts.innerplanets")
include("scripts.specialplanets")

--ASTRAL CHALLENGE ROOM THINGS------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--Minimapi magic
if MinimapAPI then
	local ac_sprite = Sprite()
	ac_sprite:Load("gfx/ui/minimapapi/astralchallengeicon.anm2", true)
	ac_sprite:SetFrame("IconAstralChallenge", 0)
	MinimapAPI:AddIcon("AstralChallenge", ac_sprite)
end
mod.minimaprooms = {} --Stores rooms that need to be updated on MinimapAPI

function mod:IsRoomDescAstralChallenge(roomdesc) --Oh yes, if true return true, if false, return false, nice
	if roomdesc and roomdesc.Data and roomdesc.Data.Type == RoomType.ROOM_DICE and roomdesc.Data.Variant >= mod.minvariant1 and roomdesc.Data.Variant <= mod.maxvariant2 then
		return true
	else
		return false
	end
end
function mod:IsRedRoom(roomdesc)
	return roomdesc.Flags & RoomDescriptor.FLAG_RED_ROOM == RoomDescriptor.FLAG_RED_ROOM
end

--Load (or reset) things when the run is started or continued
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(_, iscontinued)
	mod.ModFlags.SpikeHits = 0

	if not iscontinued then
		rng:SetSeed(Game():GetSeeds():GetStartSeed(), 35)
		--In new run do that
		mod.savedata.spawnchancemultiplier = 1
		mod.savedata.planetAlive = false
		mod.savedata.planetKilled1 = false
		mod.savedata.planetKilled2 = false
		mod.savedata.planetNum = 0
		mod.savedata.planetHP = 1

		mod:EqualSaves(mod.savedataOld, mod.savedata)

		mod:SaveData(json.encode(mod.savedata))
		
		mod.ModFlags.forceSpawn = false
	else
		local room = game:GetRoom()
		local level = game:GetLevel()
		local roomdesc = level:GetCurrentRoomDesc()
		if mod.savedata.planetAlive and mod:IsRoomDescAstralChallenge(roomdesc) then
			mod:scheduleForUpdate(function()
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
			end, 0)
		end
	end

	if mod:HasData() then
		mod.savedata = json.decode(mod:LoadData())
	else
		mod.savedata = {}
	end

	if iscontinued and not BasementRenovator and not mod.roomdata then
		if REVEL then
			mod:scheduleForUpdate(function()
				mod.roomdata = {}
				mod:InitializeRoomData("dice", mod.minvariant1, mod.maxvariant2, mod.roomdata)
			end, 3, ModCallbacks.MC_POSTR)
		else
			mod:scheduleForUpdate(function()
				mod.roomdata = {}
				mod:InitializeRoomData("dice", mod.minvariant1, mod.maxvariant2, mod.roomdata)
			end, 0, ModCallbacks.MC_POST_RENDER)
		end
	end
end)

--Will the room spawn??? 👀
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function(_)
	mod.ModFlags.SpikeHits = 0

	if REVEL then
		mod:scheduleForUpdate(function()
			mod:AstralRoomGenerator()
		end, 3, ModCallbacks.MC_POST_UPDATE)
	else
		mod:AstralRoomGenerator()
	end
end)
function mod:AstralRoomGenerator()
	--Handles Astral Challenge spawning
	local level = game:GetLevel()

	--Initialize mod.roomdata
	if not mod.roomdata and level:GetStage() ~= LevelStage.STAGE1_1 and not BasementRenovator then
		mod.roomdata = {}
		mod:InitializeRoomData("dice", mod.minvariant1, mod.maxvariant2, mod.roomdata)
	end

	local spawnChance = 0
	--Spawn floors
	local stageMin = LevelStage.STAGE2_1
	local stageLimit = LevelStage.STAGE3_2
	if mod:SomebodyHasTrinket(TrinketType.TRINKET_TELESCOPE_LENS) then
		stageLimit = LevelStage.STAGE4_2
	end

	local totalchance = 0

	local corpseFlag = ( (level:GetStage() == LevelStage.STAGE4_1 or level:GetStage() == LevelStage.STAGE4_2) and ( level:GetStageType() == StageType.STAGETYPE_REPENTANCE or level:GetStageType() == StageType.STAGETYPE_REPENTANCE_B ))

	if (level:GetStage() < LevelStage.STAGE5 and not corpseFlag) and not mod.savedata.planetAlive and not mod.savedata.planetKilled1 then

		--If the room can spawn, the chance is 0.2
		if level:GetStage() >= stageMin and level:GetStage() <= stageLimit and not game:IsGreedMode() and not level:IsAscent() then
			if mod.ModConfigs.roomSpawnChance == nil then mod.ModConfigs.roomSpawnChance = 7 end

			if level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH == LevelCurse.CURSE_OF_LABYRINTH then
				spawnChance = spawnChance + (1 - (1-mod.ModConfigs.roomSpawnChance/100)^2)--You dont add probabilities
			else
				spawnChance = spawnChance + mod.ModConfigs.roomSpawnChance/100
			end
		end
		
		--Apply persistent multiplier
		if mod.savedata.spawnchancemultiplier == nil then mod.savedata.spawnchancemultiplier = 1 end
		totalchance = mod.savedata.spawnchancemultiplier*spawnChance

	elseif (level:GetStage() == LevelStage.STAGE5 or corpseFlag) and not mod.savedata.planetAlive and not mod.savedata.planetKilled2 then
		if mod.ModConfigs.roomSpawnChance2 == nil then mod.ModConfigs.roomSpawnChance2 = 30 end
		totalchance = mod.ModConfigs.roomSpawnChance2/100
		if corpseFlag then
			totalchance = 1 - (1-totalchance)^0.5
		end
	end

	if totalchance > 0 then
		local randomchance = rng:RandomFloat()
		if randomchance <= totalchance or mod.ModFlags.forceSpawn then
			--SPAWN IT! (It may not spawn if there is absolutelly no avalible space in the stage...)
			local newroomdesc = mod:GenerateRoomFromDataset(mod.roomdata, true)
			if not newroomdesc then 
				mod.ModFlags.forceSpawn = true
			else
				mod.ModFlags.forceSpawn = false
					
				--The little wisps to mark that the room spawned
				for i=1,5 do
					local wisp = Isaac.Spawn(EntityType.ENTITY_EFFECT,EffectVariant.WISP,0,game:GetRoom():GetRandomPosition(0),Vector.Zero,nil)
				end
			end
		end
	end
end

--Door and room things
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function(_) --Tainted treasure room was used as the reference for managing new room types Andromeda was used as the reference for managing new room types

	--Secondary things
	mod:EqualSaves(mod.savedataOld, mod.savedata)
	mod:CheckSpawnNewRoom()
	mod.ModFlags.globalTimestuck = false
	mod.ModFlags.glowingHourglass = mod.ModFlags.glowingHourglass - 1

	--things
	local level = game:GetLevel()
	local roomidx = level:GetCurrentRoomIndex()
	local roomdesc = level:GetCurrentRoomDesc()
	local roomdata = roomdesc.Data
	local room = game:GetRoom()
	local roomtype = room:GetType()

	--Door(s)
	for i = 0, DoorSlot.NUM_DOOR_SLOTS do
		local door = room:GetDoor(i)
		if door then
			local targetroomdesc = level:GetRoomByIdx(door.TargetRoomIndex)

			--print(mod.ModFlags.ErrorRoom)
			--print(level:GetRoomByIdx(roomdesc.GridIndex).GridIndex == mod.ModFlags.ErrorRoomSource)
			--print(mod.ModFlags.ErrorRoomSlot == i)
			--print()

			if mod:IsRoomDescAstralChallenge(targetroomdesc) then
				local doorSprite = door:GetSprite()

				if not isOnRevelStage then
					doorSprite:Load("gfx/grid/astralchallengeroor.anm2", true)
				end

				isOnRevelStage = REVEL and (REVEL.STAGE.Glacier:IsStage() or REVEL.STAGE.Tomb:IsStage())

				if isOnRevelStage then
					local doorEffect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.DOOR_OUTLINE, 0, door.Position, Vector.Zero, nil):ToEffect()
					doorEffect.DepthOffset = -100

					local doorEffectSprite = doorEffect:GetSprite()

					doorEffectSprite.Rotation = doorSprite.Rotation

					doorEffectSprite:Load("gfx/effect_RevelationDoor.anm2", true)

					mod.RevelationDoor = door;

					if REVEL.STAGE.Glacier:IsStage() then

						for i=0,4 do
							doorEffectSprite:ReplaceSpritesheet(i, "gfx/grid/glacier_astralchallengedoor.png")
						end
					elseif REVEL.STAGE.Tomb:IsStage() then

						for i=0,4 do
							doorEffectSprite:ReplaceSpritesheet(i, "gfx/grid/tomb_astralchallengedoor.png")
						end
					end

					--doorEffectSprite:Play(doorSprite:GetAnimation(), true)
					doorEffectSprite:LoadGraphics()
				end
				doorSprite:LoadGraphics()

				doorSprite:Play("Closed")
				
				door:SetLocked (false)
			elseif mod.ModFlags.ErrorRoom and mod.ModFlags.ErrorRoomSource == level:GetRoomByIdx(roomdesc.GridIndex).GridIndex and 
				mod.ModFlags.ErrorRoomSlot == i then
					
				local doorSprite = door:GetSprite()
				doorSprite.Scale = Vector.Zero

				door:SetVariant (DoorVariant.DOOR_LOCKED_BARRED)
				door:Init(1)

			end
		end
	end
	
	if mod:IsRoomDescAstralChallenge(roomdesc) then

		local dice = Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.DICE_FLOOR)
		--This only executes the first time you enter
		if #dice > 0 then
			--Remove dice floor
			for i = 1, #dice do
				dice[i]:Remove()
			end

			--The little wisps
			for i=1,15 do
				local wisp = Isaac.Spawn(EntityType.ENTITY_EFFECT,EffectVariant.WISP,0,room:GetRandomPosition(0),Vector.Zero,nil)
			end

		end

		--things
		local itemPool = game:GetItemPool()
		local room = game:GetRoom()

		--Change background, but not the actual background but the floor and walls, but there are no walls. Was it clear? good
		game:ShowHallucination (0,BackdropType.PLANETARIUM)
		sfx:Stop (SoundEffect.SOUND_DEATH_CARD)--Silence the ShowHallucination sfx

		--Now the actual background and walls
		--SPACEEE
		local wallspos = room:GetCenterPos()-Vector(0,1)*room:GetCenterPos().Y/2
		local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.WOMB_TELEPORT, 0, wallspos, Vector.Zero, nil) --Some inert thing thats in the floor
		local sprite = effect:GetSprite()
		sprite.Color = Color(1,1,1,1)
		sprite:Load("gfx/backdrop/astralchallengecosmos.anm2", true)
		sprite:LoadGraphics()
		sprite:Play("idle", true)

		local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.WOMB_TELEPORT, 0, wallspos, Vector.Zero, nil) --Some inert thing thats in the floor
		local sprite = effect:GetSprite()
		sprite.Color = Color(1,1,1,1)
		sprite:Load("gfx/backdrop/astralchallengestars1.anm2", true)
		sprite:LoadGraphics()
		sprite:Play("idle", true)
		
		--Floor
		--local wallspos = Vector(-442/2,-52)
		--local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.WOMB_TELEPORT, 0, wallspos, Vector.Zero, nil) --Some inert thing thats in the floor
		--local sprite = effect:GetSprite()
		--sprite.Color = Color(1,1,1,1)
		--sprite:Load("gfx/backdrop/astralchallengefloor.anm2", true)
		--sprite:LoadGraphics()
		--sprite:Play("idle", true)
		
		--Walls
		local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.WORMWOOD_HOLE, 0, wallspos, Vector.Zero, nil) --Some inert thing thats in the floor
		effect:AddEntityFlags(EntityFlag.FLAG_FREEZE)
		local sprite = effect:GetSprite()
		sprite.Color = Color(1,1,1,1)
		sprite:Load("gfx/backdrop/astralchallengewalls.anm2", true)
		sprite:LoadGraphics()
		sprite:Play("1x1_room", true)

		--What planet should spawn
		if mod.RoomsPlanet[roomdesc.Data.Variant] ~= nil and not (mod.savedata.planetNum == mod.Entity.Terra2 and mod.RoomsPlanet[roomdesc.Data.Variant] == mod.Entity.Terra1) then
			mod.savedata.planetNum = mod.RoomsPlanet[roomdesc.Data.Variant]
		end


		--Do not appear again >:(
		mod.savedata.spawnchancemultiplier = 0
		--mod:SaveData(json.encode(mod.savedata))

		--Door again, but opened
		for i = 0, DoorSlot.NUM_DOOR_SLOTS do
			local door = room:GetDoor(i)
			if door then
				local doorSprite = door:GetSprite()
				doorSprite:Load("gfx/grid/astralchallengeroor.anm2", true)
				doorSprite:ReplaceSpritesheet(0, "gfx/grid/astralchallengedoor.png")
				doorSprite:Play("Opened")
			end
		end
	end
	
	if mod:IsRedRoom(roomdesc) and room:GetRoomShape() == RoomShape.ROOMSHAPE_1x1 then
		local position = nil
		local extra = 110
		if mod:RandomInt(0,1) == 0 then
			local random = mod:RandomInt(63, 577)
			if mod:RandomInt(0,1) == 0 then
				position = Vector(random, 142-extra)
			else
				position = Vector(random, 417+extra)
			end
		else
			local random = mod:RandomInt(142, 417)
			if mod:RandomInt(0,1) == 0 then
				position = Vector(63-extra, random)
			else
				position = Vector(577+extra, random)
			end
		end

		mod:SpawnEntity(mod.Entity.ICUP, position, Vector.Zero, nil)
	end

	--Minimapi things
	if MinimapAPI and #mod.minimaprooms > 0 then
		for i, roomidx in pairs(mod.minimaprooms) do
			local minimaproom = MinimapAPI:GetRoomByIdx(roomidx)
			mod:scheduleForUpdate(function()
				if minimaproom then
					minimaproom.Color = Color(MinimapAPI.Config.DefaultRoomColorR, MinimapAPI.Config.DefaultRoomColorG, MinimapAPI.Config.DefaultRoomColorB, 1, 0, 0, 0)
					if mod:IsRoomDescAstralChallenge(minimaproom.Descriptor) then
						minimaproom.PermanentIcons = {"AstralChallenge"}
					end
					mod.minimaprooms[i] = nil
				end
			end, 0)
		end
	else
		mod.minimaprooms = {}
	end

end)

	--[[
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
	--things
	local level = game:GetLevel()
	local room = game:GetRoom()

	for i = 0, DoorSlot.NUM_DOOR_SLOTS do
		local door = room:GetDoor(i)
		if door then
			local targetroomdesc = level:GetRoomByIdx(door.TargetRoomIndex)
			if mod:IsRoomDescAstralChallenge(targetroomdesc) then

				--mod:scheduleForUpdate(function()

				local doorSprite = door:GetSprite()
				doorSprite:Load("gfx/grid/astralchallengeroor.anm2", true)
				doorSprite:ReplaceSpritesheet(0, "gfx/grid/astralchallengedoor.png")

				if REVEL and false then
					if REVEL.STAGE.Glacier:IsStage() then
						doorSprite:ReplaceSpritesheet(0, "gfx/grid/glacier_astralchallengedoor.png")
					elseif REVEL.STAGE.Tomb:IsStage() then
						doorSprite:ReplaceSpritesheet(0, "gfx/grid/tomb_astralchallengedoor.png")
					end
				end
				doorSprite:LoadGraphics()
				doorSprite:Play("Closed")
				door:SetLocked (false)
				
				--end,1,ModCallbacks.MC_POST_UPDATE)
			end
		end
	end

end)]]

--FUNNY INTERACTIONS----------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--Reset chances if glowing hourglass was used
mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_,item)
	if item == CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS and mod.savedata.planetNum ~= mod.Entity.Saturn then
		mod:EqualSaves(mod.savedata, mod.savedataOld)
		--mod:SaveData(json.encode(mod.savedata))
	elseif item == CollectibleType.COLLECTIBLE_GLOWING_HOUR_GLASS and mod.savedata.planetNum == mod.Entity.Saturn then
		mod.ModFlags.glowingHourglass = 2--You are not going to scape
	end
end)
--Trying to steal the item
mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_,item)
	if item == CollectibleType.COLLECTIBLE_MOVING_BOX or item == CollectibleType.COLLECTIBLE_VOID or item == CollectibleType.COLLECTIBLE_ABYSS then
		local statues = mod:FindByTypeMod(mod.Entity.Statue)
		if #statues > 0 then
			local statue = statues[1]
			mod:StatueDie(statue)
			statue:GetSprite():Play("Death")
		end
	end
end)
mod:AddCallback(ModCallbacks.MC_USE_CARD, function(_,card)
	if card == Card.RUNE_BLACK or card == Card.CARD_REVERSE_HERMIT then
		local statues = mod:FindByTypeMod(mod.Entity.Statue)
		if #statues > 0 then
			local statue = statues[1]
			mod:StatueDie(statue)
			statue:GetSprite():Play("Death")
		end
	end
end)
--Uranus shitting
mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_,item)
	if item == CollectibleType.COLLECTIBLE_FLUSH and not mod.ModConfigs.altUranus then
		for _, e in ipairs(mod:FindByTypeMod(mod.Entity.Uranus)) do
			e:GetData().State = mod.UMSState.SPIN
			e:GetData().StateFrame = 0
			mod:UranusThank(e, e:GetData(), e:GetSprite())
		end
	end
end)
--Can spawn after R key
mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_,item)
	if item == CollectibleType.COLLECTIBLE_R_KEY and not mod.savedata.planetAlive then
		mod.savedata.spawnchancemultiplier = 1
		mod.savedata.planetKilled1 = false
		mod.savedata.planetKilled2 = false
	end
end)
--Not Death Certificate or Genesis
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_,item)
	if mod.savedata.planetAlive and ( item == CollectibleType.COLLECTIBLE_GENESIS or item == CollectibleType.COLLECTIBLE_DEATH_CERTIFICATE ) then
		sfx:Play(SoundEffect.SOUND_BOSS2INTRO_ERRORBUZZ,1)
		return true
	end
end)
--Eternal D6
mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_,item)
	mod:RemoveCallback(ModCallbacks.MC_POST_NPC_RENDER, mod.StatueRenderUpdate)
	if item == CollectibleType.COLLECTIBLE_ETERNAL_D6 then
		mod:scheduleForUpdate(function()
			mod:AddCallback(ModCallbacks.MC_POST_NPC_RENDER, mod.StatueRenderUpdate, mod.EntityInf[mod.Entity.Statue].ID)
			for _,pedestal in ipairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, 0)) do
				pedestal:GetData().WasDeleted = true
			end
		end,1)
	end
end)

--PLANET RESPAWN--------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--Check Spawn Planet in new room
function mod:CheckSpawnNewRoom()
	if mod.savedata and mod.savedata.planetAlive then
		mod:scheduleForUpdate(function()
			mod:SpawnPlanet(mod.savedata.planetNum)
		end, 0, ModCallbacks.MC_POST_RENDER)
	else
		mod.ModFlags.venusHeat = false
	end
end
--SpawnPlanet if room changed or continued
function mod:SpawnPlanet(entityNum)
	local validType = entityNum==mod.Entity.Jupiter or entityNum==mod.Entity.Saturn or entityNum==mod.Entity.Uranus or entityNum==mod.Entity.Neptune
	or entityNum==mod.Entity.Mercury or entityNum==mod.Entity.Venus or entityNum==mod.Entity.Terra1 or entityNum==mod.Entity.Terra2 or entityNum==mod.Entity.Mars
	if validType and #(mod:FindByTypeMod(entityNum))==0 then
		
		local position = Isaac.GetRandomPosition()
		for i=1, 50 do
			if position:Distance(Isaac.GetPlayer(0).Position) > 200 then break end
			position = Isaac.GetRandomPosition()
		end

		local planet = mod:SpawnEntity(entityNum, position, Vector.Zero, nil)
		planet.HitPoints = mod.savedata.planetHP
	end
end

--Statue things (why onether call instead of using the one above? idk) I changed the function order, so I think this doesnt makes sense
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function(_)
	--things
	local level = game:GetLevel()
	local roomdesc = level:GetCurrentRoomDesc()
	
	local isAstralChallenge = mod:IsRoomDescAstralChallenge(roomdesc)
	if isAstralChallenge then
		
		mod:scheduleForUpdate(function()
			if (not mod.savedata.planetAlive) then
				if ((not mod.savedata.planetKilled1) and mod.minvariant1 <= roomdesc.Data.Variant and roomdesc.Data.Variant <= mod.maxvariant1) or
				 ((not mod.savedata.planetKilled2) and mod.minvariant2 <= roomdesc.Data.Variant and roomdesc.Data.Variant <= mod.maxvariant2) then
					local statue = mod:SpawnEntity(mod.Entity.Statue, game:GetRoom():GetCenterPos()+Vector(0,-20),Vector.Zero, Isaac.GetPlayer(0))
				end
			end
		end, 0, ModCallbacks.MC_POST_RENDER) 
	end

	local isPlanetarium = roomdesc and roomdesc.Data and roomdesc.Data.Type == RoomType.ROOM_PLANETARIUM
	if isAstralChallenge or isPlanetarium then
		for _, e in ipairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.DIRT_PATCH, 0)) do
			e:Remove()
		end
	end

	--Other things
	mod.ModFlags.venusHeat = false
end)

--Update health of boss, may be delayed by one damage
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_,entity,_,_,_,_)
	
	if mod.savedata.planetAlive and entity:GetData().HeavensCall then
		if entity.Type == mod.EntityInf[mod.Entity.Jupiter].ID and entity.Variant == mod.EntityInf[mod.Entity.Jupiter].VAR or 
		entity.Type == mod.EntityInf[mod.Entity.Saturn].ID and entity.Variant == mod.EntityInf[mod.Entity.Saturn].VAR or 
		entity.Type == mod.EntityInf[mod.Entity.Uranus].ID and entity.Variant == mod.EntityInf[mod.Entity.Uranus].VAR or 
		entity.Type == mod.EntityInf[mod.Entity.Neptune].ID and entity.Variant == mod.EntityInf[mod.Entity.Neptune].VAR
		or 
		entity.Type == mod.EntityInf[mod.Entity.Mercury].ID and entity.Variant == mod.EntityInf[mod.Entity.Mercury].VAR or 
		entity.Type == mod.EntityInf[mod.Entity.Venus].ID and entity.Variant == mod.EntityInf[mod.Entity.Venus].VAR or 
		entity.Type == mod.EntityInf[mod.Entity.Terra1].ID and entity.Variant == mod.EntityInf[mod.Entity.Terra1].VAR or 
		entity.Type == mod.EntityInf[mod.Entity.Terra3].ID and entity.Variant == mod.EntityInf[mod.Entity.Terra3].VAR or 
		entity.Type == mod.EntityInf[mod.Entity.Mars].ID and entity.Variant == mod.EntityInf[mod.Entity.Mars].VAR
		then
			mod.savedata.planetHP = entity.HitPoints --There should not be more than 1 planet at the same time so... (we dont talk about meat cleaver)
		end
	end
end)


--POOL------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

--Item pool in room
mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, function(_)
	--things
	local level = game:GetLevel()
	local roomdesc = level:GetCurrentRoomDesc()
	
	if mod:IsRoomDescAstralChallenge(roomdesc) then
		if not mod.ModFlags.noPool then
			mod:PausePool()
			--New pool
			local haschaos = mod:SomebodyHasItem(CollectibleType.COLLECTIBLE_CHAOS)
			if not haschaos then
				--If cant find a collectible that a player doesnt have in 100 tries, just spawn a regular one, the pool is empty
				local randomChance = rng:RandomFloat()
				
				if randomChance <= 0.65 then
					return game:GetItemPool():GetCollectible(ItemPoolType.POOL_PLANETARIUM)
					
				else
					local newItem = nil
					for i=1, 100 do
						local pool = mod.AstralChallengePoolExtras
	
						local randomNum = mod:RandomInt(1,#pool)
						newItem = pool[randomNum]
	
						local aPLayerHasIt = mod:SomebodyHasItem(newItem)
						if not aPLayerHasIt then
							break
						end
						newItem = nil
					end
					return newItem
				end
			end
		end
	end
end)
--Deactivating the pool
function mod:PausePool()
	mod.ModFlags.noPool = true
	mod:scheduleForUpdate(function()
		mod.ModFlags.noPool = false
	end, 2, ModCallbacks.MC_POST_UPDATE)
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_,entity)--Dont reroll TEden items into astral challenge items
	if entity.Type == EntityType.ENTITY_PLAYER then
		entity = entity:ToPlayer()
		if entity:GetPlayerType() == PlayerType.PLAYER_EDEN_B then
			mod:PausePool()
		end
	end
end)
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_,item)--Dont reroll player items intro astral challenge items if d4 or d100
	if item == CollectibleType.COLLECTIBLE_D4 or item == CollectibleType.COLLECTIBLE_D100 then
		mod:PausePool()
	end
end)


--SHADERS---------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
function mod:GetShaderParams(shaderName)
	local room = game:GetRoom()
    if shaderName == 'Timestuck' then
		if not mod.ModFlags.globalTimestuck then
			local params = {Time = 0}
			return params;
		end

		local params = {Time = 1}
		return params;
	end
	
	if shaderName == 'VenusHeat' then
		if not mod.ModFlags.venusHeat then
			local params = { 
				PlayerPos = { 2000, 2000 },
				CenterPos = { 2000, 2000 },
				Time = 0,
				VenusTime = 0
			}
			return params;
		end
		
		local position1 = mod.ModFlags.venusPosition
		position1 = room:WorldToScreenPosition (position1)

		local position2 = room:GetCenterPos()
		position2 = room:WorldToScreenPosition (position2)

		local params = { 
			PlayerPos = { position1.X,  position1.Y},
			CenterPos = { position2.X,  position2.Y},
			Time = Isaac.GetFrameCount(),
			VenusTime = mod.ModFlags.venusCounter
		}
		return params;
		
    end
end
mod:AddCallback(ModCallbacks.MC_GET_SHADER_PARAMS, mod.GetShaderParams)


--ENHANCED BOSS BARS----------------------------------------------------------------------------------------------------------------
if HPBars then
	--Creating a better planetarium bar
	
	HPBars.BarStyles["PlanetariumHC"] = {
		sprite ="gfx/ui/bosshp_bars/bossbar_design_planetariumHC.png",
		idleColoring = HPBars.BarColorings.none,
		tooltip = "Styled to resemble the Planetarium but Darker"
	}

	local truFunc = function(entity)
		return true
	end
	HPBars.BossIgnoreList[tostring(mod.EntityInf[mod.Entity.Statue].ID).."."..tostring(mod.EntityInf[mod.Entity.Statue].VAR)] = {truFunc}
	HPBars.BossIgnoreList[tostring(mod.EntityInf[mod.Entity.MercuryBird].ID).."."..tostring(mod.EntityInf[mod.Entity.MercuryBird].VAR)] = {truFunc}
	HPBars.BossIgnoreList[tostring(mod.EntityInf[mod.Entity.Terra2].ID).."."..tostring(mod.EntityInf[mod.Entity.Terra2].VAR)] = {truFunc}
	HPBars.BossIgnoreList[tostring(mod.EntityInf[mod.Entity.Horsemen].ID).."."..tostring(mod.EntityInf[mod.Entity.Horsemen].VAR)] = {truFunc}
	HPBars.BossIgnoreList[tostring(EntityType.ENTITY_ADVERSARY)..".0"] = {function(entity) if entity:GetData().HeavensCall then return true end end}

	--Adding the bars
	Jid = tostring(mod.EntityInf[mod.Entity.Jupiter].ID).."."..tostring(mod.EntityInf[mod.Entity.Jupiter].VAR)
	Sid = tostring(mod.EntityInf[mod.Entity.Saturn].ID).."."..tostring(mod.EntityInf[mod.Entity.Saturn].VAR)
	Uid = tostring(mod.EntityInf[mod.Entity.Uranus].ID).."."..tostring(mod.EntityInf[mod.Entity.Uranus].VAR)
	Nid = tostring(mod.EntityInf[mod.Entity.Neptune].ID).."."..tostring(mod.EntityInf[mod.Entity.Neptune].VAR)

	MRid = tostring(mod.EntityInf[mod.Entity.Mercury].ID).."."..tostring(mod.EntityInf[mod.Entity.Mercury].VAR)
	Vid = tostring(mod.EntityInf[mod.Entity.Venus].ID).."."..tostring(mod.EntityInf[mod.Entity.Venus].VAR)
	T1id = tostring(mod.EntityInf[mod.Entity.Terra1].ID).."."..tostring(mod.EntityInf[mod.Entity.Terra1].VAR)
	T3id = tostring(mod.EntityInf[mod.Entity.Terra3].ID).."."..tostring(mod.EntityInf[mod.Entity.Terra3].VAR)
	Mid = tostring(mod.EntityInf[mod.Entity.Mars].ID).."."..tostring(mod.EntityInf[mod.Entity.Mars].VAR)

    HPBars.BossDefinitions[Jid] = {
        sprite = "gfx/bosses/icon_jupiter.png",
		barStyle = "PlanetariumHC"
    }
	HPBars.BossDefinitions[Sid] = {
        sprite = "gfx/bosses/icon_saturn.png",
		barStyle = "PlanetariumHC"
    }
	HPBars.BossDefinitions[Uid] = {
        sprite = "gfx/bosses/icon_uranus.png",
		barStyle = "PlanetariumHC"
    }
	HPBars.BossDefinitions[Nid] = {
        sprite = "gfx/bosses/icon_neptune.png",
		conditionalSprites = {
			{"isAbsoluteStage","gfx/bosses/icon_neptune_shiny.png", {LevelStage.STAGE4_1}},
			{"isAbsoluteStage","gfx/bosses/icon_neptune_shiny.png", {LevelStage.STAGE4_2}}
		},
		barStyle = "PlanetariumHC"
    }


	HPBars.BossDefinitions[MRid] = {
        sprite = "gfx/bosses/icon_mercury.png",
		barStyle = "PlanetariumHC"
    }
	HPBars.BossDefinitions[Vid] = {
        sprite = "gfx/bosses/icon_venus.png",
		barStyle = "PlanetariumHC"
    }
	HPBars.BossDefinitions[T1id] = {
        sprite = "gfx/bosses/icon_terra1.png",
		barStyle = "PlanetariumHC"
    }
	HPBars.BossDefinitions[T3id] = {
        sprite = "gfx/bosses/icon_terra3.png",
		barStyle = "PlanetariumHC"
    }
	HPBars.BossDefinitions[Mid] = {
        sprite = "gfx/bosses/icon_mars.png",
		barStyle = "PlanetariumHC"
    }
end


--MOD CONFIG MENU-------------------------------------------------------------------------------------------------------------------
--This is a Copy paste, standard modconfig stuff; this is mostly just copy/paste by this point
local function SaveConfig()
    if ModConfigMenu then
		if mod.ModConfigs.noRain ~= nil then
			mod.savedata.noNeptuneRain = mod.ModConfigs.noRain
		else
			mod.savedata.noNeptuneRain = false
		end

		if mod.ModConfigs.noSnow ~= nil then
			mod.savedata.noUranusSnowfall = mod.ModConfigs.noSnow
		else
			mod.savedata.noUranusSnowfall = false
		end

		if mod.ModConfigs.roomSpawnChance ~= nil then
			mod.savedata.spawnChance = mod.ModConfigs.roomSpawnChance
		else
			mod.savedata.spawnChance = 7
		end
		if mod.ModConfigs.roomSpawnChance2 ~= nil then
			mod.savedata.spawnChance2 = mod.ModConfigs.roomSpawnChance2
		else
			mod.savedata.spawnChance2 = 30
		end
		if mod.ModConfigs.altUranus ~= nil then
			mod.savedata.altUranus = mod.ModConfigs.altUranus
		else
			mod.savedata.altUranus = false
		end

        mod:SaveData(json.encode(mod.savedata))
    end
end

if ModConfigMenu then
	ModConfigMenu.AddSetting("Heaven's Call", "Config", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		--Default = false,
		CurrentSetting = function()
			return mod.ModConfigs.noRain
		end,
		Display = function()
			return "Deactivate Neptune's rain: " .. tostring(mod.ModConfigs.noRain)
		end,
		OnChange = function(newvalue)
			if newvalue ~= nil then 
				mod.ModConfigs.noRain = newvalue
			else
				mod.ModConfigs.noRain = false
			end
			SaveConfig()
		end,
		Info = "Default = false"
	})
	
	ModConfigMenu.AddSetting("Heaven's Call", "Config", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		Default = false,
		CurrentSetting = function()
			return mod.ModConfigs.noSnow
		end,
		Display = function()
			return "Deactivate Uranus's snowfall: " .. tostring(mod.ModConfigs.noSnow)
		end,
		OnChange = function(newvalue)
			if newvalue ~= nil then 
				mod.ModConfigs.noSnow = newvalue 
			else
				mod.ModConfigs.noSnow = false 
			end
			SaveConfig()
		end,
		Info = "Default = false"
	})

	ModConfigMenu.AddSetting("Heaven's Call", "Config", {
		Type = ModConfigMenu.OptionType.NUMBER,
		Default = 7,
		CurrentSetting = function()
			return mod.ModConfigs.roomSpawnChance
		end,
		Minimum = 0,
		Maximum = 100,
		Display = function()
			return "First room spawn chance: " .. tostring(mod.ModConfigs.roomSpawnChance) .. "%"
		end,
		OnChange = function(newvalue)
			if newvalue ~= nil then 
				mod.ModConfigs.roomSpawnChance = newvalue
			else
				mod.ModConfigs.roomSpawnChance = 7
			end
			SaveConfig()
		end,
		Info = "Default = 7%"
	})

	ModConfigMenu.AddSetting("Heaven's Call", "Config", {
		Type = ModConfigMenu.OptionType.NUMBER,
		Default = 30,
		CurrentSetting = function()
			return mod.ModConfigs.roomSpawnChance2
		end,
		Minimum = 0,
		Maximum = 100,
		Display = function()
			return "Second room spawn chance: " .. tostring(mod.ModConfigs.roomSpawnChance2) .. "%"
		end,
		OnChange = function(newvalue)
			if newvalue ~= nil then 
				mod.ModConfigs.roomSpawnChance2 = newvalue
			else
				mod.ModConfigs.roomSpawnChance2 = 30
			end
			SaveConfig()
		end,
		Info = "Default = 30%"
	})
	
	ModConfigMenu.AddSetting("Heaven's Call", "Config", {
		Type = ModConfigMenu.OptionType.BOOLEAN,
		Default = false,
		CurrentSetting = function()
			return mod.ModConfigs.altUranus
		end,
		Display = function()
			return "Alternative Uranus sprite: " .. tostring(mod.ModConfigs.altUranus)
		end,
		OnChange = function(newvalue)
			if newvalue ~= nil then 
				mod.ModConfigs.altUranus = newvalue 
			else
				mod.ModConfigs.altUranus = false 
			end
			SaveConfig()
		end,
		Info = "Default = false"
	})
end

function mod:onStarted(fromSave)
	if ModConfigMenu and mod:HasData() then
		mod.savedata = json.decode(mod:LoadData())

		if mod.savedata.noNeptuneRain ~= nil then
			mod.ModConfigs.noRain = mod.savedata.noNeptuneRain
		else
			mod.ModConfigs.noRain = false
		end

		if mod.savedata.noUranusSnowfall ~= nil then
			mod.ModConfigs.noSnow = mod.savedata.noUranusSnowfall
		else
			mod.ModConfigs.noSnow = false
		end

		if mod.savedata.spawnChance ~= nil then
			mod.ModConfigs.roomSpawnChance = mod.savedata.spawnChance
		else
			mod.ModConfigs.roomSpawnChance = 7
		end
		
		if mod.savedata.spawnChance2 ~= nil then
			mod.ModConfigs.roomSpawnChance2 = mod.savedata.spawnChance2
		else
			mod.ModConfigs.roomSpawnChance2 = 30
		end

		if mod.savedata.altUranus ~= nil then
			mod.ModConfigs.altUranus = mod.savedata.altUranus
		else
			mod.ModConfigs.altUranus = false
		end

	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.onStarted)


--REVELATIONS------------------------------------------------------------------
if REVEL then
	mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.RevelationsDoorsUpdate, EffectVariant.DOOR_OUTLINE)
	mod.RevelationDoor = nil
end