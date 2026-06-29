# Open World — Research Notes

## Goal
Build an Android APK for an online, third-person open-world cultivation RPG called **Open World**.

## Core pillars
- Third-person camera
- Open world exploration
- Online multiplayer
- Character development
- Inventory
- Cultivation system for gathering qi and breaking through realms
- Body system for physical training and body quality growth

## Research findings

### Game structure
- RPG design centers on **player actions, progression, and narrative**.
- The most important early decision is the **core gameplay rule set**; world, lore, and UI should support it.
- Third-person action RPGs commonly combine fast combat, traversal, hidden areas, puzzles, loot, and progression trees.
- For level design, combat spaces work best when they have a clear shape: approach, engagement, pressure, relief, and payoff.

### Cultivation structure
- Cultivation fiction usually starts with a **mortal tier**, then a **qi-gathering tier**, then a **foundation tier**, then **core / soul tiers**, then **immortal-approaching tiers**, and finally **immortal / sovereign tiers**.
- The exact names vary by novel, but the structure is consistent: **accumulate qi -> stabilize the foundation -> condense power -> transform the soul/body -> face tribulations -> ascend**.
- Breakthroughs are usually meaningful events, not just a level-up button.
- Tribulation events are high-stakes gates between major realms.

### Body system ideas
- The body system should be separate from qi cultivation but linked to it.
- It can represent:
  - strength
  - endurance
  - flexibility
  - bone density
  - meridian capacity
  - resilience against injury and poison
- Body training should improve survival, combat ability, and qi capacity, but not replace cultivation.

### Inventory system ideas
- RPG inventory should support:
  - equipment
  - consumables
  - crafting materials
  - cultivation resources
  - quest items
- For an open-world RPG, inventory should probably use **weight / slots / stack limits** so loot choices matter.

### Mobile / Android considerations
- Godot documentation for Android export says Android builds need the **Android SDK**, **NDK**, **CMake**, and **OpenJDK 17**.
- Godot performance docs emphasize culling, LOD, bake lighting, and large-world optimization.
- Unity mobile docs also emphasize profiling and optimizing for mobile early.
- For Android 3D games, texture formats and performance budgeting matter a lot.

### Tooling available in this workspace
Installed already:
- Blender
- Godot 3
- Krita
- GIMP
- Inkscape
- Tiled
- Meshlab
- Audacity
- Darktable

### Important constraints
- A true MMORPG backend is a large project by itself.
- For a first build, the best path is:
  1. build a single-player foundation
  2. make online sync later
  3. keep the world modular
  4. ship a vertical slice first

## Recommended technical direction
- Use **Godot** for the prototype APK.
- Build a **vertical slice** first: one zone, one combat loop, one inventory loop, one cultivation loop, one body loop.
- If online play is required, add a lightweight authoritative server later instead of trying to build full MMO scale on day one.

## Suggested design language
- Fantasy xianxia / martial cultivation world
- High-contrast UI
- Clean, readable mobile HUD
- Grounded open-world terrain with temples, forests, villages, ruins, and cultivation sites

## Good next step
Create a **Game Design Document** and a **prototype roadmap** before writing the game.
