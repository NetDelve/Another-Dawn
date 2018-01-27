item = {}
item.list={}

--item.stats
--item.id = nil
--item.name = nil
--item.image = nil
--item.itemtype = nil
--item.stackable = false

function item.newItem(_id, _name, _sprite, _itemtype, _stackable)
table.insert(item.list, {id=_id, name=_name, sprite=_sprite, itemtype=_itemtype, stackable =_stackable})
end

return item
