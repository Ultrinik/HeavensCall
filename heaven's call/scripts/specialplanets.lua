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
    SPECIAL = 14
}
mod.LItemDoors = {
    TREASURE = 0,
    ANGEL = 2,
    DEVIL = 3,
    SECRET = 4,
    LIBRARY = 5,
    SHOP = 6,
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
    CLASSIC_WORM = 32,
}

mod.LItemDoor = {
    [mod.LActives.ABYSS] = mod.LItemDoors.DEVIL,
    [mod.LActives.BOOK_VIRTUDES] = mod.LItemDoors.LIBRARY,
    [mod.LActives.BIBLE] = mod.LItemDoors.LIBRARY,
    [mod.LActives.BOOK_BELIAL] = mod.LItemDoors.LIBRARY,
    [mod.LActives.BOOK_SHADOWS] = mod.LItemDoors.LIBRARY,
    [mod.LActives.ANARCHIST] = mod.LItemDoors.LIBRARY,
    [mod.LActives.BOOK_DEAD] = mod.LItemDoors.LIBRARY,
    
    [mod.LSpecials.FLIP] = mod.LItemDoors.DEVIL,
    [mod.LSpecials.MEGA_MUSH] = mod.LItemDoors.SECRET,
    [mod.LSpecials.MOMS_SHOVEL] = mod.LItemDoors.SECRET,
    
    [mod.LAssistPassives.INCUBUS] = mod.LItemDoors.DEVIL,
    [mod.LAssistPassives.MOMS_KNIFE] = mod.LItemDoors.DEVIL,
    [mod.LAssistPassives.HOLY_MANTLE] = mod.LItemDoors.ANGEL,
    [mod.LAssistPassives.WAFER] = mod.LItemDoors.ANGEL,
    [mod.LAssistPassives.MAGIC_MUSHROOM] = mod.LItemDoors.TREASURE,
    [mod.LAssistPassives.POLYPHEMUS] = mod.LItemDoors.TREASURE,
    [mod.LAssistPassives.MAW_VOID] = mod.LItemDoors.DEVIL,
    [mod.LAssistPassives.PARASITOID] = mod.LItemDoors.TREASURE,
    [mod.LAssistPassives.BOWL_TEARS] = mod.LItemDoors.TREASURE,
    [mod.LAssistPassives.STOPWATCH] = mod.LItemDoors.SHOP,
    
    [mod.LMainPassive.C_SECTION] = mod.LItemDoors.TREASURE,
    [mod.LMainPassive.DR_FETUS] = mod.LItemDoors.TREASURE,
    [mod.LMainPassive.TECH_X] = mod.LItemDoors.TREASURE,
    [mod.LMainPassive.HEMOLACRYA] = mod.LItemDoors.TREASURE,
    [mod.LMainPassive.BRIMSTONE] = mod.LItemDoors.DEVIL,
    [mod.LMainPassive.EPIC_FETUS] = mod.LItemDoors.SECRET,
    [mod.LMainPassive.REVELATIONS] = mod.LItemDoors.ANGEL,
    
    [mod.LSecondaryPassives.IPECAC] = mod.LItemDoors.TREASURE,
    [mod.LSecondaryPassives._20_20] = mod.LItemDoors.TREASURE,
    [mod.LSecondaryPassives.GOD_HEAD] = mod.LItemDoors.ANGEL,
    [mod.LSecondaryPassives.SACRED_HEART] = mod.LItemDoors.ANGEL,
    [mod.LSecondaryPassives.PARASITE] = mod.LItemDoors.TREASURE,
    [mod.LSecondaryPassives.CONTINUUM] = mod.LItemDoors.TREASURE,
    [mod.LSecondaryPassives.CLASSIC_WORM] = mod.LItemDoors.TREASURE,
}

if TaintedTreasure then
    mod.LSpecials.LIL_SLUGGER = 33
    mod.LAssistPassives.BUGULON = 34
    mod.LMainPassive.SPIDER_FREAK = 35

    mod.LItemDoors.TAINTED_TREASURE = 7


    mod.LItemDoor[mod.LSpecials.LIL_SLUGGER] = mod.LItemDoors.TAINTED_TREASURE
    mod.LItemDoor[mod.LAssistPassives.BUGULON] = mod.LItemDoors.TAINTED_TREASURE
    mod.LItemDoor[mod.LMainPassive.SPIDER_FREAK] = mod.LItemDoors.TAINTED_TREASURE
end
if FiendFolio then
    mod.LActives.FIEND_FOLIO = 36
    mod.LActives.HORSE_PASTE = 37
    
    mod.LItemDoor[mod.LActives.FIEND_FOLIO] = mod.LItemDoors.LIBRARY
    mod.LItemDoor[mod.LActives.HORSE_PASTE] = mod.LItemDoors.SHOP
end
if Althorsemen then
    mod.LActives.BOOK_REVELATIONS = 38
    
    mod.LItemDoor[mod.LActives.BOOK_REVELATIONS] = mod.LItemDoors.LIBRARY
end

mod.chainL = {                    --Appear  Idle   Attack Charge Telep  Item   Boss   MegaS  Curse  Arcad  Bed    Dice   Plan   Vault  Special
    [mod.LMSState.APPEAR] =         {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.IDLE] =           {0.000, 0.200, 0.210, 0.020, 0.050, 0.250, 0.030, 0.030, 0.030, 0.030, 0.030, 0.030, 0.030, 0.030, 0.030},
    [mod.LMSState.ATTACK] =         {0.000, 0.350, 0.350, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.100, 0.100, 0.100, 0.000, 0.000, 0.000},
    [mod.LMSState.CHARGE] =         {0.000, 0.400, 0.400, 0.000, 0.200, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.TELEPORT] =       {0.000, 0.400, 0.200, 0.000, 0.000, 0.400, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.ITEM] =           {0.000, 0.000, 0.500, 0.000, 0.000, 0.400, 0.000, 0.000, 0.000, 0.000, 0.000, 0.100, 0.000, 0.000, 0.000},
    [mod.LMSState.BOSSROOM] =       {0.000, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.300, 0.000, 0.400, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.MEGASATAN] =      {0.000, 0.100, 0.000, 0.000, 0.000, 0.300, 0.000, 0.000, 0.300, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.CURSE] =          {0.000, 0.750, 0.250, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.ARCADE] =         {0.000, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.300, 0.000, 0.300, 0.100},
    [mod.LMSState.BEDROOM] =        {0.000, 0.700, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.DICE] =           {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.PLANETARIUM] =    {0.000, 0.300, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.300, 0.000, 0.400, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.VAULT] =          {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000},
    [mod.LMSState.SPECIAL] =        {0.000, 1.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000, 0.000}
    
}
mod.LConst = {--Some constant variables of Luna
    idleTimeInterval = Vector(15,20),
    speed = 1.45,

}