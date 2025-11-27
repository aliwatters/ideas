# TTS Generation Engine

**One-line description:** Self-hosted text-to-speech integration with ai-runners for natural narration synthesis

## User Story

As a **podcast producer**,
I want to **automatically convert episode scripts into natural-sounding audio**,
So that **I can produce episodes without manual recording**.

## Key Scenarios

### 1. Single-Voice Generation
- Read episode script with single narrator
- Call ai-runners TTS model with full text
- Receive generated MP3 with consistent voice throughout
- Calculate and store final duration

### 2. Multi-Character Generation
- Parse script to identify character segments
- Route each segment to appropriate voice model
- Stitch together audio segments seamlessly
- Normalize volume across different voices

### 3. Voice Model Selection
- List available TTS models from ai-runners
- Configure default voice for narrator
- Assign custom voices to specific characters
- Support voice cloning for custom character creation

## Technical Details

**Integration Points:**
- **ai-runners API**: HTTP endpoint for TTS inference
- **Model Format**: Expects XTTS v2, StyleTTS2, or compatible
- **Input**: Text string + voice configuration JSON
- **Output**: WAV or MP3 audio buffer

**Processing Steps:**
1. Parse script into segments (narrator vs characters)
2. For each segment:
   - Prepare TTS request payload
   - Call ai-runners inference endpoint
   - Receive audio buffer
   - Store temporary file
3. Concatenate all segments
4. Apply crossfade between segments (50-100ms)
5. Calculate total duration
6. Output final MP3

**Configuration Schema:**
```yaml
# tts_config.yaml
default_voice:
  model: "xtts_v2"
  speaker: "storyteller_calm"
  language: "en"
  temperature: 0.7

voices:
  friendly_bear:
    model: "xtts_v2"
    speaker: "bear_friendly"
    pitch_shift: -3  # semitones

ai_runners:
  endpoint: "http://localhost:8000/v1/tts"
  timeout: 120  # seconds
```
