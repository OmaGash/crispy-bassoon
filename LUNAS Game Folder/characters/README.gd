# Characters
## Folder Structure
- Each characters should have their own dedicated folder.
- The base class for all characters will be `character.gd`, which includes all the basic properties for an in-game character (gravity, speed, etc.)
## What to include
- Everything that characters depend on, including meshes, sprites, and audio files.
	- They need to be in their own folders respectively.
- For non-engine related files like external application save files (e.g.Blender and Krita save files), add them to a `.external` folder.
## Examples
`/character/player/player.tscn` will be the directory of the Player's scene.
`/character/player/audio/oof.ogg` for audio files
`/character/player/sprites/portrait.png` for images.