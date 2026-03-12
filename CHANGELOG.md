# Changelog

## 0.0.2

- Added `.luacheckrc` allowing `core`, `luanti_utils`, and `vector` globals.
- Added `.cdb.json` metadata for ContentDB packaging.
- Switched player movement detection to `register_on_player_walk` from `luanti_utils` instead of a `globalstep` loop.
- Renamed `LICENSE` to `LICENSE.txt`.
- Prevented unnecessary metadata reset when the trudge threshold is reached.
- Corrected node removal logic when the resulting node is `buildable_to`.
