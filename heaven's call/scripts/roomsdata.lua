--This was taken from Tainted Treasure mod.
--It appears to be a collection of rooms configurations (and that maximum thing)
--A really tedious thing to do
--To whoever made this, You are strong, I'm proud of you kid

local mod = HeavensCall

mod.maxvariant1 = 8503
mod.minvariant1 = 8500

mod.maxvariant2 = 8508
mod.minvariant2 = 8505

-- ROOM GEN
mod.adjindexes = {
	[RoomShape.ROOMSHAPE_1x1] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13, 
		[DoorSlot.RIGHT0] = 1, 
		[DoorSlot.DOWN0] = 13
	},
	[RoomShape.ROOMSHAPE_IH] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.RIGHT0] = 1
	},
	[RoomShape.ROOMSHAPE_IV] = {
		[DoorSlot.UP0] = -13, 
		[DoorSlot.DOWN0] = 13
	},
	[RoomShape.ROOMSHAPE_1x2] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13, 
		[DoorSlot.RIGHT0] = 1, 
		[DoorSlot.DOWN0] = 26,
		[DoorSlot.LEFT1] = 12, 
		[DoorSlot.RIGHT1] = 14
	},
	[RoomShape.ROOMSHAPE_IIV] = {
		[DoorSlot.UP0] = -13, 
		[DoorSlot.DOWN0] = 26
	},
	[RoomShape.ROOMSHAPE_2x1] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13, 
		[DoorSlot.RIGHT0] = 2,
		[DoorSlot.DOWN0] = 13,
		[DoorSlot.UP1] = -12,
		[DoorSlot.DOWN1] = 14
	},
	[RoomShape.ROOMSHAPE_IIH] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.RIGHT0] = 3
	},
	[RoomShape.ROOMSHAPE_2x2] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13,
		[DoorSlot.RIGHT0] = 2,
		[DoorSlot.DOWN0] = 26,
		[DoorSlot.LEFT1] = 12,
		[DoorSlot.UP1] = -12, 
		[DoorSlot.RIGHT1] = 15, 
		[DoorSlot.DOWN1] = 27
	},
	[RoomShape.ROOMSHAPE_LTL] = {
		[DoorSlot.LEFT0] = -1,
		[DoorSlot.UP0] = -1,
		[DoorSlot.RIGHT0] = 1, 
		[DoorSlot.DOWN0] = 25,
		[DoorSlot.LEFT1] = 11, 
		[DoorSlot.UP1] = -13, 
		[DoorSlot.RIGHT1] = 14, 
		[DoorSlot.DOWN1] = 26
	},
	[RoomShape.ROOMSHAPE_LTR] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13, 
		[DoorSlot.RIGHT0] = 1,
		[DoorSlot.DOWN0] = 26,
		[DoorSlot.LEFT1] = 12, 
		[DoorSlot.UP1] = 1,
		[DoorSlot.RIGHT1] = 15, 
		[DoorSlot.DOWN1] = 27
	},
	[RoomShape.ROOMSHAPE_LBL] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13,
		[DoorSlot.RIGHT0] = 2,
		[DoorSlot.DOWN0] = 13,
		[DoorSlot.LEFT1] = 13,
		[DoorSlot.UP1] = -12, 
		[DoorSlot.RIGHT1] = 15, 
		[DoorSlot.DOWN1] = 27
	},
	[RoomShape.ROOMSHAPE_LBR] = {
		[DoorSlot.LEFT0] = -1, 
		[DoorSlot.UP0] = -13,
		[DoorSlot.RIGHT0] = 2,
		[DoorSlot.DOWN0] = 26,
		[DoorSlot.LEFT1] = 12,
		[DoorSlot.UP1] = -12,
		[DoorSlot.RIGHT1] = 14,
		[DoorSlot.DOWN1] = 14
	}
}

mod.borderrooms = {
	[DoorSlot.LEFT0] = {0, 13, 26, 39, 52, 65, 78, 91, 104, 117, 130, 143, 156},
	[DoorSlot.UP0] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	[DoorSlot.RIGHT0] = {12, 25, 38, 51, 64, 77, 90, 103, 116, 129, 142, 155, 168},
	[DoorSlot.DOWN0] = {156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168},
	[DoorSlot.LEFT1] = {0, 13, 26, 39, 52, 65, 78, 91, 104, 117, 130, 143, 156},
	[DoorSlot.UP1] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12},
	[DoorSlot.RIGHT1] = {12, 25, 38, 51, 64, 77, 90, 103, 116, 129, 142, 155, 168},
	[DoorSlot.DOWN1] = {156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168}
}

mod.oppslots = {
	[DoorSlot.LEFT0] = DoorSlot.RIGHT0, 
	[DoorSlot.UP0] = DoorSlot.DOWN0, 
	[DoorSlot.RIGHT0] = DoorSlot.LEFT0, 
	[DoorSlot.LEFT1] = DoorSlot.RIGHT0, 
	[DoorSlot.DOWN0] = DoorSlot.UP0, 
	[DoorSlot.UP1] = DoorSlot.DOWN0, 
	[DoorSlot.RIGHT1] = DoorSlot.LEFT0, 
	[DoorSlot.DOWN1] = DoorSlot.UP0
}
-- END OF ROOM GEN 