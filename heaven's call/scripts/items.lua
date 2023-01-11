local mod = HeavensCall
local rng = RNG()
local game = Game()
local sfx = SFXManager()

mod.Items = {

	Mercurius = Isaac.GetItemIdByName("Mercurius?"),
	Venus = Isaac.GetItemIdByName("Venus?"),
	Terra = Isaac.GetItemIdByName("Terra?"),
	Mars = Isaac.GetItemIdByName("Mars?"),
	Jupiter = Isaac.GetItemIdByName("Jupiter?"),
	Saturnus = Isaac.GetItemIdByName("Saturnus?"),
	Uranus = Isaac.GetItemIdByName("Uranus?"),
	Neptunus = Isaac.GetItemIdByName("Neptunus?"),

}

mod.ItemsVars = {
	jupiterPoints = {},--This is goind to behave weird in Multiplayer, but I dont care
	nJupiterPoints = 0,
}

--Your chances will cap at 'chanceCap' when your 'luck' is geq than 'luckCap'
function mod:LuckRoll(luck, luckCap, chanceCap)
	chanceCap = chanceCap or 1
	luckCap = luckCap + 1
	luck = math.max(1, luck+1)--No neg luck

	local chance = math.min(chanceCap, luck * chanceCap / luckCap)
	local random = rng:RandomFloat()
	return (random <=  chance)
end


function mod:OnUpdate()
	local room = game:GetRoom()

	for i=0, game:GetNumPlayers ()-1 do
		local player = game:GetPlayer(i):ToPlayer()
		
		if player:HasCollectible(mod.Items.Jupiter) then

			if game:GetFrameCount() % 3 == 0 then
				

				for i=1, 4 do
					local objective = player.Position + Vector(10,0):Rotated(i*360/4)
				
					if mod.ItemsVars.nJupiterPoints>=3 then
						
						local result = false
						local distance = false

						for i = mod.ItemsVars.nJupiterPoints-2, 1, -1 do

							result = mod:PointInPoly(mod.ItemsVars.nJupiterPoints, mod.ItemsVars.jupiterPoints, objective, i)
							distance = (mod.ItemsVars.jupiterPoints[i]:Distance(player.Position)) < 45

							if result and distance then break end
						end
						
						if result and distance then
							sfx:Play(SoundEffect.SOUND_LASERRING_STRONG)

							for _, e in ipairs(mod:FindByTypeMod(mod.Entity.JupiterJuice)) do
								e:Die()
								e:ToEffect().Timeout = 0
							end
		
							for i=1, mod.ItemsVars.nJupiterPoints-1 do
								local point1 = mod.ItemsVars.jupiterPoints[i]
								local point2 = mod.ItemsVars.jupiterPoints[i%mod.ItemsVars.nJupiterPoints+1]
	
								local angle = (point1 - point2):GetAngleDegrees()
								local laser = EntityLaser.ShootAngle(LaserVariant.THIN_RED, point2, angle, 10, Vector.Zero, player)
								laser.MaxDistance = (point1 - point2):Length()
								laser.DisableFollowParent = true
								laser:GetSprite().Color = mod.Colors.jupiterLaser2
	
							end

							local function ElectrifyEntity(entity)
								local flag = false
								for i = mod.ItemsVars.nJupiterPoints-2, 1, -1 do

									local result = mod:PointInPoly(mod.ItemsVars.nJupiterPoints, mod.ItemsVars.jupiterPoints, entity.Position, i)
									local distance = (mod.ItemsVars.jupiterPoints[i]:Distance(player.Position)) < 50
		
									if result and distance then 
										flag = true
										break
									end
								end

								if flag then
									local function SpawnThunder(position)
										position = position or entity.Position
										local thunder = mod:SpawnEntity(mod.Entity.Thunder, position, Vector.Zero, player)
										thunder:GetSprite().PlaybackSpeed = 2
										thunder.CollisionDamage = 100

										return thunder
									end

									if entity:IsActiveEnemy() and not (entity:HasEntityFlags(EntityFlag.FLAG_FRIENDLY) or entity:HasEntityFlags(EntityFlag.FLAG_CHARM)) then
										SpawnThunder()
										for i=1, 5 do
											local position = entity.Position + Vector(rng:RandomFloat()*100, 0):Rotated(rng:RandomFloat() * 360)
											SpawnThunder(position)
										end

									elseif entity.Type == EntityType.ENTITY_SLOT then
										local valid = entity.Variant == 1 or entity.Variant == 2 or entity.Variant == 3 or entity.Variant == 8 or entity.Variant == 10 or entity.Variant == 11 or
										entity.Variant == 1020 or entity.Variant == 1032 or entity.Variant == 542 or entity.Variant == 16
										if valid then
											SpawnThunder():GetSprite().PlaybackSpeed = 4

											if rng:RandomFloat() < 0.333 then
												entity.Velocity = Vector(rng:RandomFloat()*10, 0):Rotated(rng:RandomFloat() * 360)
												game:BombExplosionEffects (entity.Position, 0, TearFlags.TEAR_NORMAL, mod.Colors.jupiterLaser2, nil, 1, true, false, DamageFlag.DAMAGE_EXPLOSION )
											else
												mod:TriggerSlotMachine(entity, player)
											end
										end

									elseif entity.Type == EntityType.ENTITY_SHOPKEEPER then
										SpawnThunder():GetSprite().PlaybackSpeed = 4

										mod:scheduleForUpdate(function()
											if not entity then return end
											local keeper
											if rng:RandomFloat() < 0.5 then
												keeper = Isaac.Spawn(EntityType.ENTITY_KEEPER, 0, 0, entity.Position, Vector.Zero, player)
												keeper:AddCharmed(EntityRef(player), -1)
											else
												keeper = Isaac.Spawn(EntityType.ENTITY_HANGER, 0, 0, entity.Position, Vector.Zero, player)
												keeper:AddCharmed(EntityRef(player), -1)

											end

											mod:scheduleForUpdate(function()
												if not keeper then return end
												for _, f in ipairs(Isaac.FindByType(EntityType.ENTITY_ETERNALFLY)) do
													if f.Parent == keeper then
														f:Die()
													end
												end
											end, 2)

											entity:Die()
										end, 5)

										
									elseif entity.Type == EntityType.ENTITY_PICKUP and entity.Variant == PickupVariant.PICKUP_LIL_BATTERY then
										SpawnThunder():GetSprite().PlaybackSpeed = 4

										mod:scheduleForUpdate(function()
											if not entity then return end
											local random = rng:RandomFloat()
											entity = entity:ToPickup()

											if entity.SubType == BatterySubType.BATTERY_MICRO and random < 0.80 then
												entity:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_NORMAL)
											elseif entity.SubType == BatterySubType.BATTERY_NORMAL and random < 0.40 then
												entity:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_MEGA)
											elseif entity.SubType == BatterySubType.BATTERY_MEGA and random < 0.20 then
												entity:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_LIL_BATTERY, BatterySubType.BATTERY_GOLDEN)
											else
												entity:Remove()
												game:BombExplosionEffects (entity.Position, 0, TearFlags.TEAR_NORMAL, Color.Default, nil, 0.6, true, false, DamageFlag.DAMAGE_EXPLOSION)
											end
										end, 5)
									end
								end
							end

							for _, entity in ipairs(Isaac.GetRoomEntities()) do
								ElectrifyEntity(entity)
							end
		
							mod.ItemsVars.jupiterPoints = {}
							mod.ItemsVars.nJupiterPoints = 0

							break
						end
					end
				end
				
				local juice = mod:SpawnEntity(mod.Entity.JupiterJuice, player.Position, Vector.Zero, player):ToEffect()
				juice:GetSprite().Color = mod.Colors.jupiterLaser1
				juice.Timeout = 30*3 + 15*1

				mod.ItemsVars.nJupiterPoints = mod.ItemsVars.nJupiterPoints + 1
				mod.ItemsVars.jupiterPoints[mod.ItemsVars.nJupiterPoints] = player.Position

			end
		end

	end

end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.OnUpdate)

function mod:OnTearSpawn(tear)
	if not tear.SpawnerEntity then return end

	local player = tear.SpawnerEntity:ToPlayer()

	if player and player:HasCollectible(mod.Items.Mercurius) then
		mod:MercuriusOnTearShot(player, tear)
	elseif tear.SpawnerEntity.Type == EntityType.ENTITY_FAMILIAR and tear.SpawnerEntity.Variant == FamiliarVariant.MINISAAC and tear.SpawnerEntity:GetData().MercuriusColor then
        tear:GetData().MercuriusTearFlag = true
	end


end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, mod.OnTearSpawn)

function mod:OnTearUpdate(tear)
	local data = tear:GetData()
	local sprite = tear:GetSprite()

	if not data.Init then
		data.Init = true

		if data.MercuriusTearFlag then
			local anim = sprite:GetAnimation()
			local valid = string.sub(anim,1,11)=="RegularTear" or string.sub(anim,1,11)=="BloodTear"
			if valid then
				tear:ChangeVariant(Isaac.GetEntityVariantByName("Mercurius Tear (HC)"))
				sprite:Load("gfx/tear_Mercurius.anm2", true)
				sprite:Play(anim, true)
			elseif string.sub(anim,1,5)=="Stone" then
				tear:ChangeVariant(Isaac.GetEntityVariantByName("Mercurius Tear (HC)"))
				sprite:Load("gfx/tear_Mercurius_stone.anm2", true)
				sprite:Play(anim, true)
			elseif string.sub(anim,1,6)=="Rotate" and sprite:GetDefaultAnimation()=="Rotate0" then
				tear:ChangeVariant(Isaac.GetEntityVariantByName("Mercurius Tear (HC)"))
				sprite:Load("gfx/tear_Mercurius_rotate.anm2", true)
				sprite:Play(anim, true)
			end
		end
	else
		
		if data.MercuriusTearFlag then
			if tear:IsDead() then
				local splat = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 0, tear.Position, Vector.Zero, nil)
				game:SpawnParticles (tear.Position, EffectVariant.DIAMOND_PARTICLE, 5, 3, mod.Colors.mercury)
				splat:GetSprite().Color = mod.Colors.mercury
				sfx:Play(Isaac.GetSoundIdByName("BismuthBreak"), 1, 2, false, 1)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.OnTearUpdate)

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player, cacheFlag)
	local data = player:GetData()

	if player:HasCollectible(mod.Items.Mercurius) then
		player.CanFly = true
	end
end)

function mod:OnNewRoom()
	local room = game:GetRoom()

	for i=0, game:GetNumPlayers ()-1 do
		local player = game:GetPlayer(i):ToPlayer()
		
		if player:HasCollectible(mod.Items.Mercurius) then
			if rng:RandomFloat() <= 0.05 and room:IsFirstVisit() then
				player:UseActiveItem(CollectibleType.COLLECTIBLE_MY_LITTLE_UNICORN)
			end

		elseif player:HasCollectible(mod.Items.Jupiter) then
			mod.ItemsVars.jupiterPoints = {}
			mod.ItemsVars.nJupiterPoints = 0
		end

	end

	--Bismuth knife
	for _, k in ipairs(Isaac.FindByType(EntityType.ENTITY_KNIFE, 0, 0)) do
		local player = k.SpawnerEntity:ToPlayer() or k.SpawnerEntity:ToFamiliar().Player:ToPlayer()
		if player and player:HasCollectible(mod.Items.Mercurius) then
			k:GetSprite():ReplaceSpritesheet(0, "gfx/effects/bismuth_knife.png")
			k:GetSprite():LoadGraphics()
		end
	end


	for i=0, game:GetNumPlayers ()-1 do
		local player = game:GetPlayer(i):ToPlayer()
		
		if player:HasCollectible(mod.Items.Mercurius) then
			

		end

	end

end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.OnNewRoom)


--MERCURIUS
function mod:MercuriusOnTearShot(player, tear)
    if mod:LuckRoll(player.Luck, 6, 0.5) then
        tear:GetData().MercuriusTear = true
        tear:GetData().MercuriusTearFlag = true
    end
end

function mod:SpawnMiniIsaacMercury(player, position)

	if #Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.MINISAAC) >= 25 then return end

	sfx:Play(Isaac.GetSoundIdByName("BismuthBreak"), 1, 2, false, 1)
	local miniIsaac = player:AddMinisaac(position)
	miniIsaac:GetData().MercuriusColor = true
	miniIsaac:GetSprite():ReplaceSpritesheet(0, "gfx/familiar/familiar_minisaac_mercury.png")
	miniIsaac:GetSprite():ReplaceSpritesheet(1, "gfx/familiar/familiar_minisaac_mercury.png")
	miniIsaac:GetSprite():LoadGraphics()
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, function(_, entity)
	if entity:GetData().MercuriusColor then
		entity:GetSprite().Color = mod.Colors.mercury

	end
end, FamiliarVariant.MINISAAC)
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, entity, amount)
	if entity.Variant == FamiliarVariant.MINISAAC and entity:GetData().MercuriusColor then
		if entity.HitPoints <= amount then
			local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, entity.Position, Vector.Zero, entity.Player)
			creep.SpriteScale = Vector.One * 0.01
			creep:GetSprite().Color = mod.Colors.mercury
		end
	end
end, EntityType.ENTITY_FAMILIAR)

function mod:MercuriusTearCollision(tear, collider)
	if tear:GetData().MercuriusTear and collider and collider:IsActiveEnemy() then
		
		local splat = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 0, tear.Position, Vector.Zero, nil)
		game:SpawnParticles (tear.Position, EffectVariant.DIAMOND_PARTICLE, 5, 3, mod.Colors.mercury)
		splat:GetSprite().Color = mod.Colors.mercury
		sfx:Play(Isaac.GetSoundIdByName("BismuthBreak"), 1, 2, false, 1)


		local player = tear.SpawnerEntity
		if player then
			player = player:ToPlayer() or player:ToFamiliar().Player:ToPlayer()
			local letal = player.Damage >= collider.HitPoints
			if letal then
				mod:SpawnMiniIsaacMercury(player, collider.Position)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_TEAR_COLLISION, mod.MercuriusTearCollision)
function mod:MercuriusKnifeCollision(knife, collider)
	if collider and collider:IsActiveEnemy() then
		local player = knife.SpawnerEntity
		if player and (player:ToPlayer() or (player:ToFamiliar() and player:ToFamiliar().Player:ToPlayer())) then
			player = player:ToPlayer() or player:ToFamiliar().Player:ToPlayer()
			local letal = player.Damage >= collider.HitPoints
			if player:HasCollectible(mod.Items.Mercurius) and letal and mod:LuckRoll(player.Luck, 6, 0.45) then
				mod:SpawnMiniIsaacMercury(player, collider.Position)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, mod.MercuriusKnifeCollision)
function mod:MercuriusLaserHit(enemy, amount, flags, sourceRef)

	local letal = (amount >= enemy.HitPoints)

	if enemy and enemy:IsActiveEnemy() and letal and (flags&DamageFlag.DAMAGE_LASER == DamageFlag.DAMAGE_LASER) then
		local player = sourceRef.Entity
		if player and (player:ToPlayer() or (player:ToFamiliar() and player:ToFamiliar().Player:ToPlayer())) then
			player = player:ToPlayer() or player:ToFamiliar().Player:ToPlayer()
			if player:HasCollectible(mod.Items.Mercurius) and mod:LuckRoll(player.Luck, 6, 0.5) then
				mod:SpawnMiniIsaacMercury(player, enemy.Position)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.MercuriusLaserHit)
function mod:MercuriusBombHit(enemy, amount, flags, sourceRef)

	local letal = (amount >= enemy.HitPoints)

	if enemy and enemy:IsActiveEnemy() and letal and (flags&DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION) then
		local bomb = sourceRef.Entity

		if bomb and bomb.SpawnerEntity and (bomb.SpawnerEntity:ToPlayer() or (bomb.SpawnerEntity:ToFamiliar() and bomb.SpawnerEntity:ToFamiliar().Player)) then
			local player = bomb.SpawnerEntity:ToPlayer() or bomb.SpawnerEntity:ToFamiliar().Player:ToPlayer()
			if player:HasCollectible(mod.Items.Mercurius) and mod:LuckRoll(player.Luck, 6, 0.5) then
				mod:SpawnMiniIsaacMercury(player, enemy.Position)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.MercuriusBombHit)

--JUPITER
function mod:PointInPoly(nPoints, polygon, p, nStart)
	nStart = nStart - 1

	local isInside = false;
    local minX = polygon[nStart+1].X
	local maxX = polygon[nStart+1].X
    local minY = polygon[nStart+1].Y
	local maxY = polygon[nStart+1].Y
    for n = nStart+2, nPoints-1 do
        local q = polygon[n]
        minX = math.min(q.X, minX)
        maxX = math.max(q.X, maxX)
        minY = math.min(q.Y, minY)
        maxY = math.max(q.Y, maxY)
	end

    if (p.X < minX or p.X > maxX or p.Y < minY or p.Y > maxY) then
        return false;
	end

	local j = nPoints - 2

    for i=nStart, nPoints-1, 1 do

        if ( (polygon[i+1].Y > p.Y) ~= (polygon[j+1].Y > p.Y) and
                p.X < (polygon[j+1].X - polygon[i+1].X) * (p.Y - polygon[i+1].X) / (polygon[j+1].Y - polygon[i+1].Y) + polygon[i+1].X )
		then
            isInside = not isInside
		end

		j = i
    end

    return isInside
end

function mod:JupiterDustUpdate(entity)
	if entity.SubType == mod.EntityInf[mod.Entity.JupiterJuice].SUB and entity.Timeout == 1 then
		entity.Timeout = 0
		entity:Die()
		for i=2, mod.ItemsVars.nJupiterPoints do
			mod.ItemsVars.jupiterPoints[i-1] = mod.ItemsVars.jupiterPoints[i]
		end
		mod.ItemsVars.jupiterPoints[mod.ItemsVars.nJupiterPoints] = nil
		mod.ItemsVars.nJupiterPoints = mod.ItemsVars.nJupiterPoints - 1
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.JupiterDustUpdate, EffectVariant.PLAYER_CREEP_BLACKPOWDER)

function mod:TriggerSlotMachine(slot, mainPlayer)

	local coins = mainPlayer:GetNumCoins()
	mainPlayer:AddCoins(5)

	local oldPos = mainPlayer.Position
	mainPlayer:GetData().Invulnerable_HC = true

	mainPlayer.Position = slot.Position

	mod:scheduleForUpdate(function()
		mainPlayer.Position = oldPos
		mainPlayer:AddCoins(-999)
		mainPlayer:AddCoins(coins)
		mainPlayer:GetData().Invulnerable_HC = false
	end, 2)

end
function mod:AddPlayer(player)--Unused
	local id = game:GetNumPlayers() - 1
	local playerType = player:GetPlayerType()

	Isaac.ExecuteCommand('addplayer 15 '..player.ControllerIndex)
	local newPlayer = Isaac.GetPlayer(id + 1)

	newPlayer.Parent = player
	game:GetHUD():AssignPlayerHUDs()

	return newPlayer
end
