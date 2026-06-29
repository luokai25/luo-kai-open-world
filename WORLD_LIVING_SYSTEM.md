# Luo Kai: Open World — Living World System

## Goal
Make the world feel active even when the player is not fighting.

## Simulation layers
### Time
A light day-night cycle changes lighting, NPC availability, danger, and request timing.

### Weather
Weather changes visibility, mood, and where the player expects danger.

### NPC routines
NPCs move through believable places instead of staying pinned to one spot forever.

### Zone state
Each region maintains its own pressure, threat level, and landmarks.

### World memory
Visible changes remain after important events.

## World states
The game should track these world-wide states, even in a light prototype.
- time of day
- weather
- day count
- season
- spiritual pressure
- regional threat
- settlement activity
- landmark state
- request availability
- NPC affinity

## Time-of-day behavior
### Dawn
- elders meditate
- merchants prepare goods
- hunters check tracks
- training yards open
- shrine smoke rises

### Morning
- villages feel busiest
- travel begins
- work is visible
- public requests are easiest to find

### Afternoon
- field work, trade runs, and resource gathering peak
- roads are active
- some NPCs leave the settlement

### Evening
- workers return
- inns and camps fill
- social conversations become more personal
- some requests become private or reflective

### Night
- roads thin out
- monster pressure rises
- guard lanterns matter
- rituals, ambushes, and secret meetings become possible

## Weather behavior
### Clear
- maximum visibility
- safest navigation
- landmarks read clearly

### Fog
- hides paths and distant danger
- good for spirits and mysteries
- makes the world feel older

### Rain
- dampens sound
- changes terrain feeling
- makes ruins and lights look stronger

### Storm
- rare and dramatic
- spiritual pressure spikes
- travel feels unsafe and important

### Wind
- reveals open terrain and height
- good for cliffs, ridges, and exposed places

## NPC routine behavior
NPCs should have a rough role and rough place.
- elders stay near shrines, gates, or homes
- merchants move between road posts and markets
- hunters split time between camps and forests
- trainers use yards, courtyards, and practice spots
- blacksmiths stay near heat, stone, and material storage
- wandering cultivators appear in transient places

## NPC memory behavior
NPCs should remember a few important facts.
- first meeting
- accepted request
- completed request
- repeated help
- player’s realm
- whether the player behaved honorably

This memory affects:
- dialogue tone
- rewards
- access to new requests
- whether the NPC introduces other NPCs

## Request timing rules
Requests should not always be visible.
- some requests are only available in certain weather
- some only appear at night
- some only appear after the player reaches a realm threshold
- some only appear after the player has visited another place
- some only unlock after affinity

## Zone reaction rules
Zones should react to the player.
- weak enemies become less threatening after realm growth
- shrine light intensifies after breakthroughs
- villagers comment on aura or danger
- suspicious guards stop questioning powerful cultivators
- hidden paths become easier to read after the player learns the area

## World memory examples
- a bridge repaired in Spirit Forest remains visibly repaired
- a cleared den leaves scorch marks or broken roots
- a shrine restored keeps a brighter glow
- a successful escort changes how guards behave on the road
- a completed request can alter who stands where

## Atmosphere tools
To keep the world from feeling flat, use:
- fog layers
- drifting particles
- distant silhouettes
- lanterns and shrine lights
- ambient sound changes
- weather-driven color shifts
- region-specific landmark shapes

## What the prototype should simulate first
Keep it simple but alive.
1. day/night
2. weather
3. one zone profile
4. one region pressure value
5. one NPC schedule
6. one landmark list
7. one request availability rule
8. one persistent world change after a request

## What to avoid
- no empty arena-like spaces
- no NPCs that never move or react
- no loot everywhere with no logic
- no world state that resets every time the scene loads
- no cultivation system detached from the terrain and people

## Design result
If this works, the player should feel that the world keeps breathing when they are not looking at it.
