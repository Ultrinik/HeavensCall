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
    Terra = 7,
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

    ---------

    TimeFreezeSource = 20,
    TimeFreezeObjective = 21,
    Snowflake = 22,
    Tornado = 23,
    RedTrapdoor = 24,
    Thunder = 25,
    IceCreep = 26,
    Aurora = 27,

    ---------
    
    KeyKnife = 28,
    KeyKnifeRed = 29,
    Icicle = 30,
    BigIcicle = 31,
    Hail = 32,

}
mod.DefaultSub = 160

--BOSSES-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.Statue] = {ID = Isaac.GetEntityTypeByName("Astral Statue"), VAR = Isaac.GetEntityVariantByName("Astral Statue"), SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Jupiter] = {ID = Isaac.GetEntityTypeByName("Jupiter"), VAR = Isaac.GetEntityVariantByName("Jupiter"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Saturn] = {ID = Isaac.GetEntityTypeByName("Saturn"),  VAR = Isaac.GetEntityVariantByName("Saturn"),   SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Uranus] = {ID = Isaac.GetEntityTypeByName("Uranus"),  VAR = Isaac.GetEntityVariantByName("Uranus"),   SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Neptune] = {ID = Isaac.GetEntityTypeByName("Neptune"), VAR = Isaac.GetEntityVariantByName("Neptune"),  SUB = mod.DefaultSub}

mod.EntityInf[mod.Entity.Venus] =  {ID = Isaac.GetEntityTypeByName("Venus"), VAR = Isaac.GetEntityVariantByName("Venus"), SUB = mod.DefaultSub}

--ENEMIES-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.IETDDATD] = {ID = Isaac.GetEntityTypeByName("Invisible entity that does damage and then dies"), VAR = Isaac.GetEntityVariantByName("Invisible entity that does damage and then dies"), SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Hyperion] = {ID = EntityType.ENTITY_SUB_HORF, VAR = 1, SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.IceTurd] = {ID = Isaac.GetEntityTypeByName("Ice Turd"), VAR = Isaac.GetEntityVariantByName("Ice Turd"), SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.NeptuneFaker] = {ID = Isaac.GetEntityTypeByName("NeptuneFaker"), VAR = Isaac.GetEntityVariantByName("NeptuneFaker"),  SUB = mod.DefaultSub}

--EFFECTS-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.TimeFreezeSource] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Timestuck Source"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.TimeFreezeObjective] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Timestuck Objective"),  SUB = mod.DefaultSub+1}
mod.EntityInf[mod.Entity.Snowflake] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Snowflake"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Tornado] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Tornado"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.RedTrapdoor] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Red Trapdoor"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Thunder] = {ID = EntityType.ENTITY_EFFECT, VAR = EffectVariant.CRACK_THE_SKY,  SUB = 5}
mod.EntityInf[mod.Entity.IceCreep] = {ID = EntityType.ENTITY_EFFECT, VAR = EffectVariant.CREEP_SLIPPERY_BROWN,  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.Aurora] = {ID = EntityType.ENTITY_EFFECT, VAR = Isaac.GetEntityVariantByName("Aurora"),  SUB = mod.DefaultSub}

--PROJECTILES-----------------------------------------------------------------------------------------------

mod.EntityInf[mod.Entity.KeyKnife] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Key Knife"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.KeyKnifeRed] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Key Knife Special"),  SUB = mod.DefaultSub+1}
mod.EntityInf[mod.Entity.Icicle] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Icicle"),  SUB = mod.DefaultSub}
mod.EntityInf[mod.Entity.BigIcicle] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Big Icicle"),  SUB = mod.DefaultSub+1}
mod.EntityInf[mod.Entity.Hail] = {ID = EntityType.ENTITY_PROJECTILE, VAR = Isaac.GetEntityVariantByName("Hail"),  SUB = mod.DefaultSub}