local function applyTransmogToPlayerItems(player)
  local playerInv = player:getInventory()
  local wornItems = player: getWornItems()

  local tmogItemsToRemove = {}
  for i = 0, wornItems:size() - 1 do
    local wornItem = wornItems:getItemByIndex(i);
    if wornItem and TransmogDE.isTransmogItem(wornItem) then
      table.insert(tmogItemsToRemove, wornItem)
    end
  end
  
  for _, wornItem in ipairs(tmogItemsToRemove) do
    wornItems:remove(wornItem)
    playerInv:Remove(wornItem);
  end

  local wornItems = wornItems
  for i = 0, wornItems:size() - 1 do
    local item = wornItems:getItemByIndex(i);
    if item and TransmogDE.isTransmoggable(item) then
      TransmogDE.giveTransmogItemToPlayer(item)
    end
  end
  
  TransmogDE.giveHideClothingItemToPlayer()

  player:resetModel();
  sendClothing(player);

  TmogPrint('applyTransmogToPlayerItems!')
end

Events.OnClothingUpdated.Add(applyTransmogToPlayerItems);