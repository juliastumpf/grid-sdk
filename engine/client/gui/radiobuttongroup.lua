--=========== Copyright © 2016, Planimeter, All rights reserved. =============--
--
-- Purpose: Radio Button Group class
--
--============================================================================--

module( "gui.radiobuttongroup", package.class, package.inherit "gui.panel" )

function radiobuttongroup:radiobuttongroup( parent, name )
	gui.panel.panel( self, parent, name )
	self.selectedId = 0
	self.disabled   = false

	self:setSuppressFramebufferWarnings( true )
end

function radiobuttongroup:addItem( item )
	self.items =  self.items or {}
	item.id    = #self.items + 1
	table.insert( self.items, item )
	item.group = self
end

function radiobuttongroup:removeItem( item )
	local items = self:getItems()
	for i, v in ipairs( items ) do
		if ( v == item ) then
			table.remove( items, i )
			if ( self.selectedId == i ) then
				self.selectedId = 0
			end
			self:invalidateLayout()
		end
	end
end

accessor( radiobuttongroup, "items" )
accessor( radiobuttongroup, "selectedId" )

function radiobuttongroup:getSelectedItem()
	local items = self:getItems()
	if ( items ) then
		return items[ self:getSelectedId() ]
	end
end

function radiobuttongroup:getValue()
	local item = self:getSelectedItem()
	if ( item ) then
		return item:getValue()
	end
end

function radiobuttongroup:isDisabled()
	return self.disabled
end

function radiobuttongroup:setDisabled( disabled )
	self.disabled = disabled
end

function radiobuttongroup:setSelectedId( selectedId, default )
	local oldSelectedId = self:getSelectedId()
	local items         = self:getItems()
	local oldSelection  = items[ oldSelectedId ]
	local newSelection  = items[ selectedId ]
	if ( oldSelection and oldSelectedId ~= selectedId ) then
		oldSelection:setSelected( false )
		newSelection:setSelected( true )
		self.selectedId = selectedId
		self:onValueChanged( oldSelection:getValue(), newSelection:getValue() )
	else
		newSelection:setSelected( true )
		self.selectedId = selectedId
		if ( not default ) then
			self:onValueChanged( nil, newSelection:getValue() )
		end
	end
end

function radiobuttongroup:onValueChanged( oldValue, newValue )
end


