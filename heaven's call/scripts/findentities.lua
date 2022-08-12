local mod = HeavensCall

mod.EntityInf = {}
mod.Entity ={
    Statue = 0,

    Jupiter = 1,
    Saturn = 2,
    Uranus = 3,
    Neptune = 4,

    Mercury = 5,
    Venus = 6,
    Terra1 = 7,
    Terra2 = 56,
    Terra3 = 57,
    Mars = 8,

    Luna = 9,
    Pluto = 10,
    Charon = 11,
    Eris = 12,
    Makemake = 13,
    Haumea = 14,

    Sol = 15,

    ---------

    IETDDATD = 16,
    Hyperion = 17,
    IceTurd = 18,
    NeptuneFaker = 19,
    Ulcers = 36,
    Candle = 37,
    CandleGurdy = 38,
    CandleSiren = 39,
    SirenRag = 40,
    CandleColostomia = 41,
    CandleMist = 42,
    Deimos = 49,
    Phobos = 50,
    MercuryBird = 54,

    ---------

    TimeFreezeSource = 20,
    TimeFreezeObjective = 21,
    Snowflake = 22,
    Tornado = 23,
    RedTrapdoor = 24,
    Thunder = 25,
    IceCreep = 26,
    Aurora = 27,
    MarsTarget = 43,
    MarsAirstrike = 44,
    Wagon = 53,

    ---------
    
    KeyKnife = 28,
    KeyKnifeRed = 29,
    Icicle = 30,
    BigIcicle = 31,
    Hail = 32,
    Flame = 33,
    Fireball = 34,
    Kiss = 35,
    Missile = 45,
    Horn = 55,
    
    ---------

    MarsGigaBomb = 46,
    MarsRocket = 47,
    MarsGigaRocket = 48,
    LaserWarning = 51,

}
mod.DefaultSub = 160
mod.DefaultEntitySub = 0

--BOSSES-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.Statue] = {ID = Isaac.GetEntityTypeByName("Astral Statue"), VAR = Isaac.GetEntityVariantByName("Astral Statue"), SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Jupiter] = {ID = Isaac.GetEntityTypeByName("Jupiter"), VAR = Isaac.GetEntityVariantByName("Jupiter"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Saturn] = {ID = Isaac.GetEntityTypeByName("Saturn"),  VAR = Isaac.GetEntityVariantByName("Saturn"),   SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Uranus] = {ID = Isaac.GetEntityTypeByName("Uranus"),  VAR = Isaac.GetEntityVariantByName("Uranus"),   SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Neptune] = {ID = Isaac.GetEntityTypeByName("Neptune"), VAR = Isaac.GetEntityVariantByName("Neptune"),  SUB = mod.DefaultEntitySub}

mod.EntityInf[mod.Entity.Mercury] =  {ID = Isaac.GetEntityTypeByName("Mercury"), VAR = Isaac.GetEntityVariantByName("Mercury"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Venus] =  {ID = Isaac.GetEntityTypeByName("Venus"), VAR = Isaac.GetEntityVariantByName("Venus"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Terra1] =  {ID = Isaac.GetEntityTypeByName("Terra (green)"), VAR = Isaac.GetEntityVariantByName("Terra (green)"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Terra2] =  {ID = Isaac.GetEntityTypeByName("Terra (gray)"), VAR = Isaac.GetEntityVariantByName("Terra (gray)"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Terra3] =  {ID = Isaac.GetEntityTypeByName("Terra (eden)"), VAR = Isaac.GetEntityVariantByName("Terra (eden)"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Mars] =  {ID = Isaac.GetEntityTypeByName("Mars"), VAR = Isaac.GetEntityVariantByName("Mars"), SUB = mod.DefaultEntitySub}

--ENEMIES-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.IETDDATD] = {ID = Isaac.GetEntityTypeByName("Invisible entity that does damage and then dies"), VAR = Isaac.GetEntityVariantByName("Invisible entity that does damage and then dies"), SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Hyperion] = {ID = EntityType.ENTITY_SUB_HORF, VAR = 1, SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.IceTurd] = {ID = Isaac.GetEntityTypeByName("Ice Turd"), VAR = Isaac.GetEntityVariantByName("Ice Turd"), SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.NeptuneFaker] = {ID = Isaac.GetEntityTypeByName("NeptuneFaker"), VAR = Isaac.GetEntityVariantByName("NeptuneFaker"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.MercuryBird] = {ID = Isaac.GetEntityTypeByName("Mercury Bird"), VAR = Isaac.GetEntityVariantByName("Mercury Bird"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Wagon] = {ID = Isaac.GetEntityTypeByName("Wagon"), VAR = Isaac.GetEntityVariantByName("Wagon"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Ulcers] = {ID = Isaac.GetEntityTypeByName("Ulcers"), VAR = Isaac.GetEntityVariantByName("Ulcers"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Candle] = {ID = Isaac.GetEntityTypeByName("Candle"), VAR = Isaac.GetEntityVariantByName("Candle"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.CandleGurdy] = {ID = Isaac.GetEntityTypeByName("Candle Gurdy"), VAR = Isaac.GetEntityVariantByName("Candle Gurdy"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.CandleSiren] = {ID = Isaac.GetEntityTypeByName("Candle Siren"), VAR = Isaac.GetEntityVariantByName("Candle Siren"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.SirenRag] = {ID = Isaac.GetEntityTypeByName("Siren Rag"), VAR = Isaac.GetEntityVariantByName("Siren Rag"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.CandleColostomia] = {ID = Isaac.GetEntityTypeByName("Candle Colostomia"), VAR = Isaac.GetEntityVariantByName("Candle Colostomia"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.CandleMist] = {ID = Isaac.GetEntityTypeByName("Candle Maid in the Mist"), VAR = Isaac.GetEntityVariantByName("Candle Maid in the Mist"),  SUB = mod.DefaultEntitySub}

mod.EntityInf[mod.Entity.Deimos] = {ID = Isaac.GetEntityTypeByName("Deimos"), VAR = Isaac.GetEntityVariantByName("Deimos"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Phobos] = {ID = Isaac.GetEntityTypeByName("Phobos"), VAR = Isaac.GetEntityVariantByName("Phobos"),  SUB = mod.DefaultEntitySub}

--EFFECTS-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.Aurora] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Aurora"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Thunder] = {ID = EntityType.ENTITY_EFFECT, VAR = EffectVariant.CRACK_THE_SKY,  SUB = 5}

mod.EntityInf[mod.Entity.TimeFreezeSource] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Timestuck Source"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.TimeFreezeObjective] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Timestuck Objective"),  SUB = mod.DefaultSub+1}

mod.EntityInf[mod.Entity.Snowflake] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Snowflake"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.IceCreep] = {ID = EntityType.ENTITY_EFFECT, VAR = EffectVariant.CREEP_SLIPPERY_BROWN,  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Tornado] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Tornado"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.MarsTarget] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Mars Target"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.MarsAirstrike] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Mars Airstrike"),  SUB = mod.DefaultSub+1}

mod.EntityInf[mod.Entity.RedTrapdoor] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Red Trapdoor"),  SUB = mod.DefaultSub}

--PROJECTILES-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.KeyKnife] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Key Knife"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.KeyKnifeRed] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Key Knife Special"),  SUB = mod.DefaultSub+1}

mod.EntityInf[mod.Entity.Icicle] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Icicle"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.BigIcicle] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Big Icicle"),  SUB = mod.DefaultSub+1}
mod.EntityInf[mod.Entity.Hail] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Hail"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Horn] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Horn"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Flame] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Flame"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Fireball] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Fireball"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Kiss] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Kiss"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Missile] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Missile"),  SUB = mod.DefaultSub}

--OTHERS-------------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.MarsGigaBomb] = {ID = EntityType.ENTITY_BOMB, VAR = BombVariant.BOMB_NORMAL,  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.MarsRocket] = {ID = EntityType.ENTITY_BOMB, VAR = BombVariant.BOMB_ROCKET,  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.MarsGigaRocket] = {ID = EntityType.ENTITY_BOMB, VAR = BombVariant.BOMB_ROCKET,  SUB = mod.DefaultSub+1}
mod.EntityInf[mod.Entity.LaserWarning] = {ID = EntityType.ENTITY_LASER, VAR = Isaac.GetEntityVariantByName("Laser Warning"),  SUB = 0}--This is useless, I could use the regular tech laser
