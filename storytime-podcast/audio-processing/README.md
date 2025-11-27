# Audio Processing Pipeline

**One-line description:** Post-processing automation for podcast-ready audio (normalization, music, effects)

## User Story

As a **podcast listener**,
I want to **hear consistent, professional-quality audio across all episodes**,
So that **I can enjoy stories without adjusting volume or dealing with poor quality**.

## Key Scenarios

### 1. Loudness Normalization
- Measure generated audio LUFS (Loudness Units Full Scale)
- Normalize to podcast standard (-16 LUFS)
- Ensure no clipping or distortion
- Maintain dynamic range for natural sound

### 2. Music and Intro/Outro
- Add intro theme music (first 5 seconds)
- Duck (lower) music volume under narration
- Add outro theme music (last 5 seconds)
- Crossfade between music and narration

### 3. Final Export
- Convert to MP3 format (128 kbps or higher)
- Embed metadata tags (ID3: title, artist, album, episode number)
- Generate filename: `s{season}_e{episode}_{slug}.mp3`
- Output to designated directory

## Technical Details

**Processing Chain:**
```
Raw TTS Audio (WAV)
  → Noise Reduction (optional)
  → Loudness Normalization (-16 LUFS)
  → Intro Music Mixing (fade in, duck)
  → Outro Music Mixing (duck, fade out)
  → Format Conversion (MP3 128-192 kbps)
  → Metadata Embedding (ID3 tags)
  → Final Output
```

**FFmpeg Commands:**
- **Loudness normalization**: `ffmpeg -i input.wav -af loudnorm=I=-16:TP=-1.5:LRA=11 output.wav`
- **Music mixing**: Use `amix` filter with ducking via `sidechaincompress`
- **MP3 encoding**: `-codec:a libmp3lame -b:a 128k`

**Music Library:**
- Store intro/outro tracks in `assets/music/`
- Define music cues in episode metadata (optional custom themes)
- Default: 5-second intro, 5-second outro
