local register_on_player_walk = luanti_utils.dofile('register_on_player_walk.lua')

local TRUDGE_THRESHOLD = 2 -- steps before changing the node

local function track_trudge(pos, _prev_pos, _player)
    pos = vector.add(pos, {x=0, y=-0.1, z=0})

    local node = core.get_node(pos)
    local def = core.registered_nodes[node.name]

    if not def or core.get_item_group(node.name, "soil") == 0 then
        return
    end

    -- track trudge count on the node itself
    local meta = core.get_meta(pos)
    local count = meta:get_int("trudge_count") + 1

    if count >= TRUDGE_THRESHOLD then
        core.set_node(pos, {name = "default:dirt"})
        pos.y = pos.y + 1
        if core.registered_nodes[core.get_node(pos).name].buildable_to then
            core.remove_node(pos)
        end

        return
    end

    meta:set_int("trudge_count", count)
end

register_on_player_walk(track_trudge)
