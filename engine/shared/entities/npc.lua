--=========== Copyright © 2016, Planimeter, All rights reserved. =============--
--
-- Purpose: NPC class
--
--============================================================================--

require( "engine.shared.entities.character" )

module( "npc", package.class, package.inherit( "character" ) )

function npc:npc()
	character.character( self )

	self:networkNumber( "moveSpeed", 0.5 )

	if ( _CLIENT ) then
		require( "engine.client.sprite" )
		local sprite = sprite( "images.player" )
		self:setSprite( sprite )
	end
end

function npc:spawn()
	entity.spawn( self )

	local tileSize = game.tileSize
	local min      = vector()
	local max      = vector( tileSize, -tileSize )
	self:initializePhysics( "dynamic" )
	self:setCollisionBounds( min, max )

	game.call( "shared", "onNPCSpawn", self )
end

function npc:__tostring()
	return "npc: " .. self:getName()
end
