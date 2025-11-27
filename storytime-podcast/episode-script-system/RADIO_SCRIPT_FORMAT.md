# Radio Script Format Specification

> Professional radio drama script notation for podcast episodes with narration, dialogue, music, and sound effects

## Format Overview

Radio scripts integrate **dialogue, sound effects, music cues, and timing** in a single readable document that can be parsed for automated audio generation.

---

## Core Elements

### 1. Character Dialogue
```
NARRATOR: Once upon a time, in a cozy forest...

BARNABY: (excited) Where did I put that cookie?
```

**Format:**
- `CHARACTER_NAME:` followed by dialogue
- Emotion/direction in parentheses: `(excited)`, `(whispered)`, `(sad)`

### 2. Sound Effects (SFX)
```
SFX: FOOTSTEPS ON LEAVES, FADING IN

SFX: DOOR CREAKING OPEN

SFX: FOREST AMBIENCE (UNDER, CONTINUOUS)
```

**Format:**
- `SFX:` followed by description
- Can include modifiers:
  - `UNDER` - plays quietly underneath dialogue
  - `CONTINUOUS` - loops/sustains
  - `FADE IN` / `FADE OUT` - volume transitions
  - `STINGER` - short accent sound

### 3. Music Cues
```
MUSIC: GENTLE FOREST THEME, FADE IN UNDER

MUSIC: UP FULL FOR 5 SECONDS, THEN UNDER

MUSIC: FADE OUT AND END
```

**Format:**
- `MUSIC:` followed by description and instructions
- Volume levels:
  - `UP FULL` - foreground volume
  - `UNDER` - background volume
  - `OUT` - fade to silence
- Timing: `FOR 5 SECONDS`, `3 SECOND FADE`

### 4. Stage Directions / Notes
```
(PAUSE 2 SECONDS)

(BARNABY SOUNDS OUT OF BREATH)

(TRANSITION TO NIGHT SCENE)
```

**Format:**
- Parentheses for directions that aren't spoken
- Timing cues
- Emotional context for voice actors

### 5. Timing Marks
```
[00:00] COLD OPEN

[00:15] INTRO MUSIC

[02:30] SCENE 2
```

**Format:**
- `[MM:SS]` timestamp markers
- Useful for synchronization and pacing references

---

## Complete Example: "Barnaby's Missing Cookie"

```
# Episode 001: Barnaby's Missing Cookie
# Season 1, Episode 1
# Estimated Runtime: 5:00

[00:00] COLD OPEN

MUSIC: PLAYFUL CHILDREN'S THEME, FADE IN UP FULL

MUSIC: FADE TO UNDER AFTER 5 SECONDS

[00:05]

NARRATOR: (warm, inviting) Welcome to Story Time! Today's tale is about
         a very special bear named Barnaby... and his missing cookie.

MUSIC: FADE OUT

[00:15] SCENE 1 - BARNABY'S KITCHEN

SFX: FOREST AMBIENCE (UNDER, CONTINUOUS)

NARRATOR: Once upon a time, in a cozy forest cottage, there lived
         a bear named Barnaby.

SFX: FOOTSTEPS ON WOODEN FLOOR

NARRATOR: Barnaby loved three things: honey, naps, and most of all... cookies.

SFX: COOKIE JAR LID OPENING

BARNABY: (gasping) Oh no! My cookie! It's gone!

SFX: COOKIE JAR LID CLOSING WITH FRUSTRATION

BARNABY: (worried) Where did I put it? I just had it this morning!

(PAUSE 1 SECOND)

NARRATOR: Barnaby looked high and low.

SFX: DRAWERS OPENING AND CLOSING (3 TIMES)

SFX: RUSTLING THROUGH PAPERS

BARNABY: (calling out) Cookie? Where are you, little cookie?

[01:30] SCENE 2 - OUTSIDE THE COTTAGE

SFX: FOREST AMBIENCE SWELLS UP

SFX: DOOR OPENING

SFX: FOOTSTEPS ON LEAVES, WALKING PACE

MUSIC: GENTLE ADVENTURE THEME, FADE IN UNDER

NARRATOR: Barnaby decided to search outside. Perhaps he'd taken
         the cookie on his morning walk.

BARNABY: (thoughtful) Let me retrace my steps...

SFX: BIRD CHIRPING

SFX: FOOTSTEPS STOP

BARNABY: (excited) Wait! What's that?

SFX: RUSTLING IN BUSHES

NARRATOR: Behind a bush, Barnaby spotted something brown and round.

BARNABY: (hopeful) My cookie!

(PAUSE 1 SECOND)

SFX: FOOTSTEPS RUNNING QUICKLY

BARNABY: (disappointed) Oh... it's just a pine cone.

MUSIC: SAD MELODY STING

[02:45] SCENE 3 - THE DISCOVERY

SFX: FOOTSTEPS CONTINUE, SLOWER

NARRATOR: Barnaby sat down on a log, feeling quite sad.

SFX: SITTING ON WOODEN LOG (CREAK)

SFX: FOREST AMBIENCE CONTINUES

BARNABY: (sighs) I guess my cookie is really gone.

(PAUSE 2 SECONDS)

SFX: SMALL VOICE IN DISTANCE (MUFFLED)

BARNABY: (curious) What was that?

NARRATOR: Barnaby looked up to see a tiny mouse, holding something
         very familiar.

SFX: TINY FOOTSTEPS APPROACHING

MOUSE: (small, high voice) Um... Mr. Barnaby? I think this belongs to you.

MUSIC: WARM DISCOVERY THEME, FADE IN UNDER

BARNABY: (joyful) My cookie! You found it!

MOUSE: (shy) Actually... I took it. I was so hungry, but I felt bad.
      I'm sorry.

[04:00] RESOLUTION

(PAUSE 2 SECONDS)

BARNABY: (kind) That's okay, little friend. Would you like to share it with me?

MOUSE: (surprised and happy) Really?

BARNABY: (warm) Of course! Cookies taste better with friends.

SFX: COOKIE BREAKING IN HALF (GENTLE SNAP)

NARRATOR: And so Barnaby and Mouse shared the cookie, and became
         the best of friends.

MUSIC: WARM FRIENDSHIP THEME, UP FULL

[04:30] OUTRO

MUSIC: FADE TO UNDER

NARRATOR: The end. Remember, friends: sharing makes everything sweeter.

MUSIC: PLAYFUL CHILDREN'S THEME RETURNS

NARRATOR: Join us next time for another Story Time adventure!

MUSIC: UP FULL FOR 5 SECONDS

MUSIC: FADE OUT AND END

[05:00] END OF EPISODE
```

---

## Parsing Guidelines for Automation

### Character Dialogue
```regex
^([A-Z][A-Z\s]+):\s*(\([^)]+\))?\s*(.+)$
```
- Group 1: Character name (NARRATOR, BARNABY)
- Group 2: Optional emotion/direction
- Group 3: Dialogue text

### Sound Effects
```regex
^SFX:\s*(.+?)(\s*\(([^)]+)\))?$
```
- Group 1: Sound description (FOOTSTEPS ON LEAVES)
- Group 3: Modifiers (UNDER, FADE IN, etc.)

### Music Cues
```regex
^MUSIC:\s*(.+)$
```
- Group 1: Full music instruction

### Timing Marks
```regex
^\[(\d{2}):(\d{2})\](.*)$
```
- Group 1: Minutes
- Group 2: Seconds
- Group 3: Optional label

### Stage Directions
```regex
^\(([^)]+)\)$
```
- Group 1: Direction text

---

## Integration with AI Generation

### TTS (Kokoro/XTTS)
- Parse dialogue lines
- Extract character and emotion
- Map to voice model
- Generate audio segment

### Sound Effects (AudioGen)
- Parse `SFX:` lines
- Convert description to AudioGen prompt
- Apply modifiers (fade, loop, volume)
- Generate and cache effect

### Music (MusicGen/Stable Audio)
- Parse `MUSIC:` cues
- Convert description to MusicGen prompt
- Extract duration and timing
- Generate music segment

### Audio Mixing (FFmpeg)
- Use timing marks for synchronization
- Apply `UNDER` directive → lower volume to -20dB
- Apply `FADE IN/OUT` → gradual volume transition
- Stack layers: ambience → music → dialogue → SFX

---

## File Structure

```
episodes/
├── 001_barnaby_cookie/
│   ├── script.radio         # Main radio script
│   ├── metadata.yaml        # Episode metadata
│   └── generated/           # Output directory
│       ├── dialogue/        # Generated TTS segments
│       ├── sfx/             # Generated sound effects
│       ├── music/           # Generated music
│       └── final.mp3        # Mixed final episode
```

---

## Validation Rules

### Required Elements
- At least one `NARRATOR:` or character dialogue line
- Script must start with timing mark `[00:00]`
- All character names must be defined in `metadata.yaml`

### Best Practices
- Keep dialogue lines under 200 characters for natural phrasing
- Use `(PAUSE X SECONDS)` for dramatic timing
- Mark ambience as `(UNDER, CONTINUOUS)` to sustain throughout scene
- Specify music duration to avoid abrupt cuts
- Use consistent character names (ALL CAPS)

### Timing Validation
- Timing marks should be sequential
- Estimate ~150 words per minute for narration
- Account for SFX and music duration

---

## Benefits of Radio Script Format

1. **Human-Readable** - Writers can focus on storytelling
2. **Git-Friendly** - Plain text, easy diffs and version control
3. **Parseable** - Structured enough for automation
4. **Professional** - Industry-standard format
5. **Complete** - Integrates all audio elements in one document
6. **Dad Camp Friendly** - Your daughters can learn and use this format!

---

## Next Steps

- [ ] Create parser script to extract dialogue, SFX, and music cues
- [ ] Map SFX descriptions to AudioGen prompts
- [ ] Map music descriptions to MusicGen prompts
- [ ] Build audio mixing pipeline with timing synchronization
- [ ] Create template generator for new episodes
- [ ] Add syntax highlighting for editor (VS Code extension?)

---

**Related:**
- See `AUDIO_GENERATION_RESEARCH.md` for AI model details
- See `tts-generation/spec.feature` for TTS implementation
- See `audio-processing/README.md` for mixing pipeline
