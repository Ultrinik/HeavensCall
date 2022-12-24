local mod = HeavensCall
local game = Game()
local rng = RNG()
local sfx = SFXManager()
local json = require("json")

--LUNA---------------------------------------------------------------------------------------------------
--[[
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@&%(*,,,*(%@@@@@@@@@@@@@@@@@@@@@@@@@@@%(,,,,,/#%@@@@@@@@@@@@@@@
@@@&#&@@@@@@@@@&#/,,,,,,,,,,#&@@@@@@@@@@@@@@@@@@@@@@@&(,,****,,,,,(%@@@@@@@@@@@@
@@@@@@@@@@@@&%/,,,,****,,,,,/%@@@@@@@@@@@@@@@@@@@@@@@%*,,***/***,,,,/%@@@@@@@@@@
@@@@@@@@@@&#*,,********,,,,,(&@@@@@@@@@@@@@@@@@@@@@@@&(,,***//********/%@@@@@@@@
@@@@@@@@&#*,***********,,,,*%@@@@@@@@@@@@@@@@@@@@@@@@@%/****///////*****#&@@@@@@
@@@@@@@#***************,,,*%@@@@@@@@@@@@@@@@@@@@@@@@@@@#***///////////***(%@@@@@
@@@@@&#****///********,,,*#@@@@@@@@@@@@@@@@@@@@@@@@@@@@&#///////////////**/%@@@@
@@@@@#***/////***********#&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&(//////////////***/%@@@
@@@@&(**//////**********/%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&(**/////////////***(&@@
@@@@&(**///////*********#&@@@@%#*.  (@@@@@@@@@&@@@@@@@@@&#**/////////////***/%@@
@@@@&(*//(((///////*****#@@@%.       %@@@@@@@@@@@@@@@@@@&(**/////////////****%@@
&&@@@#///(((////////****#@@@@(    ,/####(((((((##%%&@@@@&(**/////////////***(&@@
@@@@@&///((((///////***/%@@@@%///*,,,,,,***,,,,,,,,,,,/((/*////((///////***(&@@@
@@@@@@%///(((////////**/%%#/*****///////////////******,,,*//((((///////***(&@@@@
@@@@@@@%////((///////****,,**//(((((//////////////////////((((((/////****(&@@@@@
&@@@@@@@&(*////////////***///((((((((((((/////////////////(((((////****(%@@@@@@@
@@@@@@@@@@%/**/////////////((((((((((((((((((((///((((/(//((((/////**(%@@@@@@@@@
@@@@@@@@@@@@&#/***/////((((#((((((((((((((((((((//(//(((((((////////(%@@@@@@@@@@
@@@@@@@@@@@@@@@%#///((((###((((((((((((/(((((((((((((((((((((((////**/%@@@@@@@@@
@@@@@@@@@@@@&@@%///(((###((((((((((((((((((((((((((((((((((((((((((/**/%@@@@@@@@
@@@@@@@@@@@@@@&(//(((((((((((((((((((((((((((((((((((////((((((((((//**(%@@@&@@@
@@@@@@@@@@@@&@#//((###(((((((((((((((((((((((((/(////////////////((//***#@@@@@@@
@@@@@@@@@@@@@&#*/((###((((((((((((/((((((///((//////////////*///*////***#@@@@@@@
@@@@@@@@@@@@@@#*/((##(((((((((((((//////////////////////*******//////***#@@@@@@@
@@@@@@@@@@@@@@%*/((###((((((((((((/////////////////*//*********//((//***%@@@@&@@
@@@@@@@@@@@&@@&(*/(#%%%(((//(((((((/////////***//*********,***(###//***(&@@@@@@@
@@@@@@@@@@@@@@@%/*/(%%%#(((//((((((((((////***********,,,,,,**(%%#****/%@@@@@@@@
@@@@@@@@@@@@@@@&%**/(%%((((///((((((((//////***,**,,,,,,,,,,****/****/#@@@@@@@@@
@@@@@@@@@@@@@&@@@%(**/((((((((((((((((((((****,,,,,,,,,,,,,*******,,/%@@@@@@@@@@
@@@@@@@@@@@@@@@@@@&#*,*//(((((((((((((////***,,,,.....,,,,******,,*#&@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@%#*,**//////////////****,,,,....,,,,,****,,,*#&@@@@@@@@@@@@@
@@@@&@@@@@@@@@@@@@@@@@&%(,,****//////********,,,,,,,,,,,,,,,,,(%@@@@@@@@@@@@@@&@
@@@@@@@@@@@@@@@@@@@@@@@@@&%(*,,,***********,,,,,,,,,,,,,,.,(%&@@@@@@@@@@@@@@@@@@
@@@@&@@@@%@@@@@@@@@@@@@@@@@@@&%##*,,,,,,,,,,,,,......,/#%&@@&@@@@@@@@%@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
]]--
  
mod.LMSState = {
    APPEAR = 0,
    IDLE = 1,
    ATTACK = 2,
    CHARGE = 3,
    TELEPORT = 4,
    ITEM = 5,
    BOSSROOM = 6,
    MEGASATAN = 7,
    CURSE = 8,
    ARCADE = 9,
    BEDROOM = 10,
    DICE = 11,
    PLANETARIUM = 12,
    VAULT = 13,
    SPECIAL = 14,
    SACRIFICE = 15
}

--TOTAL ITEMS = 40 [0-39]
mod.LActives = {
    ABYSS = 0,
    BOOK_VIRTUDES = 1,
    BIBLE = 2,
    BOOK_BELIAL = 3,
    BOOK_SHADOWS = 4,
    ANARCHIST = 5,
    BOOK_DEAD = 6,
}
mod.LSpecials = {
    FLIP = 7,
    MEGA_MUSH = 8,
    MOMS_SHOVEL = 9,
}
mod.LAssistPassives = {
    INCUBUS = 10,
    MOMS_KNIFE = 11,
    HOLY_MANTLE = 12,
    WAFER = 13,
    MAGIC_MUSHROOM = 14,
    POLYPHEMUS = 15,
    MAW_VOID = 16,
    --PARASITOID = 17,
    BOWL_TEARS = 18, --COMMUNITY REMIX
    STOPWATCH = 39,
}
mod.LMainPassive = {
    C_SECTION = 19,
    DR_FETUS = 20,
    TECH_X = 21,
    HEMOLACRYA = 22,
    BRIMSTONE = 23,
    --EPIC_FETUS = 24,
    REVELATIONS = 25,
    MUTANT_SPIDER = 39,
}
mod.LSecondaryPassives = {
    IPECAC = 26,
    _20_20 = 27,
    GOD_HEAD = 28,
    SACRED_HEART = 29,
    PARASITE = 30,
    CONTINUUM = 31,
    CLASSIC_WORM = 32, --CLASSIC
}

mod.LItemDoor = {
    [mod.LActives.ABYSS] = mod.DoorType.DEVIL,
    [mod.LActives.BOOK_VIRTUDES] = mod.DoorType.LIBRARY,
    [mod.LActives.BIBLE] = mod.DoorType.LIBRARY,
    [mod.LActives.BOOK_BELIAL] = mod.DoorType.LIBRARY,
    [mod.LActives.BOOK_SHADOWS] = mod.DoorType.LIBRARY,
    [mod.LActives.ANARCHIST] = mod.DoorType.LIBRARY,
    [mod.LActives.BOOK_DEAD] = mod.DoorType.LIBRARY,
    
    [mod.LSpecials.FLIP] = mod.DoorType.DEVIL,
    [mod.LSpecials.MEGA_MUSH] = mod.DoorType.SECRET,
    [mod.LSpecials.MOMS_SHOVEL] = mod.DoorType.SECRET,
    
    [mod.LAssistPassives.INCUBUS] = mod.DoorType.DEVIL,
    [mod.LAssistPassives.MOMS_KNIFE] = mod.DoorType.DEVIL,
    [mod.LAssistPassives.HOLY_MANTLE] = mod.DoorType.ANGEL,
    [mod.LAssistPassives.WAFER] = mod.DoorType.ANGEL,
    [mod.LAssistPassives.MAGIC_MUSHROOM] = mod.DoorType.TREASURE,
    [mod.LAssistPassives.POLYPHEMUS] = mod.DoorType.TREASURE,
    [mod.LAssistPassives.MAW_VOID] = mod.DoorType.DEVIL,
    --[mod.LAssistPassives.PARASITOID] = mod.DoorType.TREASURE,
    [mod.LAssistPassives.BOWL_TEARS] = mod.DoorType.TREASURE,
    [mod.LAssistPassives.STOPWATCH] = mod.DoorType.SHOP,
    
    [mod.LMainPassive.C_SECTION] = mod.DoorType.TREASURE,
    [mod.LMainPassive.DR_FETUS] = mod.DoorType.TREASURE,
    [mod.LMainPassive.TECH_X] = mod.DoorType.TREASURE,
    [mod.LMainPassive.HEMOLACRYA] = mod.DoorType.TREASURE,
    [mod.LMainPassive.BRIMSTONE] = mod.DoorType.DEVIL,
    --[mod.LMainPassive.EPIC_FETUS] = mod.DoorType.SECRET,
    [mod.LMainPassive.REVELATIONS] = mod.DoorType.ANGEL,
    [mod.LMainPassive.MUTANT_SPIDER] = mod.DoorType.TREASURE,
    
    [mod.LSecondaryPassives.IPECAC] = mod.DoorType.TREASURE,
    [mod.LSecondaryPassives._20_20] = mod.DoorType.TREASURE,
    [mod.LSecondaryPassives.GOD_HEAD] = mod.DoorType.ANGEL,
    [mod.LSecondaryPassives.SACRED_HEART] = mod.DoorType.ANGEL,
    [mod.LSecondaryPassives.PARASITE] = mod.DoorType.TREASURE,
    [mod.LSecondaryPassives.CONTINUUM] = mod.DoorType.TREASURE,
    [mod.LSecondaryPassives.CLASSIC_WORM] = mod.DoorType.TREASURE,
}
mod.LItemPath = {
    [mod.LActives.ABYSS] = "gfx/items/collectibles/collectibles_706_abyss.png",
    [mod.LActives.BOOK_VIRTUDES] = "gfx/items/collectibles/collectibles_584_bookofvirtues.png",
    [mod.LActives.BIBLE] = "gfx/items/collectibles/collectibles_033_thebible.png",
    [mod.LActives.BOOK_BELIAL] = "gfx/items/collectibles/collectibles_034_thebookofbelial.png",
    [mod.LActives.BOOK_SHADOWS] = "gfx/items/collectibles/collectibles_058_bookofshadows.png",
    [mod.LActives.ANARCHIST] = "gfx/items/collectibles/collectibles_065_anarchistcookbook.png",
    [mod.LActives.BOOK_DEAD] = "gfx/items/collectibles/collectibles_545_bookofthedead.png",
    
    [mod.LSpecials.FLIP] = "gfx/items/collectibles/collectibles_711_flip.png",
    [mod.LSpecials.MEGA_MUSH] = "gfx/items/collectibles/collectibles_625_megamush.png",
    [mod.LSpecials.MOMS_SHOVEL] = "gfx/items/collectibles/collectibles_552_momsshovel.png",
    
    [mod.LAssistPassives.INCUBUS] = "gfx/items/collectibles/collectibles_360_incubus.png",
    [mod.LAssistPassives.MOMS_KNIFE] = "gfx/items/collectibles/collectibles_114_momsknife.png",
    [mod.LAssistPassives.HOLY_MANTLE] = "gfx/items/collectibles/collectibles_313_holymantle.png",
    [mod.LAssistPassives.WAFER] = "gfx/items/collectibles/collectibles_108_thewafer.png",
    [mod.LAssistPassives.MAGIC_MUSHROOM] = "gfx/items/collectibles/collectibles_012_magicmushroom.png",
    [mod.LAssistPassives.POLYPHEMUS] = "gfx/items/collectibles/collectibles_169_polyphemus.png",
    [mod.LAssistPassives.MAW_VOID] = "gfx/items/collectibles/collectibles_399_mawofthevoid.png",
    --[mod.LAssistPassives.PARASITOID] = "gfx/items/collectibles/collectibles_461_parasitoid.png",
    [mod.LAssistPassives.BOWL_TEARS] = "gfx/items/collectibles/collectibles_109_bowloftears.png",--REMIX
    [mod.LAssistPassives.STOPWATCH] = "gfx/items/collectibles/collectibles_232_stopwatch.png",
    
    [mod.LMainPassive.C_SECTION] = "gfx/items/collectibles/collectibles_678_csection.png",
    [mod.LMainPassive.DR_FETUS] = "gfx/items/collectibles/collectibles_052_drfetus.png",
    [mod.LMainPassive.TECH_X] = "gfx/items/collectibles/collectibles_395_techx.png",
    [mod.LMainPassive.HEMOLACRYA] = "gfx/items/collectibles/collectibles_531_haemolacria.png",
    [mod.LMainPassive.BRIMSTONE] = "gfx/items/collectibles/collectibles_118_brimstone.png",
    --[mod.LMainPassive.EPIC_FETUS] = "gfx/items/collectibles/collectibles_168_epicfetus.png",
    [mod.LMainPassive.REVELATIONS] = "gfx/items/collectibles/collectibles_643_revelation.png",
    [mod.LMainPassive.MUTANT_SPIDER] = "gfx/items/collectibles/collectibles_153_mutantspider.png",
    
    [mod.LSecondaryPassives.IPECAC] = "gfx/items/collectibles/collectibles_149_ipecac.png",
    [mod.LSecondaryPassives._20_20] = "gfx/items/collectibles/collectibles_245_2020.png",
    [mod.LSecondaryPassives.GOD_HEAD] = "gfx/items/collectibles/collectibles_331_godhead.png",
    [mod.LSecondaryPassives.SACRED_HEART] = "gfx/items/collectibles/collectibles_182_sacredheart.png",
    [mod.LSecondaryPassives.PARASITE] = "gfx/items/collectibles/collectibles_104_theparasite.png",
    [mod.LSecondaryPassives.CONTINUUM] = "gfx/items/collectibles/collectibles_369_continuum.png",
    [mod.LSecondaryPassives.CLASSIC_WORM] = "gfx/items/collectibles/collectibles_109_wiggleworm.png",--CLASSIC

}

mod.LItemType = {
    ACTIVE = 1<<0,
    MAIN = 1<<1,
    SECONDARY = 1<<2,
    ASSIST = 1<<3,
    SPECIAL = 1<<4
}

if TaintedTreasure then
    mod.LMainPassive.LIL_SLUGGER = 33
    mod.LAssistPassives.BUGULON = 34
    mod.LMainPassive.SPIDER_FREAK = 35

    mod.LItemDoor[mod.LMainPassive.LIL_SLUGGER] = mod.DoorType.TAINTED
    mod.LItemPath[mod.LMainPassive.LIL_SLUGGER] = "gfx/items/collectibles/collectible_lilslugger.png"
    mod.LItemDoor[mod.LAssistPassives.BUGULON] = mod.DoorType.TAINTED
    mod.LItemPath[mod.LAssistPassives.BUGULON] = "gfx/items/collectibles/collectible_bugulonsuperfan.png"
    mod.LItemDoor[mod.LMainPassive.SPIDER_FREAK] = mod.DoorType.TAINTED
    mod.LItemPath[mod.LMainPassive.SPIDER_FREAK] = "gfx/items/collectibles/collectible_spiderfreak.png"
end
if FiendFolio then
    mod.LActives.FIEND_FOLIO = 36
    mod.LActives.HORSE_PASTE = 37
    
    mod.LItemDoor[mod.LActives.FIEND_FOLIO] = mod.DoorType.LIBRARY
    mod.LItemPath[mod.LActives.FIEND_FOLIO] = "gfx/items/collectibles/012_the_fiend_folio.png"
    mod.LItemDoor[mod.LActives.HORSE_PASTE] = mod.DoorType.SHOP
    mod.LItemPath[mod.LActives.HORSE_PASTE] = "gfx/items/collectibles/collectibles_horse_paste.png"
end
if Althorsemen then
    mod.LActives.BOOK_REVELATIONS = 38
    
    mod.LItemDoor[mod.LActives.BOOK_REVELATIONS] = mod.DoorType.LIBRARY
    mod.LItemPath[mod.LActives.BOOK_REVELATIONS] = "gfx/items/collectibles/collectibles_078_bookofrevelations.png"
end

mod.chainL = {                    --Appear  Idle   Attack Charge Telep  Item   Boss   MegaS  Curse  Arcad  Bed    Dice   Plan   Vault  Speci  Sacrfice
    [mod.LMSState.APPEAR] =         {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.IDLE] =           {0.000, 0.200, 0.230, 0.000, 0.050, 0.250, 0.030, 0.030, 0.030, 0.030, 0.000, 0.030, 0.030, 0.030, 0.030, 0.030},
    --[mod.LMSState.IDLE] =           {0.000, 0.000, 0.000, 0.000, 1.000, 0.500, 0.000, 0.000, 0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000},
    [mod.LMSState.ATTACK] =         {0.000, 0.350, 0.350, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.100, 0.100, 0.100, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.CHARGE] =         {0.000, 0.400, 0.400, 0.000, 0.200, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.TELEPORT] =       {0.000, 0.400, 0.200, 0.000, 0.000, 0.400, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.ITEM] =           {0.000, 0.000, 0.500, 0.000, 0.000, 0.400, 0.000, 0.000, 0.000, 0.000, 0.000, 0.100, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.BOSSROOM] =       {0.000, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.300, 0.000, 0.400, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.MEGASATAN] =      {0.000, 0.100, 0.000, 0.000, 0.000, 0.300, 0.000, 0.000, 0.300, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.CURSE] =          {0.000, 0.750, 0.250, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.ARCADE] =         {0.000, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.300, 0.000, 0.300, 0.100, 0.000},
    [mod.LMSState.BEDROOM] =        {0.000, 0.700, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.DICE] =           {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.PLANETARIUM] =    {0.000, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.300, 0.000, 0.400, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.VAULT] =          {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.SPECIAL] =        {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.SACRIFICE] =      {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    
}
mod.LConst = {--Some constant variables of Luna
    idleTimeInterval = Vector(10,15),
    speed = 1.4,
    superSpeed = 1.55,

    dashSpeed = 60,

    hpSS = 0.075,

    minDistanceToReappear = 120,

    curseSpeed = 20,

    sleepShield = 80,
    healPerSleep = 10,--10

    nCoins = 3,

    xTechSpeed = 6,
    xTechSize = 30,

    _20_20_distance = 20,

    spiderFreakAngle = 13,
    spiderAngle = 16,

    healPerGlue = 75,

    shadowShieldFrames = 30*5,
    belialFrames = 30*7,

    nLocust = 8,
    nBones = 8,
    nWisps = 5,

    wispShotSpeed = 5,

    bowlChance = 0.075,

    knifeRange = 65,

    mawFrames = 30*5,
    mawTimeout = 100,
    mawRadius = 45,

    incubusScale = 0.65,

    sluggerSpeed = 7,

}

function mod:LunaUpdate(entity)
    if entity.Variant == mod.EntityInf[mod.Entity.Luna].VAR and entity.SubType == mod.EntityInf[mod.Entity.Luna].SUB then
        local data = entity:GetData()
        local sprite = entity:GetSprite()
        local target = entity:GetPlayerTarget()
        local room = game:GetRoom()
        
        --Custom data:
        if data.State == nil then 
            data.State = 0 
            data.StateFrame = 0
            data.SSFlag = false

            data.MainP = 0
            data.SecondaryP = 0
            data.AssistP = 0

            data.SleepShield = 0
            data.ShieldTime = 0
            data.StrengthTime = 0
            data.HasMantle = false
            data.HasMaw = false
            data.MawTime = 0

            for i=1,4 do
                local door = Isaac.Spawn(EntityType.ENTITY_ULTRA_DOOR, 0, 0, room:GetCenterPos(), Vector.Zero, nil)
                door.Visible = false
            end
        end
        
        --print(data.State)

        --Frame
        data.StateFrame = data.StateFrame + 1
        
        if not data.SSFlag and entity.HitPoints < entity.MaxHitPoints * mod.LConst.hpSS and data.State == mod.LMSState.IDLE then
            data.SSFlag = true
            data.StateFrame = 0
        end

        if data.SSFlag then
            mod:LunaSS(entity, data, sprite, target,room)
        else
            if data.State == mod.LMSState.APPEAR then
                if data.StateFrame == 1 then
                    mod:AppearPlanet(entity)
                    entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
                    entity:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
                elseif sprite:IsFinished("Appear") or sprite:IsFinished("AppearSlow") then
                    data.State = mod:MarkovTransition(data.State, mod.chainL)
                    data.StateFrame = 0
                elseif sprite:IsEventTriggered("EndAppear") then
                    entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
                end
                
            elseif data.State == mod.LMSState.IDLE then
                if data.StateFrame == 1 then
                    sprite:Play("Idle",true)
                elseif sprite:IsFinished("Idle") then
                    data.State = mod:MarkovTransition(data.State, mod.chainL)
                    data.StateFrame = 0
                    
                else
                    mod:LunaMove(entity, data, room, target)
                end
                
            elseif data.State == mod.LMSState.ATTACK then
                mod:LunaAttack(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.CHARGE then
                mod:LunaCharge(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.TELEPORT then
                mod:LunaTeleport(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.ITEM then
                mod:LunaItem(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.BOSSROOM then
                mod:LunaBoss(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.MEGASATAN then
                mod:LunaMegaSatan(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.CURSE then
                mod:LunaCurse(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.ARCADE then
                mod:LunaArcade(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.BEDROOM then
                mod:LunaBed(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.DICE then
                mod:LunaDice(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.PLANETARIUM then
                mod:LunaPlanetarium(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.VAULT then
                mod:LunaVault(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.SPECIAL then
                mod:LunaSpecial(entity, data, sprite, target,room)
            elseif data.State == mod.LMSState.SACRIFICE then
                mod:LunaSacrifice(entity, data, sprite, target,room)
            end
        end

        --Stats
        data.ShieldTime = data.ShieldTime - 1
        data.StrengthTime = data.StrengthTime - 1

        if data.AssistP == mod.LAssistPassives.MAGIC_MUSHROOM then
            entity.SpriteScale = Vector.One*1.5
        else
            entity.SpriteScale = Vector.One
        end
        
        if data.AssistP == mod.LAssistPassives.STOPWATCH then
            sprite.PlaybackSpeed = 1.1
        else
            sprite.PlaybackSpeed = 1
        end

        if data.ShieldTime > 0 and entity.FrameCount%15==0 then

            local shield = mod:SpawnEntity(mod.Entity.ICUP, entity.Position + Vector(0,-30), Vector.Zero, entity):ToEffect()
            shield:FollowParent(entity)
            shield.DepthOffset = 500

            local shieldSprite = shield:GetSprite()
            shieldSprite:Load("gfx/effect_LunaShield.anm2", true)
            shieldSprite:ReplaceSpritesheet(2, "gfx/effects/bishop_shield.png")
            shieldSprite:ReplaceSpritesheet(1, "gfx/effects/bishop_shield.png")
            shieldSprite:Play("Idle", true)
            shieldSprite:LoadGraphics()
        end
        
        if data.HasMaw then
            mod:LunaMaw(entity, data, entity:GetSprite(), target, room)
        end

    end
end
function mod:LunaAttack(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("NormalAttack",true)
        data.TargetAim = target.Position
    elseif sprite:IsFinished("NormalAttack") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Attack") then
        mod:LunaSynergy(entity, data, sprite, target, room, false)
    end

end
function mod:LunaCharge(entity, data, sprite, target,room)
    if data.Height then
        entity.Position = Vector(entity.Position.X, data.Height)
    end

    if data.StateFrame == 1 then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0
        --XDDDDD

        data.Height = entity.Position.Y
        local direction = mod.RoomWalls.RIGHT
        local rotation = 90

        if (entity.Position.X - target.Position.X) < 0 then
            sprite:Play("DashR",true)
            data.Direcion = 1
        else
            sprite:Play("DashL",true)
            rotation = -90
            direction = mod.RoomWalls.LEFT
            data.Direcion = -1
        end

        local position = mod.BorderRoom[direction][room:GetRoomShape()] - data.Direcion*70

        local door = mod:SpawnLunaDoor(entity, mod.DoorType.NORMAL, Vector(position, entity.Position.Y))
        door:GetSprite().Rotation = rotation

    elseif sprite:IsFinished("DashR") or sprite:IsFinished("DashL") or sprite:IsFinished("TrapdoorOut") then
        data.Height = nil
        data.DashFlag = false
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Attack") then
        data.DashFlag = true
    end

    if data.DashFlag then
        entity.Velocity = Vector(mod.LConst.dashSpeed * data.Direcion, 0)
    end

end
function mod:LunaTeleport(entity, data, sprite, target,room)
    entity.Velocity = Vector.Zero

    if data.StateFrame == 1 then
        sprite:Play("TrapdoorIn",true)

		local trapdoor = mod:SpawnEntity(mod.Entity.RedTrapdoor, entity.Position, Vector.Zero, entity)
        trapdoor:GetSprite():Play("BigIdle", true)

    elseif sprite:IsFinished("TrapdoorOut") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0
    elseif sprite:IsFinished("TrapdoorIn") and entity.Visible then

        entity.Visible = false
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

        mod:scheduleForUpdate(function()
            sprite:Play("TrapdoorOut",true)
            entity.Visible = true
            entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
        end, 5,ModCallbacks.MC_POST_UPDATE)

		local position = Isaac.GetRandomPosition(0)
		while position:Distance(target.Position) < mod.LConst.minDistanceToReappear do
			position = Isaac.GetRandomPosition(0)
		end
        entity.Position = position

		local trapdoor = mod:SpawnEntity(mod.Entity.RedTrapdoor, position, Vector.Zero, entity)
        trapdoor:GetSprite():Play("BigIdle", true)

    end

end
function mod:LunaItem(entity, data, sprite, target,room)
    entity.Velocity = Vector.Zero

    if data.StateFrame == 1 then
        sprite:Play("SummonDoor",true)
    elseif sprite:IsFinished("PickUp") then
        
        mod:GiveItemLuna(entity, data.LastItem)

        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0
    elseif sprite:IsFinished("SummonDoor") then
        sprite:Play("PickUp",true)

    elseif sprite:IsEventTriggered("PickUp") then
		sfx:Play(SoundEffect.SOUND_POWERUP1)

    elseif sprite:IsEventTriggered("SummonDoor") then

        local itemType = 0 -- 00001 active, 00010 a.passive, 00100 m.passive, 01000 s.passive, 10000 special
        local itemNum = -1

        local random = mod:RandomInt(1,9)
        if random <= 2 then
            itemType = mod.LItemType.ACTIVE
            itemNum = mod:random_elem(mod.LActives)
        elseif random <= 4 then
            itemType = mod.LItemType.MAIN
            itemNum = mod:LunaChooseItem(mod.LMainPassive, data.mainP)
        elseif random <= 6 then
            itemType = mod.LItemType.SECONDARY
            itemNum = mod:LunaChooseItem(mod.LSecondaryPassives, data.secondaryP)
        elseif random <= 8 then
            itemType = mod.LItemType.ASSIST
            itemNum = mod:LunaChooseItem(mod.LAssistPassives, data.AssistP)
        else
            itemType = mod.LItemType.SPECIAL
            itemNum = mod:random_elem(mod.LSpecials)
        end

        data.LastItem = itemNum
        data.LastItemType = itemType
        
        sprite:ReplaceSpritesheet(1, mod.LItemPath[data.LastItem])
        sprite:LoadGraphics()

        local door = mod:SpawnLunaDoor(entity, mod.LItemDoor[itemNum], entity.Position + Vector(50,0))
    end

end
function mod:LunaBoss(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        if mod:LunaBossCount() <= 0 then
            sprite:Play("SummonDoor",true)
        else
            data.State = mod:MarkovTransition(data.State, mod.chainL)
            data.StateFrame = 0
        end
    elseif sprite:IsFinished("Cheer") or data.StateFrame > 150 then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0
    elseif sprite:IsFinished("SummonDoor") then
        sprite:Play("Idle",true)
    elseif entity.Child and entity.Child:GetData().Frame == 30 then
        sprite:Play("Cheer",true)

    elseif sprite:IsEventTriggered("SummonDoor") then
        local door = mod:SpawnLunaDoor(entity, mod.DoorType.BOSS)
    end

end
function mod:LunaMegaSatan(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("SummonDoorMega",true)
    elseif sprite:IsFinished("SummonDoorMega") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("SummonDoor") then

        local direction = mod.RoomWalls.UP
        local rotation = 0
        if rng:RandomFloat() < 0.5 then
            rotation = 180
            direction = mod.RoomWalls.DOWN
        end

        local shape = room:GetRoomShape()
        local position = mod.BorderRoom[direction][shape]

        local door = mod:SpawnEntity(mod.Entity.LunaMegaSatanDoor, Vector(mod:RandomInt(70+mod.BorderRoom[mod.RoomWalls.LEFT][shape],-70+mod.BorderRoom[mod.RoomWalls.RIGHT][shape]),position), Vector.Zero, entity)
        door:GetSprite().Rotation = rotation
        door.Parent = entity
        entity.Child = door
    end

end
function mod:LunaCurse(entity, data, sprite, target,room)
    entity.Velocity = Vector.Zero

    if data.StateFrame == 1 then
        sprite:Play("SummonDoor",true)
    elseif sprite:IsFinished("Snap") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0
        data.CuseFlag = false
    elseif sprite:IsFinished("SummonDoor") then
        sprite:Play("Snap",true)

    elseif sprite:IsEventTriggered("SummonDoor") then
        local door = mod:SpawnLunaDoor(entity, mod.DoorType.CURSE, entity.Position + Vector(0,20))
        data.CuseFlag = true
    elseif sprite:IsEventTriggered("Snap") then
        entity.Child.Velocity = (target.Position - entity.Position):Normalized() * mod.LConst.curseSpeed
    end

    if entity.Child and entity.Child.Velocity:Length()<mod.LConst.curseSpeed and data.CuseFlag then
        entity.Child:GetSprite().Rotation = (target.Position - entity.Position):GetAngleDegrees() - 90
    end

end
function mod:LunaArcade(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("SummonDoor",true)
    elseif sprite:IsFinished("SummonDoor") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("SummonDoor") then
        local door = mod:SpawnLunaDoor(entity, mod.DoorType.ARCADE)
    end

end
function mod:LunaBed(entity, data, sprite, target,room)
    entity.Velocity = Vector.Zero

    if data.StateFrame == 1 then
        sprite:Play("SummonDoor",true)
    elseif sprite:IsFinished("SleepEnd") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0

    elseif sprite:IsFinished("SummonDoor") then
        sprite:Play("GoToSleep",true)
        sfx:Play(SoundEffect.SOUND_SUMMONSOUND,1)

    elseif sprite:IsFinished("GoToSleep") then
        sprite:Play("Sleeping",true)
        data.SleepShield = mod.LConst.sleepShield

    elseif sprite:IsFinished("Sleeping") then
        sprite:Play("Sleeping",true)
        --Heal
        mod:LunaHeal(entity, mod.LConst.healPerSleep)

    elseif sprite:IsPlaying("Sleeping") and entity.HitPoints == entity.MaxHitPoints then
        sprite:Play("SleepEnd",true)

    elseif sprite:IsEventTriggered("Attack") then
        local door = mod:SpawnLunaDoor(entity, mod.DoorType.BEDROOM, entity.Position)
    end

end
function mod:LunaDice(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("SummonDoor",true)
    elseif sprite:IsFinished("Dice") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0
    elseif sprite:IsFinished("SummonDoor") then
        sprite:Play("Dice",true)

    elseif sprite:IsEventTriggered("Dice") then
        sfx:Play(SoundEffect.SOUND_EDEN_GLITCH,1)
        
        mod:GiveItemLuna(entity, mod:LunaChooseItem(mod.LMainPassive, data.mainP, true), mod.LItemType.MAIN)
        mod:GiveItemLuna(entity, mod:LunaChooseItem(mod.LSecondaryPassives, data.secondaryP, true), mod.LItemType.SECONDARY)
        mod:GiveItemLuna(entity, mod:LunaChooseItem(mod.LAssistPassives, data.AssistP, true), mod.LItemType.ASSIST)

    elseif sprite:IsEventTriggered("SummonDoor") then
        local door = mod:SpawnLunaDoor(entity, mod.DoorType.DICE)
    end

end
function mod:LunaPlanetarium(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        if mod:LunaBossCount() <= 0 then
            sprite:Play("SummonDoor",true)
        else
            data.State = mod:MarkovTransition(data.State, mod.chainL)
            data.StateFrame = 0
        end
    elseif sprite:IsFinished("Cheer") or data.StateFrame > 150 then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0
    elseif sprite:IsFinished("SummonDoor") then
        sprite:Play("Idle",true)
    elseif entity.Child and entity.Child:GetData().Frame == 30 then
        sprite:Play("Cheer",true)

    elseif sprite:IsEventTriggered("SummonDoor") then
        local door = mod:SpawnLunaDoor(entity, mod.DoorType.PLANETARIUM)
    end

end
function mod:LunaVault(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("SummonDoor",true)
    elseif sprite:IsFinished("SummonDoor") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("SummonDoor") then
        local door = mod:SpawnLunaDoor(entity, mod.DoorType.VAULT)
    end

end
function mod:LunaSpecial(entity, data, sprite, target,room)
    entity.Velocity = Vector.Zero

    if data.StateFrame == 1 then
        if REVEL then
            sprite:Play("SummonDoor",true)
        else
            data.State = mod:MarkovTransition(data.State, mod.chainL)
            data.StateFrame = 0
        end
    elseif sprite:IsFinished("SummonDoor") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("SummonDoor") then

    end

end
function mod:LunaSacrifice(entity, data, sprite, target,room)
    entity.Velocity = Vector.Zero

    if data.StateFrame == 1 then
        sprite:Play("SummonDoor",true)
    elseif sprite:IsFinished("Jump") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0
    elseif sprite:IsFinished("SummonDoor") then
        sprite:Play("Jump",true)

    elseif sprite:IsEventTriggered("Jump") then
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

    elseif sprite:IsEventTriggered("Land") then
        entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
        --SPIKES
        local nSpikes = 9
        if (room:GetRoomShape()>=RoomShape.ROOMSHAPE_2x2) then
            nSpikes = 27
        end

        for i=1,nSpikes do
            local position = room:GetGridPosition(room:GetClampedGridIndex (room:GetRandomPosition(0)))
            local spike = mod:SpawnEntity(mod.Entity.Spike, position, Vector.Zero, entity)
            spike.Parent = entity
        end
        
    elseif sprite:IsEventTriggered("Preland") and entity.Child then
        entity.Child:GetSprite():Play("Close",true)

    elseif sprite:IsEventTriggered("SummonDoor") then
        local door = mod:SpawnLunaDoor(entity, mod.DoorType.SACRIFICE, entity.Position)
    end

end
function mod:LunaSS(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("Idle",true)
    elseif sprite:IsFinished("Idle") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Attack") then

    end

end

function mod:LunaSynergy(entity, data, sprite, target, room, incubus)

    local mainP
    local secondaryP

    local parent

    local scale = 1
    local laserFrac = 1

    if incubus then
        parent = entity.Parent:ToNPC()

        mainP = parent:GetData().MainP
        secondaryP = parent:GetData().SecondaryP

        scale = mod.LConst.incubusScale
        laserFrac = 2

        data.TargetAim = parent:GetData().TargetAim + (entity.Position - parent.Position)

    else
        mainP = data.MainP
        secondaryP = data.SecondaryP

        local strong = data.StrengthTime >= 0 or data.AssistP == mod.LAssistPassives.POLYPHEMUS or data.AssistP == mod.LAssistPassives.MAGIC_MUSHROOM
        if strong then
            scale = scale + 0.5
        end
    end

    --mainP = mod.LMainPassive.REVELATIONS
    --secondaryP = mod.LSecondaryPassives.SACRED_HEART
    --scale = 2

    if mainP == 0 then

        local velocity = (target.Position - entity.Position):Normalized()*10
        local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, velocity, entity):ToProjectile()
        tear.Scale = scale

        if secondaryP == mod.LSecondaryPassives.IPECAC then

            local variance = (Vector(mod:RandomInt(-15, 15),mod:RandomInt(-15, 15))*0.03)
            local vector = (target.Position-entity.Position)*0.028 + variance

            tear.Velocity = vector*scale
            
            tear.Scale = 2*scale
            tear.FallingSpeed = -45;
            tear.FallingAccel = 1.5;

            tear:GetSprite().Color = mod.Colors.boom

            tear:AddProjectileFlags(ProjectileFlags.EXPLODE)

        elseif secondaryP == mod.LSecondaryPassives._20_20 then

            tear.Position = tear.Position + tear.Velocity:Normalized():Rotated(90)*mod.LConst._20_20_distance
            
            local tear2 = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, tear.Velocity, entity):ToProjectile()
            tear2.Position = tear2.Position + tear2.Velocity:Normalized():Rotated(-90)*mod.LConst._20_20_distance
            tear2.Scale = scale

        elseif secondaryP == mod.LSecondaryPassives.GOD_HEAD then

            tear.Scale = 1.5*scale
            --tear:AddProjectileFlags(ProjectileFlags.GODHEAD)
            tear.Velocity = tear.Velocity/3
            mod:TearFallAfter(tear, 300)

            tear:GetSprite().Color = mod.Colors.whiteish


            local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 0, tear.Position, tear.Velocity, tear):ToEffect()
            aura.Parent = tear
            tear.Child = aura
            aura:GetSprite():Load("gfx/1000.123_Halo (Static Prerendered).anm2", true)
            aura:GetSprite():ReplaceSpritesheet(0, "gfx/effects/luna_god.png")
            aura:GetSprite():LoadGraphics()
            aura:GetSprite():Play("Idle", true)
            aura.SpriteScale = aura.SpriteScale*1.3
            aura:FollowParent(tear)
            tear:Update()

            tear:GetData().LunaProjectile = true
            tear:GetData().LunaGodHead = true

        elseif secondaryP == mod.LSecondaryPassives.SACRED_HEART then

            tear.Scale = 1.75*scale
            tear:AddProjectileFlags(ProjectileFlags.SMART)
            tear.HomingStrength = tear.HomingStrength*0.9
            mod:TearFallAfter(tear, 300)
            
            tear:GetData().LunaProjectile = true
            tear:GetData().LunaSacred = true

        elseif secondaryP == mod.LSecondaryPassives.PARASITE then

            tear:GetData().LunaProjectile = true
            tear:GetData().LunaParasite = true

        elseif secondaryP == mod.LSecondaryPassives.CONTINUUM then

            tear:AddProjectileFlags(ProjectileFlags.CONTINUUM)
            mod:TearFallAfter(tear, 30*7)

        elseif secondaryP == mod.LSecondaryPassives.CLASSIC_WORM then

            tear.Velocity = tear.Velocity * 0.5

            tear:AddProjectileFlags(ProjectileFlags.MEGA_WIGGLE)
            tear:AddProjectileFlags(ProjectileFlags.NO_WALL_COLLIDE)
            tear.WiggleFrameOffset = 2000
            mod:TearFallAfter(tear, 30*5)

        end

    elseif mainP == mod.LMainPassive.C_SECTION then

        local velocity = (target.Position - entity.Position):Normalized()*10
        local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, velocity, entity):ToProjectile()
        
        tear:AddProjectileFlags(ProjectileFlags.SMART_PERFECT)
        tear.Velocity = tear.Velocity/3*2
        mod:TearFallAfter(tear, 100*scale)
        tear.Scale = scale

        if secondaryP == mod.LSecondaryPassives.IPECAC then
            
            tear.Scale = 1.5*scale

            tear:GetSprite().Color = mod.Colors.boom

            tear:AddProjectileFlags(ProjectileFlags.EXPLODE)

        elseif secondaryP == mod.LSecondaryPassives._20_20 then

            tear.Position = tear.Position + tear.Velocity:Normalized():Rotated(90)*mod.LConst._20_20_distance
            
            local tear2 = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, tear.Velocity, entity):ToProjectile()
            tear2.Position = tear2.Position + tear2.Velocity:Normalized():Rotated(-90)*mod.LConst._20_20_distance
            
            tear2:AddProjectileFlags(ProjectileFlags.SMART_PERFECT)
            tear2.Velocity = tear2.Velocity/3*2
            tear2.Scale = scale
            mod:TearFallAfter(tear2, 100*scale)

        elseif secondaryP == mod.LSecondaryPassives.GOD_HEAD then

            tear.Scale = 1.5*scale
            --tear:AddProjectileFlags(ProjectileFlags.GODHEAD)
            tear.Velocity = tear.Velocity/3
            mod:TearFallAfter(tear, 300*scale)

            tear:GetSprite().Color = mod.Colors.whiteish


            local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 0, tear.Position, tear.Velocity, tear):ToEffect()
            aura.Parent = tear
            tear.Child = aura
            aura:GetSprite():Load("gfx/1000.123_Halo (Static Prerendered).anm2", true)
            aura:GetSprite():ReplaceSpritesheet(0, "gfx/effects/luna_god.png")
            aura:GetSprite():LoadGraphics()
            aura:GetSprite():Play("Idle", true)
            aura.SpriteScale = aura.SpriteScale*1.3
            aura:FollowParent(tear)
            tear:Update()

            tear:GetData().LunaProjectile = true
            tear:GetData().LunaGodHead = true

        elseif secondaryP == mod.LSecondaryPassives.SACRED_HEART then

            tear.Scale = 1.75*scale
            tear:AddProjectileFlags(ProjectileFlags.SMART)
            tear.HomingStrength = tear.HomingStrength
            mod:TearFallAfter(tear, 30*3*scale)
            
            tear:GetData().LunaProjectile = true
            tear:GetData().LunaSacred = true

            tear.Velocity = tear.Velocity * 1.25

        elseif secondaryP == mod.LSecondaryPassives.PARASITE then

            tear:GetData().LunaProjectile = true
            tear:GetData().LunaParasite = true

        elseif secondaryP == mod.LSecondaryPassives.CONTINUUM then

            tear:AddProjectileFlags(ProjectileFlags.CONTINUUM)
            mod:TearFallAfter(tear, 30*7*scale)

        elseif secondaryP == mod.LSecondaryPassives.CLASSIC_WORM then

            tear.Velocity = tear.Velocity * 0.5

            tear:AddProjectileFlags(ProjectileFlags.MEGA_WIGGLE)
            tear:AddProjectileFlags(ProjectileFlags.NO_WALL_COLLIDE)
            tear.WiggleFrameOffset = 2000
            mod:TearFallAfter(tear, 30*5*scale)

        end

    elseif mainP == mod.LMainPassive.DR_FETUS then

        local velocity = (target.Position - entity.Position):Normalized()*10

        local bombVar = BombVariant.BOMB_NORMAL
        if incubus then bombVar = BombVariant.BOMB_SMALL end

        local bomb = Isaac.Spawn(EntityType.ENTITY_BOMB, bombVar, 0, entity.Position+5*velocity, velocity, entity):ToBomb()
        local bombSprite = bomb:GetSprite()

        if secondaryP == mod.LSecondaryPassives.IPECAC then

            mod:scheduleForUpdate(function()
                bombSprite:ReplaceSpritesheet(0, "gfx/items/pick ups/bombs/costumes/poison.png")
                bombSprite:LoadGraphics()
            end,2)
            
            bomb:AddTearFlags(TearFlags.TEAR_EXPLOSIVE)

            bomb:GetData().LunaBomb = true
            bomb:GetData().LunaIpecac = true
            

        elseif secondaryP == mod.LSecondaryPassives._20_20 then

            bomb.Position = bomb.Position + bomb.Velocity:Normalized():Rotated(90)*mod.LConst._20_20_distance
            
            local bomb2 = Isaac.Spawn(EntityType.ENTITY_BOMB, bombVar, 0, entity.Position+5*velocity, bomb.Velocity, entity):ToBomb()
            bomb2.Position = bomb2.Position + bomb2.Velocity:Normalized():Rotated(-90)*mod.LConst._20_20_distance

        elseif secondaryP == mod.LSecondaryPassives.GOD_HEAD then

            bomb:GetSprite().Color = mod.Colors.whiteish

            local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 0, bomb.Position, bomb.Velocity, bomb):ToEffect()
            aura.Parent = bomb
            bomb.Child = aura
            aura:GetSprite():Load("gfx/1000.123_Halo (Static Prerendered).anm2", true)
            aura:GetSprite():ReplaceSpritesheet(0, "gfx/effects/luna_god.png")
            aura:GetSprite():LoadGraphics()
            aura:GetSprite():Play("Idle", true)
            aura.SpriteScale = aura.SpriteScale*1.3
            aura:FollowParent(bomb)
            bomb:Update()

            bomb:GetData().LunaBomb = true
            bomb:GetData().LunaGodHead = true

        elseif secondaryP == mod.LSecondaryPassives.SACRED_HEART then

            bomb:AddTearFlags(TearFlags.TEAR_HOMING)

            bombSprite.Color = mod.Colors.white
            
            bomb.Parent = entity

            bomb:GetData().LunaBomb = true
            bomb:GetData().LunaSacred = true

        elseif secondaryP == mod.LSecondaryPassives.PARASITE then

            bomb:GetData().LunaBomb = true
            bomb:GetData().LunaParasite = true

        elseif secondaryP == mod.LSecondaryPassives.CONTINUUM then
            --Nothing :(
        elseif secondaryP == mod.LSecondaryPassives.CLASSIC_WORM then

            bomb:AddTearFlags(TearFlags.TEAR_SPECTRAL)
            bomb.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY

            bomb:GetData().lunaBomb = true
            bomb:GetData().lunaWorm = true
            bomb:GetData().velocity = bomb.Velocity
        end

    elseif mainP == mod.LMainPassive.TECH_X then
        
        local velocity = (target.Position - entity.Position):Normalized()*mod.LConst.xTechSpeed
        local ring = Isaac.Spawn(EntityType.ENTITY_LASER, LaserVariant.THIN_RED, 2, entity.Position+Vector(0,-40), velocity, entity):ToLaser()
        ring.Parent = entity
        entity.Child = ring
        ring.Radius = mod.LConst.xTechSize*scale
        ring.DepthOffset = 500

        if secondaryP == mod.LSecondaryPassives.IPECAC then

            ring:AddTearFlags(TearFlags.TEAR_EXPLOSIVE)
            ring:GetSprite().Color = mod.Colors.boom

            ring:GetData().LunaRing = true
            ring:GetData().LunaIpecac = true
            ring:GetData().HeavensCall = true

        elseif secondaryP == mod.LSecondaryPassives._20_20 then

            ring.Position = ring.Position + ring.Velocity:Normalized():Rotated(90)*mod.LConst._20_20_distance*1.5
            
            local ring2 = Isaac.Spawn(EntityType.ENTITY_LASER, LaserVariant.THIN_RED, 2, entity.Position+Vector(0,-40), ring.Velocity, entity):ToLaser()
            ring2.Parent = entity
            entity.Child = ring2
            ring2.Radius = mod.LConst.xTechSize*scale
            ring2.DepthOffset = 500
            ring2.Position = ring2.Position - ring2.Velocity:Normalized():Rotated(90)*mod.LConst._20_20_distance*1.5

        elseif secondaryP == mod.LSecondaryPassives.GOD_HEAD then

            ring:GetSprite().Color = mod.Colors.whiteish
            ring.Velocity = ring.Velocity/2


            local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 0, ring.Position, ring.Velocity, ring):ToEffect()
            aura.Parent = ring
            aura:GetSprite():Load("gfx/1000.123_Halo (Static Prerendered).anm2", true)
            aura:GetSprite():ReplaceSpritesheet(0, "gfx/effects/luna_god.png")
            aura:GetSprite():LoadGraphics()
            aura:GetSprite():Play("Idle", true)
            aura.SpriteScale = aura.SpriteScale*1.3
            aura:FollowParent(ring)

            ring:GetData().LunaRing = true
            ring:GetData().LunaGodHead = true
            ring:GetData().HeavensCall = true

        elseif secondaryP == mod.LSecondaryPassives.SACRED_HEART then

            ring.Parent = entity
            ring:GetData().LunaRing = true
            ring:GetData().LunaSacred = true
            ring:GetData().HeavensCall = true
            ring:GetSprite().Color = mod.Colors.white

        elseif secondaryP == mod.LSecondaryPassives.PARASITE then

            ring.Parent = entity
            ring:GetData().LunaRing = true
            ring:GetData().LunaParasite = true
            ring:GetData().HeavensCall = true

        elseif secondaryP == mod.LSecondaryPassives.CONTINUUM then
            ring.Velocity = ring.Velocity*1.3
            ring:AddTearFlags(TearFlags.TEAR_CONTINUUM)

        elseif secondaryP == mod.LSecondaryPassives.CLASSIC_WORM then

            ring:AddTearFlags(TearFlags.TEAR_WIGGLE)
            ring.Radius = mod.LConst.xTechSize*1.2*scale

        end

    elseif mainP == mod.LMainPassive.HEMOLACRYA then

        --Ipecac-like projectile technique from Alt Horsemen
        local variance = (Vector(mod:RandomInt(-15, 15),mod:RandomInt(-15, 15))*0.03)
        local vector = (target.Position-entity.Position)*0.028 + variance
        
        local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, vector, entity):ToProjectile();
        tear.Scale = 2*scale
        tear.FallingSpeed = -45;
        tear.FallingAccel = 1.5;

        tear:GetData().LunaProjectile = true
        tear:GetData().LunaBrust = true
        
        if secondaryP == mod.LSecondaryPassives.IPECAC then
            
            tear:GetSprite().Color = mod.Colors.boom
            tear:AddProjectileFlags(ProjectileFlags.EXPLODE)
            tear:GetData().LunaIpecac = true

        elseif secondaryP == mod.LSecondaryPassives._20_20 then

            tear.Position = tear.Position + tear.Velocity:Normalized():Rotated(90)*mod.LConst._20_20_distance
            
            local tear2 = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, tear.Velocity, entity):ToProjectile();
            tear2.Scale = 2*scale
            tear2.FallingSpeed = -45;
            tear2.FallingAccel = 1.5;

            tear2:GetData().LunaProjectile = true
            tear2:GetData().LunaBrust = true
            
            tear2.Position = tear.Position - tear.Velocity:Normalized():Rotated(90)*mod.LConst._20_20_distance

        elseif secondaryP == mod.LSecondaryPassives.GOD_HEAD then

            tear:GetSprite().Color = mod.Colors.whiteish

            local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 0, tear.Position, tear.Velocity, tear):ToEffect()
            aura.Parent = tear
            tear.Child = aura
            aura:GetSprite():Load("gfx/1000.123_Halo (Static Prerendered).anm2", true)
            aura:GetSprite():ReplaceSpritesheet(0, "gfx/effects/luna_god.png")
            aura:GetSprite():LoadGraphics()
            aura:GetSprite():Play("Idle", true)
            aura.SpriteScale = aura.SpriteScale*1.3
            aura:FollowParent(tear)
            tear:Update()

            tear:GetData().LunaProjectile = true
            tear:GetData().LunaGodHead = true

        elseif secondaryP == mod.LSecondaryPassives.SACRED_HEART then

            tear:AddProjectileFlags(ProjectileFlags.SMART_PERFECT)
            tear.HomingStrength = tear.HomingStrength*0.5
            
            tear:GetData().LunaProjectile = true
            tear:GetData().LunaSacred = true

        elseif secondaryP == mod.LSecondaryPassives.PARASITE then

            tear:GetData().LunaParasite = true

        elseif secondaryP == mod.LSecondaryPassives.CONTINUUM then
            tear.Velocity = tear.Velocity*3
            tear:AddProjectileFlags(ProjectileFlags.CONTINUUM)
            tear:GetData().LunaContinnum = true

        elseif secondaryP == mod.LSecondaryPassives.CLASSIC_WORM then

            tear:AddProjectileFlags(ProjectileFlags.MEGA_WIGGLE)
            tear:AddProjectileFlags(ProjectileFlags.NO_WALL_COLLIDE)
            tear.WiggleFrameOffset = 2000

        end

    elseif mainP == mod.LMainPassive.BRIMSTONE then
    
        local laserVar = LaserVariant.THICK_RED

        local direction = (data.TargetAim - entity.Position):Normalized()
        local laser = EntityLaser.ShootAngle(laserVar, entity.Position, direction:GetAngleDegrees(), 15, Vector.Zero, entity):ToLaser()
        laser.Size = laser.Size/laserFrac

        if secondaryP == mod.LSecondaryPassives.IPECAC then

            laser:AddTearFlags(TearFlags.TEAR_EXPLOSIVE)
            laser:GetSprite().Color = mod.Colors.boom

            mod:scheduleForUpdate(function()
                --Need to get end of laser
                local position = laser:GetEndPoint()
                game:BombExplosionEffects (position, 100, TearFlags.TEAR_NORMAL, mod.Colors.boom, nil, 1*scale, true, false, DamageFlag.DAMAGE_EXPLOSION )
            end, 3)

        elseif secondaryP == mod.LSecondaryPassives._20_20 then

            laser:Remove()
            
            local pos2 = entity.Position - direction:Rotated(90)*mod.LConst._20_20_distance
            local laser2 = EntityLaser.ShootAngle(laserVar, pos2, direction:GetAngleDegrees(), 15, Vector.Zero, entity)
            laser2.Size = laser2.Size/laserFrac
            
            local pos3 = entity.Position + direction:Rotated(90)*mod.LConst._20_20_distance
            local laser3 = EntityLaser.ShootAngle(laserVar, pos3, direction:GetAngleDegrees(), 15, Vector.Zero, entity)
            laser3.Size = laser3.Size/laserFrac

        elseif secondaryP == mod.LSecondaryPassives.GOD_HEAD then

            laser:GetSprite().Color = mod.Colors.whiteish
            laser.Timeout = 45
            
            local laser2 = EntityLaser.ShootAngle(LaserVariant.LIGHT_BEAM, entity.Position + direction*80 , direction:GetAngleDegrees(), 45, Vector.Zero, entity)
            laser2.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
            laser2:GetSprite().Color = Color(1,1,1,0.5)
            mod:scheduleForUpdate(function()
                laser2.SpriteScale = 7*Vector.One
            end,5)

            laser2:GetData().LunaLaser = true
            laser2:GetData().LunaGodHead = true
            laser2:GetData().HeavensCall = true

        elseif secondaryP == mod.LSecondaryPassives.SACRED_HEART then --TODO

            entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

            laser:Remove()

            local adversary = Isaac.Spawn(EntityType.ENTITY_ADVERSARY, 0, 0, entity.Position, Vector.Zero, entity):ToNPC()
            adversary:GetData().HeavensCall = true
            adversary.Visible = false
            adversary.State = 8
            adversary.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

            adversary:AddEntityFlags(EntityFlag.FLAG_DONT_COUNT_BOSS_HP)
            adversary:ClearEntityFlags(EntityFlag.FLAG_APPEAR)

            local adversarySprite = adversary:GetSprite()
            adversarySprite:Play("Attack2Up", true)
            adversarySprite.PlaybackSpeed = 100

            local angulo = direction:GetAngleDegrees()
            angulo = mod:Takeclosest({0,90,180,-180,-90}, angulo)
            if angulo == 0 then
                adversary.I1 = 2
            elseif angulo == 90 then
                adversary.I1 = 3
            elseif angulo == 180 or angulo == -180 then
                adversary.I1 = 0
            elseif angulo == -90 then
                adversary.I1 = 1
            end

            mod:scheduleForUpdate(function()
                local laser2
                for _,l in ipairs(Isaac.FindByType(EntityType.ENTITY_LASER, LaserVariant.THICK_RED, 0)) do
                    if l.Parent.Type == EntityType.ENTITY_ADVERSARY then
                        laser2 = l
                        laser2.Parent = entity
                        laser2.SpawnerEntity = entity
                        laser2 = laser2:ToLaser()
                        break
                    end
                end

                if laser2 then
                    --laser2.Angle = direction:GetAngleDegrees()
                    --laser2.AngleDegrees = direction:GetAngleDegrees()
                    laser2.Position = entity.Position
                    laser2.ParentOffset = Vector.Zero
                    laser2:GetSprite().Color = mod.Colors.white
                    
                    entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
                end

                adversary:Remove()
                laser = laser2
            end,3)

        elseif secondaryP == mod.LSecondaryPassives.PARASITE then
            
            mod:scheduleForUpdate(function()
                --Need to get end of laser
                local position = laser:GetEndPoint()
                for i = 0, 1 do
                    local laser = EntityLaser.ShootAngle(laserVar, position , direction:GetAngleDegrees() + 90*(2*i-1), 15, Vector.Zero, entity)
                end
            end, 3)

        elseif secondaryP == mod.LSecondaryPassives.CONTINUUM then
            laser:AddTearFlags(TearFlags.TEAR_CONTINUUM)

            mod:scheduleForUpdate(function()
                --Need to get end of laser
                local endPos = laser:GetEndPoint()
                local vector = endPos - room:GetCenterPos()
                local position = room:GetCenterPos() - vector

                local laser2 = EntityLaser.ShootAngle(laserVar, position, direction:GetAngleDegrees(), 15, Vector.Zero, entity)
                laser2:AddTearFlags(TearFlags.TEAR_CONTINUUM)
                laser2.Size = laser2.Size/laserFrac

            end, 3)

        elseif secondaryP == mod.LSecondaryPassives.CLASSIC_WORM then --TODO
            
            --:(

        end

    --elseif data.MainP == mod.LMainPassive.EPIC_FETUS then
        --a
    elseif mainP == mod.LMainPassive.REVELATIONS then
        
        local direction = (data.TargetAim - entity.Position):Normalized()
        local laser = EntityLaser.ShootAngle(LaserVariant.LIGHT_BEAM, entity.Position, direction:GetAngleDegrees(), 15, Vector.Zero, entity):ToLaser()
        laser.Size = laser.Size/laserFrac

        if secondaryP == mod.LSecondaryPassives.IPECAC then

            laser:AddTearFlags(TearFlags.TEAR_EXPLOSIVE)
            laser:GetSprite().Color = mod.Colors.boom

            
            local laser2 = EntityLaser.ShootAngle(LaserVariant.THIN_RED, entity.Position, direction:GetAngleDegrees(), 15, Vector.Zero, entity):ToLaser()
            laser2.Visible = false
            laser2.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
            laser2:AddTearFlags(TearFlags.TEAR_EXPLOSIVE)

            mod:scheduleForUpdate(function()
                --Need to get end of laser
                local position = laser2:GetEndPoint()
                game:BombExplosionEffects (position, 100, TearFlags.TEAR_NORMAL, mod.Colors.boom, nil, 1*scale, true, false, DamageFlag.DAMAGE_EXPLOSION )
            end, 3)

        elseif secondaryP == mod.LSecondaryPassives._20_20 then

            laser:Remove()
            
            local pos2 = entity.Position - direction:Rotated(90)*mod.LConst._20_20_distance
            local laser2 = EntityLaser.ShootAngle(LaserVariant.LIGHT_BEAM, pos2, direction:GetAngleDegrees(), 15, Vector.Zero, entity)
            laser2.Size = laser2.Size/laserFrac
            
            local pos3 = entity.Position + direction:Rotated(90)*mod.LConst._20_20_distance
            local laser3 = EntityLaser.ShootAngle(LaserVariant.LIGHT_BEAM, pos3, direction:GetAngleDegrees(), 15, Vector.Zero, entity)
            laser3.Size = laser3.Size/laserFrac

        elseif secondaryP == mod.LSecondaryPassives.GOD_HEAD then

            laser:GetSprite().Color = mod.Colors.whiteish
            laser.Timeout = 45
            
            local laser2 = EntityLaser.ShootAngle(LaserVariant.LIGHT_BEAM, entity.Position + direction*80 , direction:GetAngleDegrees(), 45, Vector.Zero, entity)
            laser2.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
            laser2:GetSprite().Color = Color(1,1,1,0.5)
            mod:scheduleForUpdate(function()
                laser2.SpriteScale = 7*Vector.One
            end,5)

            laser2:GetData().LunaLaser = true
            laser2:GetData().LunaGodHead = true
            laser2:GetData().HeavensCall = true

        elseif secondaryP == mod.LSecondaryPassives.SACRED_HEART then

            entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

            laser:Remove()

            local adversary = Isaac.Spawn(EntityType.ENTITY_ADVERSARY, 0, 0, entity.Position, Vector.Zero, entity):ToNPC()
            adversary:GetData().HeavensCall = true
            adversary.Visible = false
            adversary.State = 8
            adversary.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

            adversary:AddEntityFlags(EntityFlag.FLAG_DONT_COUNT_BOSS_HP)
            adversary:ClearEntityFlags(EntityFlag.FLAG_APPEAR)

            local adversarySprite = adversary:GetSprite()
            adversarySprite:Play("Attack2Up", true)
            adversarySprite.PlaybackSpeed = 100

            local angulo = direction:GetAngleDegrees()
            angulo = mod:Takeclosest({0,90,180,-180,-90}, angulo)
            if angulo == 0 then
                adversary.I1 = 2
            elseif angulo == 90 then
                adversary.I1 = 3
            elseif angulo == 180 or angulo == -180 then
                adversary.I1 = 0
            elseif angulo == -90 then
                adversary.I1 = 1
            end

            mod:scheduleForUpdate(function()
                local laser2
                for _,l in ipairs(Isaac.FindByType(EntityType.ENTITY_LASER, LaserVariant.THICK_RED, 0)) do
                    if l.Parent.Type == EntityType.ENTITY_ADVERSARY then
                        laser2 = l
                        laser2.Parent = entity
                        laser2.SpawnerEntity = entity
                        laser2 = laser2:ToLaser()

                        --local laser2Sprite = laser2:GetSprite()
                        --laser2Sprite:Load("gfx/007.005_lightbeam.anm2", true)
                        --laser2Sprite:LoadGraphics()

                        sfx:Stop(SoundEffect.SOUND_BLOOD_LASER)
                        sfx:Play(SoundEffect.SOUND_ANGEL_BEAM)

                        break
                    end
                end

                if laser2 then
                    --laser2.Angle = direction:GetAngleDegrees()
                    --laser2.AngleDegrees = direction:GetAngleDegrees()
                    laser2.Position = entity.Position
                    laser2.ParentOffset = Vector.Zero
                    laser2:GetSprite().Color = mod.Colors.white

                    laser2:GetSprite():ReplaceSpritesheet(0, "gfx/effects/light_brimstone.png")
                    laser2:GetSprite():ReplaceSpritesheet(1, "gfx/effects/light_brimstone.png")
                    laser2:GetSprite():LoadGraphics()
                    
                    entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_ALL
                end

                adversary:Remove()
                laser = laser2
            end,3)

        elseif secondaryP == mod.LSecondaryPassives.PARASITE then
            
            local laser2 = EntityLaser.ShootAngle(LaserVariant.THIN_RED, entity.Position, direction:GetAngleDegrees(), 15, Vector.Zero, entity):ToLaser()
            laser2.Visible = false
            laser2.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
            laser2:AddTearFlags(TearFlags.TEAR_EXPLOSIVE)

            mod:scheduleForUpdate(function()
                --Need to get end of laser
                local position = laser:GetEndPoint()
                for i = 0, 1 do
                    local laser = EntityLaser.ShootAngle(LaserVariant.LIGHT_BEAM, position , direction:GetAngleDegrees() + 90*(2*i-1), 15, Vector.Zero, entity)
                end
            end, 3)

        elseif secondaryP == mod.LSecondaryPassives.CONTINUUM then
            laser:AddTearFlags(TearFlags.TEAR_CONTINUUM)

            local laser2 = EntityLaser.ShootAngle(LaserVariant.THIN_RED, entity.Position, direction:GetAngleDegrees(), 15, Vector.Zero, entity)
            laser2.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE
            laser2.Visible = false

            mod:scheduleForUpdate(function()
                --Need to get end of laser
                local endPos = laser2:GetEndPoint()
                local vector = endPos - room:GetCenterPos()
                local position = room:GetCenterPos() - vector*1.4

                local laser3 = EntityLaser.ShootAngle(LaserVariant.LIGHT_BEAM, position, direction:GetAngleDegrees(), 15, Vector.Zero, entity)
                laser3:AddTearFlags(TearFlags.TEAR_CONTINUUM)
                laser3.Size = laser3.Size/laserFrac

            end, 3)

        elseif secondaryP == mod.LSecondaryPassives.CLASSIC_WORM then --TODO
            --:(
        end
    elseif mainP == mod.LMainPassive.MUTANT_SPIDER or mainP == mod.LMainPassive.SPIDER_FREAK then

        local nTears = 4
        local spiderAngle = mod.LConst.spiderAngle
        if mainP == mod.LMainPassive.SPIDER_FREAK then 
            nTears = 6
            spiderAngle = mod.LConst.spiderFreakAngle
        end

        local tears = {}

        for i=1,nTears do
            local velocity = (target.Position - entity.Position):Normalized():Rotated((i-3)*spiderAngle - 5)*7

            local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, velocity, entity):ToProjectile()
            tear.Height = tear.Height - 25
            tears[i] = tear
            tear.Scale = scale
        end


        if secondaryP == mod.LSecondaryPassives.IPECAC then

            for i=1,nTears do
                local tear = tears[i]

                local vector = (tear.Velocity*25)*0.028

                tear.Velocity = vector*scale
                
                tear.Scale = 2*scale
                tear.FallingSpeed = -45;
                tear.FallingAccel = 1.5;

                tear:GetSprite().Color = mod.Colors.boom

                tear:AddProjectileFlags(ProjectileFlags.EXPLODE)
            end


        elseif secondaryP == mod.LSecondaryPassives._20_20 then

            for i=0,nTears+1,nTears+1 do
                local velocity = (target.Position - entity.Position):Normalized():Rotated((i-3)*spiderAngle - 5)*7

                local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, velocity, entity):ToProjectile()
                tear.Height = tear.Height - 25
                tears[i] = tear
                tear.Scale = scale
            end

        elseif secondaryP == mod.LSecondaryPassives.GOD_HEAD then

            for i=1,nTears do
                local tear = tears[i]

                tear.Scale = 1.5*scale
                tear.Velocity = tear.Velocity*0.8
                mod:TearFallAfter(tear, 300*scale)

                tear:GetSprite().Color = mod.Colors.whiteish


                local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 0, tear.Position, tear.Velocity, tear):ToEffect()
                aura.Parent = tear
                tear.Child = aura
                aura:GetSprite():Load("gfx/1000.123_Halo (Static Prerendered).anm2", true)
                aura:GetSprite():ReplaceSpritesheet(0, "gfx/effects/luna_god.png")
                aura:GetSprite():LoadGraphics()
                aura:GetSprite():Play("Idle", true)
                aura.SpriteScale = aura.SpriteScale*1.3
                aura:FollowParent(tear)
                tear:Update()

                tear:GetData().LunaProjectile = true
                tear:GetData().LunaGodHead = true
            end

        elseif secondaryP == mod.LSecondaryPassives.SACRED_HEART then

            for i=1,nTears do
                local tear = tears[i]

                tear.Scale = 1.75*scale
                tear:AddProjectileFlags(ProjectileFlags.SMART)
                tear.HomingStrength = tear.HomingStrength*0.9
                mod:TearFallAfter(tear, 300*scale)
                
                tear:GetData().LunaProjectile = true
                tear:GetData().LunaSacred = true

            end

        elseif secondaryP == mod.LSecondaryPassives.PARASITE then

            for i=1,nTears do
                local tear = tears[i]

                tear:GetData().LunaProjectile = true
                tear:GetData().LunaParasite = true

            end

        elseif secondaryP == mod.LSecondaryPassives.CONTINUUM then

            for i=1,nTears do
                local tear = tears[i]

                tear:AddProjectileFlags(ProjectileFlags.CONTINUUM)
                mod:TearFallAfter(tear, 30*2.5)

            end

        elseif secondaryP == mod.LSecondaryPassives.CLASSIC_WORM then

            for i=1,nTears do
                local tear = tears[i]

                tear.Velocity = tear.Velocity * 0.5

                tear:AddProjectileFlags(ProjectileFlags.MEGA_WIGGLE)
                tear:AddProjectileFlags(ProjectileFlags.NO_WALL_COLLIDE)
                tear.WiggleFrameOffset = 2000
                mod:TearFallAfter(tear, 30*5)
            end

        end
    elseif mainP == mod.LMainPassive.LIL_SLUGGER then

        local tear
        local saw
        local tears = {}

        local velocity = (target.Position - entity.Position):Normalized()*mod.LConst.sluggerSpeed
        saw, tear, tears = mod:SpawnSaw(entity, velocity, scale, tears)

        tear.Scale = scale

        local function AdjustSawScale(newScale)
            saw.Scale = newScale
            local n = math.floor(5*scale)

            for i=1, n do
                tears[i]:GetData().SawPosition = tears[i]:GetData().SawPosition/scale*newScale
            end
        end

        if secondaryP == mod.LSecondaryPassives.IPECAC then

            saw:GetSprite().Color = mod.Colors.boom
            tear:GetSprite().Color = mod.Colors.boom
            tear:AddProjectileFlags(ProjectileFlags.EXPLODE)
            tear:GetData().LunaSawIpecac = true

        elseif secondaryP == mod.LSecondaryPassives._20_20 then

            saw.Position = saw.Position + saw.Velocity:Normalized():Rotated(90)*mod.LConst._20_20_distance
            
            local saw2
            saw2, tear, tears = mod:SpawnSaw(entity, velocity, scale, tears)
            saw2.Position = saw2.Position + saw2.Velocity:Normalized():Rotated(-90)*mod.LConst._20_20_distance

        elseif secondaryP == mod.LSecondaryPassives.GOD_HEAD then

            AdjustSawScale(scale*1.5)
            saw.Velocity = saw.Velocity/3

            saw:GetSprite().Color = mod.Colors.whiteish


            local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 0, tear.Position, tear.Velocity, tear):ToEffect()
            aura.Parent = tear
            tear.Child = aura
            aura:GetSprite():Load("gfx/1000.123_Halo (Static Prerendered).anm2", true)
            aura:GetSprite():ReplaceSpritesheet(0, "gfx/effects/luna_god.png")
            aura:GetSprite():LoadGraphics()
            aura:GetSprite():Play("Idle", true)
            aura.SpriteScale = aura.SpriteScale*1.3
            aura:FollowParent(tear)
            tear:Update()

            tear:GetData().LunaProjectile = true
            tear:GetData().LunaGodHead = true

        elseif secondaryP == mod.LSecondaryPassives.SACRED_HEART then

            AdjustSawScale(scale*1.75)
            
            tear:AddProjectileFlags(ProjectileFlags.SMART)
            tear.HomingStrength = tear.HomingStrength*0.9
            
            tear:GetData().LunaSacredSaw = true
            tear.Velocity = velocity

        elseif secondaryP == mod.LSecondaryPassives.PARASITE then

            tear:GetData().LunaProjectile = true
            tear:GetData().LunaSawParasite = true

        elseif secondaryP == mod.LSecondaryPassives.CONTINUUM then

            saw:AddTearFlags(TearFlags.TEAR_CONTINUUM)

        elseif secondaryP == mod.LSecondaryPassives.CLASSIC_WORM then

            saw:AddTearFlags(TearFlags.TEAR_WIGGLE)
            saw:AddTearFlags(TearFlags.TEAR_SQUARE)
            --saw:AddTearFlags(TearFlags.TEAR_BIG_SPIRAL)
            --saw:AddTearFlags(TearFlags.TEAR_TURN_HORIZONTAL)

        end

    end
end
function mod:LunaMaw(entity, data, sprite, target, room)
    if data.MawTime >= mod.LConst.mawFrames then
        data.MawTime = 0
        sprite.Color = Color.Default
        sfx:Play(SoundEffect.SOUND_MAW_OF_VOID)

        local ring = Isaac.Spawn(EntityType.ENTITY_LASER, LaserVariant.THICK_RED, LaserSubType.LASER_SUBTYPE_RING_FOLLOW_PARENT, entity.Position, Vector.Zero, entity):ToLaser()
        ring.Parent = entity
        ring:GetSprite().Color = mod.Colors.black
        ring.Radius = 0
        ring.Shrink = true
        ring.DepthOffset = 500

        ring:GetData().HeavensCall = true
        ring:GetData().LunaMaw = true

    else
        data.MawTime = data.MawTime + 1

        sprite.Color = Color.Lerp(sprite.Color, mod.Colors.black, 0.01)

    end
end
function mod:LunaHeal(entity, amount)
    --Heal
    local healHeart = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, entity.Position + Vector(0,-100), Vector.Zero, entity)
    healHeart.DepthOffset = 200
    sfx:Play(SoundEffect.SOUND_VAMP_GULP,1)

    entity:AddHealth(amount)
end
function mod:SpawnSaw(entity, velocity, scale, tears)
    
    local saw = TaintedTreasure:FireSawblade(Isaac.GetPlayer(0), velocity, Color.Default, nil, entity.Position):ToTear()
    saw.Scale = scale
    saw.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

    local function SpawnSawHit(offset)
        local tear_ = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, Vector.Zero, entity):ToProjectile()
        tear_.Visible = false
        tear_.FallingSpeed = 0
        tear_.FallingAccel = -0.1
        tear_.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
        tear_:AddProjectileFlags(ProjectileFlags.NO_WALL_COLLIDE)

        tear_:GetData().HeavensCall = true
        tear_:GetData().LunaProjectile = true
        tear_:GetData().LunaSaw = true
        tear_:GetData().SawPosition = offset

        tear_.Parent = saw

        return tear_
    end

    local n = math.floor(5*scale)
    for i=0,n-1 do        
        local position =  Vector(scale*15, 0):Rotated(360/n*i)
        tears[i+1] = SpawnSawHit(position)
    end
    tear = SpawnSawHit(Vector.Zero)
    tear.EntityCollisionClass = EntityCollisionClass.ENTCOLL_NONE

    saw.TearFlags = TearFlags.TEAR_NORMAL

    return saw, tear, tears
end


--Move
function mod:LunaMove(entity, data, room, target)   

    local speed = mod.LConst.speed
    if data.AssistP == mod.LAssistPassives.MAGIC_MUSHROOM or data.AssistP == mod.LAssistPassives.STOPWATCH then
        speed = mod.LConst.superSpeed
    end
    
    --idle move taken from 'Alt Death' by hippocrunchy
	--idleTime == frames moving in the same direction
	if not data.idleTime then 
		data.idleTime = mod:RandomInt(mod.LConst.idleTimeInterval.X, mod.LConst.idleTimeInterval.Y)
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
    entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * speed
    data.targetvelocity = data.targetvelocity * 0.99
end

--Count bosses summones
function mod:LunaBossCount()
    local total = #Isaac.FindByType(EntityType.ENTITY_MONSTRO) + #Isaac.FindByType(EntityType.ENTITY_DUKE) + #Isaac.FindByType(EntityType.ENTITY_GEMINI) + #Isaac.FindByType(EntityType.ENTITY_LARRYJR)

    return total
end
--Pick item
function mod:LunaChooseItem(itemList, itemOld, dice)

    if dice then
        if itemOld == 0 then
            return 0
        end
    end

    local itemNum = mod:LunaPick(itemList, itemOld)

    local laser = itemNum == mod.LMainPassive.BRIMSTONE or itemNum == mod.LMainPassive.REVELATIONS

    local spider = false
    if TaintedTreasure then
        spider = itemNum == mod.LMainPassive.MUTANT_SPIDER or itemNum == mod.LMainPassive.SPIDER_FREAK
    end

    if (laser or spider) and rng:RandomFloat() < 0.5 then
        itemNum = mod:LunaPick(itemList, itemOld)
    end

    return itemNum
end
function mod:LunaPick(itemList, itemOld)
    local itemNum = mod:random_elem(itemList)
    while itemOld == itemNum do
        itemNum = mod:random_elem(itemList)
    end
    return itemNum
end

--Give item to luna
function mod:GiveItemLuna(entity, itemNum, tipo)
    local data = entity:GetData()

    if not tipo then
        tipo = data.LastItemType
    end

    --mod:LunaUseActive(entity, mod.LActives.BOOK_BELIAL)
    if tipo == mod.LItemType.ACTIVE then
        mod:LunaUseActive(entity, itemNum)
    elseif tipo == mod.LItemType.MAIN then
        data.MainP = itemNum
    elseif tipo == mod.LItemType.SECONDARY then
        data.SecondaryP = itemNum
    elseif tipo == mod.LItemType.ASSIST then

        --itemNum = mod.LAssistPassives.MAGIC_MUSHROOM

        for _,k in ipairs(mod:FindByTypeMod(mod.Entity.LunaKnife)) do
            k:Remove()
        end
        for _,i in ipairs(mod:FindByTypeMod(mod.Entity.LunaIncubus)) do
            i:Remove()
        end
        --data.MawTime = mod.LConst.mawFrames
        data.MawTime = 0
        data.HasMaw = false
        entity:GetSprite().Color = Color.Default

        data.AssistP = itemNum

        if itemNum == mod.LAssistPassives.MOMS_KNIFE then
            local knife = mod:SpawnEntity(mod.Entity.LunaKnife, entity.Position, Vector.Zero, entity)
            knife.Parent = entity
            knife.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY

        elseif itemNum == mod.LAssistPassives.INCUBUS then
            local incubus = mod:SpawnEntity(mod.Entity.LunaIncubus, entity.Position, Vector.Zero, entity)
            incubus.Parent = entity
            incubus.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
        elseif itemNum == mod.LAssistPassives.HOLY_MANTLE then
            data.HasMantle = true
        elseif itemNum == mod.LAssistPassives.MAW_VOID then
            data.HasMaw = true
        end
    else
        --SPECIAL
    end
    
end

function mod:LunaUseActive(entity, itemNum)
    local data = entity:GetData()

    if itemNum == mod.LActives.ABYSS then
        for i=1, mod.LConst.nLocust do
            local position = entity.Position + Vector(20,0):Rotated(i/mod.LConst.nLocust*360)
            local locust = Isaac.Spawn(EntityType.ENTITY_ATTACKFLY, 0, 0, position, Vector.Zero, entity)
            locust:GetSprite().Color = mod.Colors.red
            locust.MaxHitPoints = 100
            locust.HitPoints = 100
            locust:GetData().HeavensCall = true

            locust.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
        end

    elseif itemNum == mod.LActives.BOOK_VIRTUDES then
		sfx:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12)  
        
        for _,w in ipairs(mod:FindByTypeMod(mod.Entity.LunaWisp)) do
            w:Remove()
        end

        for i=1, mod.LConst.nWisps do
            local orbitDistance = 14
            local position = entity.Position + Vector(orbitDistance,0):Rotated(i/mod.LConst.nWisps*360)
            local wisp = mod:SpawnEntity(mod.Entity.LunaWisp, position, Vector.Zero, entity)
            wisp.Parent = entity
            
            local wispData = wisp:GetData()
            wispData.orbitIndex = i
            wispData.orbitTotal = mod.LConst.nWisps
            wispData.orbitDistance = orbitDistance
            wispData.orbitSpin = 1
            wispData.orbitSpeed = 4

            wispData.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
        end

    elseif itemNum == mod.LActives.BIBLE then
		sfx:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12)  
        local target = entity:ToNPC():GetPlayerTarget()

        local velocity = (target.Position - entity.Position):Normalized()*20
        local tear = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, entity.Position, velocity, entity):ToProjectile()
        local tearSprite = tear:GetSprite()

        mod:scheduleForUpdate(function()
            tearSprite:Load("gfx/effect_ICUP.anm2", true)
            tearSprite:ReplaceSpritesheet(2, "gfx/items/collectibles/collectibles_033_thebible.png")
            tearSprite:ReplaceSpritesheet(3, "gfx/items/collectibles/collectibles_033_thebible.png")
            tearSprite:Play("Bible", true)
            tearSprite:LoadGraphics()
        end,2)

    elseif itemNum == mod.LActives.BOOK_BELIAL then
		sfx:Play(SoundEffect.SOUND_DEVIL_CARD)
        data.StrengthTime = mod.LConst.belialFrames

    elseif itemNum == mod.LActives.BOOK_SHADOWS then
		sfx:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12)  
        data.ShieldTime = mod.LConst.shadowShieldFrames

    elseif itemNum == mod.LActives.ANARCHIST then
		sfx:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12)  
        for i=1,6 do
            mod:scheduleForUpdate(function()
                Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_TROLL, 0, game:GetRoom():GetRandomPosition(0), Vector.Zero, entity)
            end, i*5)
        end

    elseif itemNum == mod.LActives.BOOK_DEAD then
        
        for _,b in ipairs(Isaac.FindByType(EntityType.ENTITY_CLUTCH, 1)) do
            b:Remove()
        end

        for i=1, mod.LConst.nBones do
            local orbitDistance = 20
            local position = entity.Position + Vector(orbitDistance,0):Rotated(i/mod.LConst.nBones*360)
            local bone = Isaac.Spawn(EntityType.ENTITY_CLUTCH, 1, 0, position, Vector.Zero, entity):ToNPC()
            bone.Parent = entity

            local boneData = bone:GetData()
            boneData.orbitIndex = i
            boneData.orbitTotal = mod.LConst.nBones
            boneData.orbitDistance = orbitDistance
            boneData.orbitParent = true
            boneData.HeavensCall = true
            boneData.orbitSpin = -1
            boneData.orbitSpeed = 7

            bone.HitPoints = 60
            bone.CollisionDamage = 0

            bone.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYEROBJECTS
        end

    elseif itemNum == mod.LActives.HORSE_PASTE then
        mod:LunaHeal(entity, mod.LConst.healPerGlue)

    elseif itemNum == mod.LActives.FIEND_FOLIO then
		sfx:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12)  

        local randon = mod:RandomInt(1,3)

        local position = entity.Position + Vector(75, 0):Rotated(rng:RandomFloat()*360)
		for i=0, 100 do
			if (not mod:IsOutsideRoom(position, game:GetRoom())) then break end
			position = entity.Position + Vector(50, 0):Rotated(rng:RandomFloat()*360)
		end

        local boss 
        if random == 1 then
            boss = Isaac.Spawn(Isaac.GetEntityTypeByName("Monsoon"), Isaac.GetEntityVariantByName("Monsoon"), 0, position, Vector.Zero, entity)
        elseif random == 2 then
            boss = Isaac.Spawn(Isaac.GetEntityTypeByName("Battie"), Isaac.GetEntityVariantByName("Battie"), 0, position, Vector.Zero, entity)
        else
            boss = Isaac.Spawn(Isaac.GetEntityTypeByName("Buster"), Isaac.GetEntityVariantByName("Buster"), 0, position, Vector.Zero, entity)
        end

        boss.MaxHitPoints = 150
        boss.HitPoints = 150

    elseif itemNum == mod.LActives.BOOK_REVELATIONS then
		sfx:Play(SoundEffect.SOUND_BOOK_PAGE_TURN_12)
        local room = game:GetRoom()
        local margen = -900
        for i=0, 2 do
            local position = Vector(margen*i, room:GetCenterPos().Y + mod:RandomInt(-150,150))
            local horsemen = mod:SpawnEntity(mod.Entity.Horsemen, position, Vector.Zero, entity):ToNPC()
            horsemen.I1 = i
        end
        
        local position = Vector(margen*2, room:GetCenterPos().Y + mod:RandomInt(-50,50))
        for i=-1, 1, 2 do
            local horsemen = mod:SpawnEntity(mod.Entity.Horsemen, Vector(position.X, position.Y + 150*i), Vector.Zero, entity):ToNPC()
            horsemen.I1 = i/2 + 7/2
        end
    end
end

--Make tear fall after
function mod:TearFallAfter(projectile, frames)

    frames = math.floor(frames)

    projectile:AddProjectileFlags(ProjectileFlags.CHANGE_FLAGS_AFTER_TIMEOUT)
    projectile.ChangeFlags = ProjectileFlags.TRACTOR_BEAM
    projectile.ChangeTimeout = frames
    
    projectile.FallingSpeed = 0
    projectile.FallingAccel = -0.1

end

--Projectile collision effects
function mod:LunaProjectile(tear,collided)
    tear = tear:ToProjectile()
	local data = tear:GetData()
    local sprite = tear:GetSprite()
	
    if data.LunaSaw then
        if tear.Parent then
            if data.LunaSacredSaw then
                tear.Parent.Position = tear.Position
                if tear.FrameCount >= 50 or mod:IsOutsideRoom(tear.Position, game:GetRoom()) then
                    data.LunaSacredSaw = false
                    tear.Parent.Velocity = tear.Velocity

                    local dir, cc = TaintedTreasure:GetOrientationFromVector(tear.Parent.Velocity)
                    TaintedTreasure:WallStickerInit(tear.Parent:ToTear(), dir, cc, GridCollisionClass.COLLISION_PIT, 6, true)
                end
            else
                tear.Position = tear.Parent.Position + tear:GetData().SawPosition
                data.Velocity = tear.Parent.Velocity
            end

            if data.LunaSawIpecac and tear.FrameCount%5==0 then
                local gas = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SMOKE_CLOUD, 0, tear.Position, Vector.Zero, nil):ToEffect()
                gas.Timeout = mod.JConst.idleGasTime
                gas.SpriteScale = 0.75*Vector.One
            end

        else
            tear:Die()
        end
    end

    if data.LunaGodHead then
        mod:LunaGodHead(tear.Position, 80 * tear.SpriteScale.X/1.3)
    elseif data.LunaSacred then
        tear:GetSprite().Color = mod.Colors.white
    end

	--If tear collided then
	if tear:IsDead() or collided then
		
        --[[if data.LunaParasitoid then
            for i=1,3 do
                if rng:RandomFloat() < 0.5 then
                    local spider = Isaac.Spawn(EntityType.ENTITY_SPIDER, 0, 0, tear.Position. Vector.Zero, nil)
                else
                    local fly = Isaac.Spawn(EntityType.ENTITY_ATTACKFLY, 0, 0, tear.Position. Vector.Zero, nil)
                end
            end
        end]]

        if data.LunaParasite and not data.LunaBrust then
            for i=0,1 do
                local velocity = tear.Velocity:Rotated(90*(2*i-1))
                local tear2 = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, tear.Position, velocity, nil):ToProjectile()
                tear2.Scale = tear.Scale*mod.LConst.incubusScale^2
            end

        elseif data.LunaParasite and data.LunaBrust then
            for i=0,1 do
                local velocity = tear.Velocity:Rotated(90*(2*i-1))
                local variance = (Vector(mod:RandomInt(-15, 15),mod:RandomInt(-15, 15))*0.03)
                local vector = (velocity*20)*0.028 + variance
                
                local tear2 = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, tear.Position, vector, nil):ToProjectile();
                tear2.Scale = tear.Scale*mod.LConst.incubusScale*1.2
                tear2.FallingSpeed = -45;
                tear2.FallingAccel = 1.5;

                tear2:GetData().LunaBrust = true
                tear2:GetData().LunaProjectile = true
            end

        elseif data.LunaSawParasite and tear then
            for i=0,1 do
                local velocity = data.Velocity:Rotated(90*(2*i-1))
                saw2, tear2 = mod:SpawnSaw(tear, velocity, tear.Scale*mod.LConst.incubusScale, {})
            end
        end
        
        if data.LunaBrust then
            --Splash of projectiles:
            for i=0, mod.JConst.nCloudRingProjectiles do
                --Ring projectiles:
                local tear2 = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, tear.Position, Vector(10,0):Rotated(i*360/mod.JConst.nCloudRingProjectiles)/2, tear):ToProjectile()
                tear2.Scale = tear.Scale*mod.LConst.incubusScale^2
                tear2.FallingSpeed = -0.1
                tear2.FallingAccel = 0.35 + rng:RandomFloat()*0.15
                tear2:GetSprite().Color = tear:GetSprite().Color

                if data.LunaGodHead then
                    local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 0, tear2.Position, tear2.Velocity, tear2):ToEffect()
                    aura.Parent = tear2
                    tear2.Child = aura
                    aura:GetSprite():Load("gfx/1000.123_Halo (Static Prerendered).anm2", true)
                    aura:GetSprite():ReplaceSpritesheet(0, "gfx/effects/luna_god.png")
                    aura:GetSprite():LoadGraphics()
                    aura:GetSprite():Play("Idle", true)
                    aura.SpriteScale = aura.SpriteScale*0.5
                    aura:FollowParent(tear2)
                    tear2:Update()
    
                    tear2:GetData().LunaProjectile = true
                    tear2:GetData().LunaGodHead = true
                elseif data.LunaIpecac then
                    tear2:AddProjectileFlags(ProjectileFlags.EXPLODE)
                elseif data.LunaContinnum then
                    tear2:AddProjectileFlags(ProjectileFlags.CONTINUUM)
                end
            end
            for i=0, mod.JConst.nCloudRndProjectiles do
                --Random projectiles:
                local angle = mod:RandomInt(0, 360)
                local tear2 = Isaac.Spawn(EntityType.ENTITY_PROJECTILE, ProjectileVariant.PROJECTILE_NORMAL, 0, tear.Position, Vector(7,0):Rotated(angle)/2, tear.Parent):ToProjectile()
                tear2.Scale = tear.Scale*mod.LConst.incubusScale^2
                local randomFall = - rng:RandomFloat()*0.5
                tear2.FallingSpeed = randomFall
                tear2.FallingAccel = 0.3 + rng:RandomFloat()*0.1
                tear2:GetSprite().Color = tear:GetSprite().Color

                if data.LunaGodHead then
                    local aura = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HALO, 0, tear2.Position, tear2.Velocity, tear2):ToEffect()
                    aura.Parent = tear2
                    tear2.Child = aura
                    aura:GetSprite():Load("gfx/1000.123_Halo (Static Prerendered).anm2", true)
                    aura:GetSprite():ReplaceSpritesheet(0, "gfx/effects/luna_god.png")
                    aura:GetSprite():LoadGraphics()
                    aura:GetSprite():Play("Idle", true)
                    aura.SpriteScale = aura.SpriteScale*0.5
                    aura:FollowParent(tear2)
                    tear2:Update()
    
                    tear2:GetData().LunaProjectile = true
                    tear2:GetData().LunaGodHead = true
                elseif data.LunaIpecac then
                    tear2:AddProjectileFlags(ProjectileFlags.EXPLODE)
                elseif data.LunaContinnum then
                    tear2:AddProjectileFlags(ProjectileFlags.CONTINUUM)
                end
            end
        end


		tear:Die()
	end
end

function mod:LunaBombs(bomb)
    local data = bomb:GetData()

    if data.LunaGodHead then
        mod:LunaGodHead(bomb.Position)
    elseif data.LunaSacred and bomb.Parent then
        bomb.Velocity = (bomb.Parent:ToNPC():GetPlayerTarget().Position - bomb.Position):Normalized()*4
    elseif data.LunaWorm then
        bomb.Velocity = bomb.Velocity/20 + bomb.Velocity:Rotated(math.sin(bomb.FrameCount)*20)*1.001
    end

    if bomb:GetSprite():IsPlaying("Explode") then
        if data.LunaIpecac then
            local gas = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.SMOKE_CLOUD, 0, bomb.Position, Vector.Zero, nil):ToEffect()
            gas.Timeout = mod.JConst.chargeGasTime
        elseif data.LunaParasite then
            for i=0,1 do
                local vector = bomb.Velocity:Normalized():Rotated(90*(2*i-1))*10
                local bomb2 = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_SMALL, 0, bomb.Position+5*vector, Vector.Zero, entity):ToBomb()
                bomb2:SetExplosionCountdown(10)
            end
        end
    end
end

function mod:LunaRings(ring)

    local data = ring:GetData()
    local sprite = ring:GetSprite()

    if data.LunaGodHead then
        mod:LunaGodHead(ring.Position)
    elseif data.LunaSacred then
        if ring.FrameCount < 30*3 and ring.Parent then
            ring.Velocity = (ring.Parent:ToNPC():GetPlayerTarget().Position - ring.Position):Normalized()*4
        end
    elseif data.LunaIpecac then
        if sprite:IsPlaying("Laser0Fade") and sprite:GetFrame()==1 then
            game:BombExplosionEffects (ring.Position, 100, TearFlags.TEAR_NORMAL, mod.Colors.boom, nil, 1, true, false, DamageFlag.DAMAGE_EXPLOSION )
        end
    elseif data.LunaParasite then
        if sprite:IsPlaying("Laser0Fade") and sprite:GetFrame()==1 then
            for i=0,1 do
                local velocity = ring.Velocity:Rotated(90*(2*i-1))
                local ring2 = Isaac.Spawn(EntityType.ENTITY_LASER, LaserVariant.THIN_RED, 2, ring.Position, velocity, nil):ToLaser()
                ring2.Parent = ring.Parent
                ring2.Radius = mod.LConst.xTechSize*0.75
                ring2.DepthOffset = 500
            end
        end
    end
end

function mod:LunaLasers(laser)
    local data = laser:GetData()

    if data.LunaGodHead then
        local position = laser:GetEndPoint()
        for i=0,20 do
            local point = (position-laser.Position):Normalized()*laser.LaserLength/20*i
            mod:LunaGodHead(point+laser.Position, 80, 2)
        end
    end
    
end

function mod:LunaGodHead(point, dist, suma)
    if not dist then dist = 80 end
    if not suma then suma = 3 end

    for i=0, game:GetNumPlayers ()-1 do
        local player = game:GetPlayer(i)
        local playerData = player:GetData()

        if player.Position:Distance(point) < dist then
            if playerData.GodheadTime then
                playerData.GodheadTime = playerData.GodheadTime + suma

                player:GetSprite().Color = Color.Lerp(player:GetSprite().Color, mod.Colors.white, 0.075)
            else
                playerData.GodheadTime = 1
            end

            if playerData.GodheadTime > 25 then
                playerData.GodheadTime = 0

                local light = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, player.Position, Vector.Zero, nil)
            end
        end
    end
end

--Callbacks
--Luna updates
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.LunaUpdate, mod.EntityInf[mod.Entity.Luna].ID)

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, entity, amount, flags, source, frames)
	if entity.Type == mod.EntityInf[mod.Entity.Luna].ID and entity.Variant == mod.EntityInf[mod.Entity.Luna].VAR then
        local data = entity:GetData()
        local sprite = entity:GetSprite()

        if flags & DamageFlag.DAMAGE_EXPLOSION == DamageFlag.DAMAGE_EXPLOSION and source.Type == EntityType.ENTITY_BOMB and source.Entity and source.Entity.SpawnerEntity and source.Entity.SpawnerEntity.Type == mod.EntityInf[mod.Entity.Luna].ID  then
            entity:TakeDamage(math.floor(amount/10), flags - DamageFlag.DAMAGE_EXPLOSION, source, frames)
            return false

        elseif data.AssistP == mod.LAssistPassives.WAFER and (flags & DamageFlag.DAMAGE_INVINCIBLE == 0) then
            entity:TakeDamage(math.floor(amount/2), flags | DamageFlag.DAMAGE_INVINCIBLE, source, frames)
            return false

        elseif data.AssistP == mod.LAssistPassives.BOWL_TEARS and rng:RandomFloat() < mod.LConst.bowlChance then
            local light = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.CRACK_THE_SKY, 0, game:GetRoom():GetRandomPosition(0), Vector.Zero, nil)
            light:GetSprite().PlaybackSpeed = 0.35
        end

        if data.ShieldTime and data.ShieldTime <= 0 then

            if data.HasMantle then
                local mantle = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, 11, entity.Position, Vector.Zero, entity)
                mantle.DepthOffset =400
                mantle.SpriteScale = 1.5*Vector.One
                data.HasMantle = false
                return false
            end

            --Sleeping
            data.SleepShield = data.SleepShield - amount
            if sprite:IsPlaying("Sleeping") and data.SleepShield <= 0 then
                data.SleepShield = 0
                sprite:Play("SleepEnd", true)
            end

        elseif data.ShieldTime then

            return false
        end
	end
end)

mod:AddCallback(ModCallbacks.MC_PRE_PROJECTILE_COLLISION, function(_, tear, collider)
	if tear:GetData().LunaProjectile and collider.Type == EntityType.ENTITY_PLAYER then
		mod:LunaProjectile(tear,true)
	end
end)
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, function(_, tear)
	if tear:GetData().LunaProjectile then
		mod:LunaProjectile(tear,false)
	end
end)

mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, function(_, bomb)
    if bomb:GetData().LunaBomb then
        mod:LunaBombs(bomb)
    end
     
end, BombVariant.BOMB_NORMAL)

mod:AddCallback(ModCallbacks.MC_POST_LASER_UPDATE, function(_, laser)
    local data = laser:GetData()
    if data.HeavensCall then
        if data.LunaRing then
            mod:LunaRings(laser)
        elseif data.LunaLaser then
            mod:LunaLasers(laser)
        elseif data.LunaMaw then
            mod:LunaMawUpdate(laser)
        end
    end
end)

