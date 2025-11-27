# Episode Script System

**One-line description:** Git-based YAML metadata + text script format for version-controlled episode management

## User Story

As a **Dad Camp team member**,
I want to **create and edit episode scripts using simple text files**,
So that **I can focus on storytelling without learning complex tools**.

## Key Scenarios

### 1. Creating a New Episode
- Create a new YAML file with episode metadata (title, description, season/episode numbers)
- Write the story script in a linked text file
- Commit to Git for version control and triggering automation

### 2. Editing Episode Content
- Update story text without touching metadata
- Git diff shows exactly what changed in the narrative
- Collaborators can review changes via pull requests

### 3. Multi-Character Stories
- Mark different character voices in the script using simple syntax
- Map characters to different voice models/settings
- Preview how each character will sound

## Technical Details

**Metadata Schema (YAML):**
```yaml
# episodes_meta/001_barnaby_cookie.yaml
title: "Barnaby the Bear's Missing Cookie"
description: "A short tale about sharing and finding lost snacks"
season: 1
episode: 1
duration: null  # Auto-calculated by TTS generation
explicit: false
audio_file: "ep_s1_e01.mp3"
script_file: "../raw_scripts/001_barnaby_cookie.txt"
characters:
  - name: "Narrator"
    voice_model: "storyteller_default"
  - name: "Barnaby"
    voice_model: "friendly_bear"
```

**Script Format (Radio Script Notation):**

We use professional radio drama script format that integrates dialogue, sound effects, music cues, and timing in a single document.

```
[00:15] SCENE 1 - BARNABY'S KITCHEN

SFX: FOREST AMBIENCE (UNDER, CONTINUOUS)

NARRATOR: Once upon a time, in a cozy forest, there lived a bear named Barnaby.

SFX: FOOTSTEPS ON WOODEN FLOOR

BARNABY: (gasping) Oh no! My cookie! It's gone!

MUSIC: PLAYFUL SEARCH THEME, FADE IN UNDER
```

**Key Elements:**
- `CHARACTER:` - Dialogue with optional emotion `(excited)`, `(whispered)`
- `SFX:` - Sound effect descriptions for AudioGen
- `MUSIC:` - Music cues with volume/timing for MusicGen
- `[MM:SS]` - Timing marks for synchronization
- `(PAUSE X SECONDS)` - Stage directions

**Complete Specification:**
- See [RADIO_SCRIPT_FORMAT.md](./RADIO_SCRIPT_FORMAT.md) for full format spec
- See [example_barnaby_cookie.radio](./example_barnaby_cookie.radio) for complete example

**Validation Rules:**
- Title must be under 120 characters
- Episode numbers must be unique per season
- Script file must exist and be non-empty
- Must start with timing mark `[00:00]`
- All character names must be defined in metadata.yaml
- Duration calculated post-generation, stored in YAML
