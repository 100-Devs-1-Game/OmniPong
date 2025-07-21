# Campaign

This is for the campaign part of the game, not the normal classic pong 

Signals can be found in the `global/event_bus`

## To Add A New Level
- Add the scene to the `levels/` folder (or anywhere else, if there's a better location for it)
- Create a LevelData Resource and place it within the `data/` folder
  - Assign all the fields as needed, e.g the path to the level scene file
  - Modify an existing LevelData Resource's `next_level` so your new level will be loaded after that one is beaten
