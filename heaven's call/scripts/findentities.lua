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
    Bubble = 51,
    Leaf = 58,
    
    ---------

    MarsGigaBomb = 46,
    MarsRocket = 47,
    MarsGigaRocket = 48,

}
mod.DefaultSub = 160
mod.DefaultEntitySub = 0

--BOSSES-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.Statue] = {ID = Isaac.GetEntityTypeByName("Astral Statue"), VAR = Isaac.GetEntityVariantByName("Astral Statue"), SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Jupiter] = {ID = Isaac.GetEntityTypeByName("Jupiter the Gargantuan"), VAR = Isaac.GetEntityVariantByName("Jupiter the Gargantuan"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Saturn] = {ID = Isaac.GetEntityTypeByName("Saturn the Intransigent"),  VAR = Isaac.GetEntityVariantByName("Saturn the Intransigent"),   SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Uranus] = {ID = Isaac.GetEntityTypeByName("Uranus the Unpleasant"),  VAR = Isaac.GetEntityVariantByName("Uranus the Unpleasant"),   SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Neptune] = {ID = Isaac.GetEntityTypeByName("Neptune the Unfathomable"), VAR = Isaac.GetEntityVariantByName("Neptune the Unfathomable"),  SUB = mod.DefaultEntitySub}

mod.EntityInf[mod.Entity.Mercury] =  {ID = Isaac.GetEntityTypeByName("Mercury the Unwary"), VAR = Isaac.GetEntityVariantByName("Mercury the Unwary"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Venus] =  {ID = Isaac.GetEntityTypeByName("Venus the Termagant"), VAR = Isaac.GetEntityVariantByName("Venus the Termagant"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Terra1] =  {ID = Isaac.GetEntityTypeByName("Terra the Fatalist (green)"), VAR = Isaac.GetEntityVariantByName("Terra the Fatalist (green)"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Terra2] =  {ID = Isaac.GetEntityTypeByName("Terra the Fatalist (rock)"), VAR = Isaac.GetEntityVariantByName("Terra the Fatalist (rock)"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Terra3] =  {ID = Isaac.GetEntityTypeByName("Terra the Fatalist (eden)"), VAR = Isaac.GetEntityVariantByName("Terra the Fatalist (eden)"), SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Mars] =  {ID = Isaac.GetEntityTypeByName("Mars the Vainglorious"), VAR = Isaac.GetEntityVariantByName("Mars the Vainglorious"), SUB = mod.DefaultEntitySub}

--ENEMIES-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.IETDDATD] = {ID = Isaac.GetEntityTypeByName("Invisible entity that does damage and then dies"), VAR = Isaac.GetEntityVariantByName("Invisible entity that does damage and then dies"), SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Hyperion] = {ID = EntityType.ENTITY_SUB_HORF, VAR = 1, SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.IceTurd] = {ID = Isaac.GetEntityTypeByName("Ice Turd (HC)"), VAR = Isaac.GetEntityVariantByName("Ice Turd (HC)"), SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.NeptuneFaker] = {ID = Isaac.GetEntityTypeByName("Neptune Faker (HC)"), VAR = Isaac.GetEntityVariantByName("Neptune Faker (HC)"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.MercuryBird] = {ID = Isaac.GetEntityTypeByName("Mercury Bird (HC)"), VAR = Isaac.GetEntityVariantByName("Mercury Bird (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Wagon] = {ID = Isaac.GetEntityTypeByName("Wagon (HC)"), VAR = Isaac.GetEntityVariantByName("Wagon (HC)"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Ulcers] = {ID = Isaac.GetEntityTypeByName("Ulcers"), VAR = Isaac.GetEntityVariantByName("Ulcers"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Candle] = {ID = Isaac.GetEntityTypeByName("Candle"), VAR = Isaac.GetEntityVariantByName("Candle"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.CandleGurdy] = {ID = Isaac.GetEntityTypeByName("Candle Gurdy"), VAR = Isaac.GetEntityVariantByName("Candle Gurdy"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.CandleSiren] = {ID = Isaac.GetEntityTypeByName("Candle Siren"), VAR = Isaac.GetEntityVariantByName("Candle Siren"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.SirenRag] = {ID = Isaac.GetEntityTypeByName("Siren Rag (HC)"), VAR = Isaac.GetEntityVariantByName("Siren Rag (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.CandleColostomia] = {ID = Isaac.GetEntityTypeByName("Candle Colostomia"), VAR = Isaac.GetEntityVariantByName("Candle Colostomia"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.CandleMist] = {ID = Isaac.GetEntityTypeByName("Candle Maid in the Mist"), VAR = Isaac.GetEntityVariantByName("Candle Maid in the Mist"),  SUB = mod.DefaultEntitySub}

mod.EntityInf[mod.Entity.Deimos] = {ID = Isaac.GetEntityTypeByName("Deimos the Tarnished"), VAR = Isaac.GetEntityVariantByName("Deimos the Tarnished"),  SUB = mod.DefaultEntitySub}
mod.EntityInf[mod.Entity.Phobos] = {ID = Isaac.GetEntityTypeByName("Phobos the Tarnished"), VAR = Isaac.GetEntityVariantByName("Phobos the Tarnished"),  SUB = mod.DefaultEntitySub}

--EFFECTS-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.Aurora] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Aurora (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Thunder] = {ID = EntityType.ENTITY_EFFECT, VAR = EffectVariant.CRACK_THE_SKY,  SUB = 5}

mod.EntityInf[mod.Entity.TimeFreezeSource] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Timestuck Source (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.TimeFreezeObjective] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Timestuck Objective (HC)"),  SUB = mod.DefaultSub+1}

mod.EntityInf[mod.Entity.Snowflake] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Snowflake (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.IceCreep] = {ID = EntityType.ENTITY_EFFECT, VAR = EffectVariant.CREEP_SLIPPERY_BROWN,  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Tornado] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Tornado (HC)"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.MarsTarget] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Mars Target (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.MarsAirstrike] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Mars Airstrike (HC)"),  SUB = mod.DefaultSub+1}

mod.EntityInf[mod.Entity.RedTrapdoor] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Red Trapdoor (HC)"),  SUB = mod.DefaultSub}

--PROJECTILES-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.KeyKnife] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Key Knife (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.KeyKnifeRed] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Key Knife Special (HC)"),  SUB = mod.DefaultSub+1}

mod.EntityInf[mod.Entity.Icicle] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Icicle (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.BigIcicle] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Big Icicle (HC)"),  SUB = mod.DefaultSub+1}
mod.EntityInf[mod.Entity.Hail] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Hail (HC)"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Horn] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Horn (HC)"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Bubble] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Bubble (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Leaf] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Leaf (HC)"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Flame] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Flame (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Fireball] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Fireball (HC)"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Kiss] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Kiss (HC)"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Missile] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Missile (HC)"),  SUB = mod.DefaultSub}

--OTHERS-------------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.MarsGigaBomb] = {ID = EntityType.ENTITY_BOMB, VAR = BombVariant.BOMB_NORMAL,  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.MarsRocket] = {ID = EntityType.ENTITY_BOMB, VAR = BombVariant.BOMB_ROCKET,  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.MarsGigaRocket] = {ID = EntityType.ENTITY_BOMB, VAR = BombVariant.BOMB_ROCKET,  SUB = mod.DefaultSub+1}
