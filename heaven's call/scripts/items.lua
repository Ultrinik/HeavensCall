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

--Your chances will cap at 'chanceCap' when your 'luck' is geq than 'luckCap'
function mod:LuckRoll(luck, luckCap, chanceCap)
	chanceCap = chanceCap or 1
	luckCap = luckCap + 1
	luck = math.max(1, luck+1)--No neg luck

	local chance = math.min(chanceCap, luck * chanceCap / luckCap)
	return (rng:RandomFloat() <=  chance)
end


function mod:OnUpdate()

	for i=0, game:GetNumPlayers ()-1 do
		local player = game:GetPlayer(i):ToPlayer()
		
		if player:HasCollectible(mod.Items.Mercurius) then
			player:AddCacheFlags(CacheFlag.CACHE_FLYING)
  			player:EvaluateItems()
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
			tear:ChangeVariant(Isaac.GetEntityVariantByName("Mercurius Tear (HC)"))
			sprite:Load("gfx/tear_Mercurius.anm2", true)
			sprite:Play(anim, true)
		end
	else
		
		if data.MercuriusTearFlag then
			if tear:IsDead() then
				local splat = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BLOOD_EXPLOSION, 0, tear.Position, Vector.Zero, nil)
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




--MERCURIUS
function mod:MercuriusOnTearShot(player, tear)
    if mod:LuckRoll(player.Luck, 8, 0.5) then
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

function mod:MercuriusTearCollision(tear, collider)
	if tear:GetData().MercuriusTear and collider and collider:IsActiveEnemy() then
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
		if player then
			player = player:ToPlayer() or player:ToFamiliar().Player:ToPlayer()
			local letal = player.Damage >= collider.HitPoints
			if player:HasCollectible(mod.Items.Mercurius) and letal and mod:LuckRoll(player.Luck, 8, 0.5) then
				mod:SpawnMiniIsaacMercury(player, collider.Position)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_PRE_KNIFE_COLLISION, mod.MercuriusKnifeCollision)
function mod:MercuriusLaserCollision(enemy, amount, flags, sourceRef)

	local letal = (amount >= enemy.HitPoints)

	if enemy and enemy:IsActiveEnemy() and letal and (flags&DamageFlag.DAMAGE_LASER == DamageFlag.DAMAGE_LASER) then
		local player = sourceRef.Entity
		if player and player:ToPlayer() then
			player = player:ToPlayer() or player:ToFamiliar().Player:ToPlayer()
			if player:HasCollectible(mod.Items.Mercurius) and mod:LuckRoll(player.Luck, 8, 0.5) then
				mod:SpawnMiniIsaacMercury(player, enemy.Position)
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.MercuriusLaserCollision)

