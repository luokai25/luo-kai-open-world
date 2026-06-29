# Luo Kai: Open World — Game Design Document

## High concept
**Luo Kai: Open World** is a third-person mobile cultivation RPG set in a seamless fantasy world. Players gather qi, train their body, fight monsters, explore territory, manage inventory, complete requests from NPCs, and break through cultivation realms to become stronger.

## Target device
- Primary target: **Poco X3 NFC**
- Device profile: Snapdragon 732G, 6.67" 120Hz display, 5160 mAh battery, Android 10+ on typical units.
- Practical implication: the game can be visually ambitious, but Android-friendly performance and memory management still matter.

## Product direction
This should feel like:
- a real open-world RPG
- an online cultivation game
- third-person action combat
- progression-heavy, with meaningful growth
- mobile-first, but not toy-like

## Pillars
1. **Open world exploration**
2. **Cultivation progression**
3. **Body strengthening progression**
4. **Third-person combat**
5. **Inventory and loot management**
6. **NPC-led social play**

## Core loop
1. Explore the world
2. Meet NPCs and receive requests
3. Fight enemies / complete requests
4. Collect loot, resources, and qi-related items
5. Train body and cultivate qi
6. Break through a realm or body tier
7. Unlock new areas, enemies, and abilities
8. Repeat at a higher power level

## Camera and controls
- Fixed third-person over-the-shoulder camera
- Mobile left-stick movement
- Right-side touch camera / skill buttons
- Dodge, sprint, basic attack, skill, interact, inventory, cultivation, body training

## Combat
- Real-time action combat
- Light attack / heavy attack / skill chain
- Stamina or focus resource
- Enemy variety by mobility, armor, and elemental or spiritual traits
- Bosses with realm-gated difficulty

## Cultivation system
Cultivation is the spiritual power path.

### Resources
- Qi essence
- Spiritual stones
- Manuals
- Elixirs
- Breakthrough catalysts

### Mechanics
- Gather qi from the world, enemies, and meditation
- Store qi in the dantian
- Fill realm progress
- Attempt breakthrough at thresholds
- Breakthrough success unlocks new abilities, stats, and zones
- Failure can apply injury, qi loss, or temporary debuffs

### Suggested realms
- Mortal
- Qi Gathering
- Foundation Establishment
- Core Formation
- Nascent Soul
- Soul Formation
- Void Refinement
- Body Integration
- Mahayana
- Tribulation / Ascension

## Body system
The body system is separate from qi but synergistic.

### Body attributes
- Strength
- Endurance
- Agility
- Flexibility
- Bone density
- Meridian capacity
- Resistance to injury and poison

### Mechanics
- Train through exercises, trials, enemies, and body techniques
- Body tiers unlock passive survivability and physical damage bonuses
- Body progression can lag behind qi progress, creating build choices
- A stronger body can support larger qi reserves and higher breakthrough success

## Inventory system
- Equipment: weapons, armor, accessories
- Consumables: healing items, buffs, antidotes
- Materials: monster drops, ores, herbs, relics
- Cultivation items: manuals, pills, qi stones
- Request items: keys, letters, relic fragments

### Rules
- Limited slots or weight capacity
- Higher-quality items take more room or weight
- Stackable consumables and materials
- Strong gear may require realm or body thresholds

## World structure
- Large connected world, but built in modular zones
- Villages, sect grounds, forests, ruins, caves, mountain passes, spiritual sites, boss arenas
- Hidden paths and secret cultivation spots
- Safe zones for rest, trading, crafting, and social activity

## NPC-led requests
- Requests come from NPCs as favors, teachings, errands, tests, or rewards
- NPCs should be the source of world activity
- Different NPC types can give different request styles:
  - elder
  - merchant
  - trainer
  - hunter
  - blacksmith
  - wandering cultivator
- Requests can be repeatable, affinity-based, or unlock new paths

## Online features
For the first playable version:
- login/account identity
- shared world presence
- co-op encounters
- player names, friends, chat, and party support
- server-managed progression data

## Visual direction
- Fantasy xianxia style
- Temple/mountain/forest/cultivation aesthetic
- Distinct realm palettes and landmark silhouettes
- Fog, glow, particles, layered terrain, and strong environmental storytelling
- High readability on mobile
- Strong silhouettes, bold UI, clear ability icons

## Realm visual identity
- **Mortal**: muted earth tones, villages, worn paths, low spiritual light
- **Qi Gathering**: pale blue-green glow, misty groves, small spirit nodes
- **Foundation Establishment**: cleaner mountains, stronger verticality, sect influence
- **Core Formation**: brighter cores, embedded crystals, larger talismans
- **Nascent Soul**: mystical, dreamlike, aurora-like sky effects
- **Soul Formation and above**: increasingly cosmic, ritual-heavy, grand scale landmarks

## Build strategy
Because the target is Android, the best approach is:
1. build a vertical slice
2. prove the combat/cultivation loop
3. add inventory and body system
4. add online sync
5. expand the world content

## First vertical slice scope
One zone only:
- one player character
- one enemy family
- one mini-boss
- one cultivation breakthrough path
- one body-training loop
- one inventory loop
- one NPC request chain
- one simple online test

## Design priority
If the game has to be huge, fine — but it still needs a playable spine first. The smartest order is:
**movement -> combat -> progression -> inventory -> open world -> online**
