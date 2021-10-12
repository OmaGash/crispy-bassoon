
# Characters

## Class summary
### States
The character class' finite state machine currently involves the following states:
1. `IDLE` - For when the character is not moving.
2. `MOVE` - For when the character is moving.
3. `ATTACK` - For when the character is attacking.
4. `DAMAGE` - For when the character receives damage.
5. `ABNORMAL` - For when the character is stunned, slowed, etc.
6. `INTERACT` - For Players only, when they interact with NPCs and events.
7. `ALERT` - For NPC's only, when they go vigilante against the player.

Also, currently includes two factions:
1. `PLAYER` - The player itself.
2.  `ENEMY` - Anything that can bring harm to the player.
### Properties
All characters have the following properties:
- `_gravity` - This will define how heavy the character will be.
- `_jump_force` - Jump force (pun intended).
- `_speed` - Character's flat movement speed.
- `_max_hp`, `current_hp` - The character's max HP, we will have a 1 damage to all attacks with some exceptions.

## Folder Structure

- Each of the characters should have their own dedicated folder.

- The base class  for all characters will be `character.gd`, which includes all the basic properties for an in-game character (gravity, speed, etc.)

## What to include

- Everything that characters depend on, including meshes, sprites, and audio files.

- They need to be in their own folders, respectively.

- For non-engine related files like external application save files (e.g. Blender and Krita save files), add them to a `.external` folder.

## Examples

`/character/player/player.tscn` will be the directory of the Player's scene.

`/character/player/audio/oof.ogg` for audio files

`/character/player/sprites/portrait.png` for images.