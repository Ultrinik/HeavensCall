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

--TOTAL ITEMS = 39
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
    PARASITOID = 17,
    BOWL_TEARS = 18, --COMMUNITY REMIX
    STOPWATCH = 39,
}
mod.LMainPassive = {
    C_SECTION = 19,
    DR_FETUS = 20,
    TECH_X = 21,
    HEMOLACRYA = 22,
    BRIMSTONE = 23,
    EPIC_FETUS = 24,
    REVELATIONS = 25,
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
    [mod.LAssistPassives.PARASITOID] = mod.DoorType.TREASURE,
    [mod.LAssistPassives.BOWL_TEARS] = mod.DoorType.TREASURE,
    [mod.LAssistPassives.STOPWATCH] = mod.DoorType.SHOP,
    
    [mod.LMainPassive.C_SECTION] = mod.DoorType.TREASURE,
    [mod.LMainPassive.DR_FETUS] = mod.DoorType.TREASURE,
    [mod.LMainPassive.TECH_X] = mod.DoorType.TREASURE,
    [mod.LMainPassive.HEMOLACRYA] = mod.DoorType.TREASURE,
    [mod.LMainPassive.BRIMSTONE] = mod.DoorType.DEVIL,
    [mod.LMainPassive.EPIC_FETUS] = mod.DoorType.SECRET,
    [mod.LMainPassive.REVELATIONS] = mod.DoorType.ANGEL,
    
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
    [mod.LAssistPassives.PARASITOID] = "gfx/items/collectibles/collectibles_461_parasitoid.png",
    [mod.LAssistPassives.BOWL_TEARS] = "gfx/items/collectibles/collectibles_109_bowloftears.png",--REMIX
    [mod.LAssistPassives.STOPWATCH] = "gfx/items/collectibles/collectibles_232_stopwatch.png",
    
    [mod.LMainPassive.C_SECTION] = "gfx/items/collectibles/collectibles_678_csection.png",
    [mod.LMainPassive.DR_FETUS] = "gfx/items/collectibles/collectibles_052_drfetus.png",
    [mod.LMainPassive.TECH_X] = "gfx/items/collectibles/collectibles_395_techx.png",
    [mod.LMainPassive.HEMOLACRYA] = "gfx/items/collectibles/collectibles_531_haemolacria.png",
    [mod.LMainPassive.BRIMSTONE] = "gfx/items/collectibles/collectibles_118_brimstone.png",
    [mod.LMainPassive.EPIC_FETUS] = "gfx/items/collectibles/collectibles_168_epicfetus.png",
    [mod.LMainPassive.REVELATIONS] = "gfx/items/collectibles/collectibles_643_revelation.png",
    
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
    mod.LSpecials.LIL_SLUGGER = 33
    mod.LAssistPassives.BUGULON = 34
    mod.LMainPassive.SPIDER_FREAK = 35

    mod.LItemDoor[mod.LSpecials.LIL_SLUGGER] = mod.DoorType.TAINTED
    mod.LItemPath[mod.LSpecials.LIL_SLUGGER] = "gfx/items/collectibles"
    mod.LItemDoor[mod.LAssistPassives.BUGULON] = mod.DoorType.TAINTED
    mod.LItemPath[mod.LAssistPassives.BUGULON] = "gfx/items/collectibles"
    mod.LItemDoor[mod.LMainPassive.SPIDER_FREAK] = mod.DoorType.TAINTED
    mod.LItemPath[mod.LMainPassive.SPIDER_FREAK] = "gfx/items/collectibles"
end
if FiendFolio then
    mod.LActives.FIEND_FOLIO = 36
    mod.LActives.HORSE_PASTE = 37
    
    mod.LItemDoor[mod.LActives.FIEND_FOLIO] = mod.DoorType.LIBRARY
    mod.LItemPath[mod.LActives.FIEND_FOLIO] = "gfx/items/collectibles"
    mod.LItemDoor[mod.LActives.HORSE_PASTE] = mod.DoorType.SHOP
    mod.LItemPath[mod.LActives.HORSE_PASTE] = "gfx/items/collectibles"
end
if Althorsemen then
    mod.LActives.BOOK_REVELATIONS = 38
    
    mod.LItemDoor[mod.LActives.BOOK_REVELATIONS] = mod.DoorType.LIBRARY
    mod.LItemPath[mod.LActives.BOOK_REVELATIONS] = "gfx/items/collectibles/collectibles_078_bookofrevelations.png"
end

mod.chainL = {                    --Appear  Idle   Attack Charge Telep  Item   Boss   MegaS  Curse  Arcad  Bed    Dice   Plan   Vault  Speci  Sacrfice
    [mod.LMSState.APPEAR] =         {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    --[mod.LMSState.IDLE] =           {0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 1.000},
    [mod.LMSState.IDLE] =           {0.000, 0.200, 0.210, 0.020, 0.050, 0.250, 0.030, 0.030, 0.030, 0.030, 0.000, 0.030, 0.030, 0.030, 0.030, 0.030},
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

    dashSpeed = 60,

    hpSS = 0.075,

    minDistanceToReappear = 120,

    curseSpeed = 20,

    sleepShield = 80,
    healPerSleep = 10,

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

            data.SleepShield = 0
        end
        
        --print(data.State)

        --Frame
        data.StateFrame = data.StateFrame + 1
        
        if not data.SSFlag and entity.HitPoints < entity.MaxHitPoints * mod.LConst.hpSS and data.State == mod.LMSState.IDLE then
            data.SSFlag = true
            data.StateFrame = 0

            data.MainP = 0
            data.SecondaryP = 0
            data.AssistP = 0
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


    end
end
function mod:LunaAttack(entity, data, sprite, target,room)
    if data.StateFrame == 1 then
        sprite:Play("NormalAttack",true)
    elseif sprite:IsFinished("NormalAttack") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0

    elseif sprite:IsEventTriggered("Attack") then

    end

end
function mod:LunaCharge(entity, data, sprite, target,room)
    if data.StateFrame == 1 then

        if (entity.Position.X - target.Position.X) < 0 then
            sprite:Play("DashR",true)
            data.Direcion = 1
        else
            sprite:Play("DashL",true)
            data.Direcion = -1
        end

        local position = Vector(data.Direcion*500, entity.Position.Y)
        for i=data.Direcion*500, 0, -70*data.Direcion do
            position = Vector(i, entity.Position.Y)
            if (not mod:IsOutsideRoom(position, room)) then 
                position = Vector(i - 70*data.Direcion, entity.Position.Y)
                break 
            end
        end

        local door = mod:SpawnLunaDoor(entity, mod.DoorType.NORMAL, position)

    elseif sprite:IsFinished("DashR") or sprite:IsFinished("DashL") or sprite:IsFinished("TrapdoorOut") then
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
            itemNum = mod:random_elem(mod.LMainPassive)
        elseif random <= 6 then
            itemType = mod.LItemType.SECONDARY
            itemNum = mod:random_elem(mod.LSecondaryPassives)
        elseif random <= 8 then
            itemType = mod.LItemType.ASSIST
            itemNum = mod:random_elem(mod.LAssistPassives)
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

    end

end
function mod:LunaCurse(entity, data, sprite, target,room)
    entity.Velocity = Vector.Zero

    if data.StateFrame == 1 then
        sprite:Play("SummonDoor",true)
    elseif sprite:IsFinished("Snap") then
        data.State = mod:MarkovTransition(data.State, mod.chainL)
        data.StateFrame = 0
    elseif sprite:IsFinished("SummonDoor") then
        sprite:Play("Snap",true)

        local door = mod:SpawnLunaDoor(entity, mod.DoorType.CURSE, entity.Position + Vector(0,20))
        
    elseif sprite:IsEventTriggered("Snap") then
        entity.Child.Velocity = (target.Position - entity.Position):Normalized() * mod.LConst.curseSpeed
    end

    if entity.Child and entity.Child.Velocity:Length()<mod.LConst.curseSpeed then
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
        local healHeart = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, entity.Position + Vector(0,-100), Vector.Zero, entity)
        healHeart.DepthOffset = 200
        sfx:Play(SoundEffect.SOUND_VAMP_GULP,1)

        entity:AddHealth(mod.LConst.healPerSleep)

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


--Move
function mod:LunaMove(entity, data, room, target)   
    if speed == nil then speed = 1 end
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
    entity.Velocity = ((data.targetvelocity * 0.3) + (entity.Velocity * 0.7)) * mod.LConst.speed
    data.targetvelocity = data.targetvelocity * 0.99
end

--Count bosses summones
function mod:LunaBossCount()
    local total = #Isaac.FindByType(EntityType.ENTITY_MONSTRO) + #Isaac.FindByType(EntityType.ENTITY_DUKE) + #Isaac.FindByType(EntityType.ENTITY_GEMINI) + #Isaac.FindByType(EntityType.ENTITY_LARRYJR)

    return total
end

--Give item to luna
function mod:GiveItemLuna(entity, itemNum)
    local data = entity:GetData()

    if data.LastItemType == mod.LItemType.ACTIVE then

    elseif data.LastItemType == mod.LItemType.MAIN then

    elseif data.LastItemType == mod.LItemType.SECONDARY then

    elseif data.LastItemType == mod.LItemType.ASSIST then

    else
        --SPECIAL
    end
end

--Callbacks
--Luna updates
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.LunaUpdate, mod.EntityInf[mod.Entity.Luna].ID)

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, function(_, entity, amount, flags, source, frames)
	if entity.Type == mod.EntityInf[mod.Entity.Luna].ID then
        local data = entity:GetData()
        local sprite = entity:GetSprite()

        data.SleepShield = data.SleepShield - amount
		if sprite:IsPlaying("Sleeping") and data.SleepShield <= 0 then
			data.SleepShield = 0
            sprite:Play("SleepEnd", true)
		end
	end
end)