TeamRelationshipType = {
	["Friendly"] = 1,
	["Hostile"] = 2
}
TeamRelationships = {
	[TeamId.None] = {
		[TeamId.None] = TeamRelationshipType.Hostile,
		[TeamId.President] = TeamRelationshipType.Hostile,
		[TeamId.Vice] = TeamRelationshipType.Hostile,
		[TeamId.Bodyguard] = TeamRelationshipType.Hostile,
		[TeamId.Terrorist] = TeamRelationshipType.Hostile,
		[TeamId.Civil] = TeamRelationshipType.Hostile
	},
	[TeamId.President] = {
		[TeamId.None] = TeamRelationshipType.Hostile,
		[TeamId.President] = TeamRelationshipType.Friendly,
		[TeamId.Vice] = TeamRelationshipType.Friendly,
		[TeamId.Bodyguard] = TeamRelationshipType.Friendly,
		[TeamId.Terrorist] = TeamRelationshipType.Hostile,
		[TeamId.Civil] = TeamRelationshipType.Hostile
	},
	[TeamId.Vice] = {
		[TeamId.None] = TeamRelationshipType.Hostile,
		[TeamId.President] = TeamRelationshipType.Friendly,
		[TeamId.Vice] = TeamRelationshipType.Friendly,
		[TeamId.Bodyguard] = TeamRelationshipType.Friendly,
		[TeamId.Terrorist] = TeamRelationshipType.Hostile,
		[TeamId.Civil] = TeamRelationshipType.Hostile
	},
	[TeamId.Bodyguard] = {
		[TeamId.None] = TeamRelationshipType.Hostile,
		[TeamId.President] = TeamRelationshipType.Friendly,
		[TeamId.Vice] = TeamRelationshipType.Friendly,
		[TeamId.Bodyguard] = TeamRelationshipType.Friendly,
		[TeamId.Terrorist] = TeamRelationshipType.Hostile,
		[TeamId.Civil] = TeamRelationshipType.Hostile
	},
	[TeamId.Terrorist] = {
		[TeamId.None] = TeamRelationshipType.Hostile,
		[TeamId.President] = TeamRelationshipType.Hostile,
		[TeamId.Vice] = TeamRelationshipType.Hostile,
		[TeamId.Bodyguard] = TeamRelationshipType.Hostile,
		[TeamId.Terrorist] = TeamRelationshipType.Friendly,
		[TeamId.Civil] = TeamRelationshipType.Hostile
	},
	[TeamId.Civil] = {
		[TeamId.None] = TeamRelationshipType.Hostile,
		[TeamId.President] = TeamRelationshipType.Hostile,
		[TeamId.Vice] = TeamRelationshipType.Hostile,
		[TeamId.Bodyguard] = TeamRelationshipType.Hostile,
		[TeamId.Terrorist] = TeamRelationshipType.Hostile,
		[TeamId.Civil] = TeamRelationshipType.Hostile
	}
}