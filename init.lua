local TRUDGE_THRESHOLD = 20 -- steps before changing the node

local function track_trudge(player)
    local pos = vector.round(player:get_pos())
    pos.y = pos.y - 1  -- node under player

    local node = minetest.get_node(pos)
    local def = minetest.registered_nodes[node.name]

    if not def or minetest.get_item_group(node.name, "soil") == 0 then
        return
    end

    -- track trudge count on the node itself
    local meta = minetest.get_meta(pos)
    local count = meta:get_int("trudge_count") + 1
    meta:set_int("trudge_count", count)

    if count >= TRUDGE_THRESHOLD then
        minetest.set_node(pos, {name = "default:dirt"})
        pos.y = pos.y + 1
        if minetest.registered_nodes[minetest.get_node(pos).name].buildable_to then
            minetest.remove_node(pos)
        end
        meta:set_int("trudge_count", 0) -- reset counter
    end
end

minetest.register_globalstep(function()
    for _, player in ipairs(minetest.get_connected_players()) do
        local vel = player:get_velocity()
        if math.abs(vel.x) > 0.1 or math.abs(vel.z) > 0.1 then
            track_trudge(player)
        end
    end
end)
