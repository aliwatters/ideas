# Sound Effects & Music Generation Research

> Research on self-hosted AI models for sound effects and background music generation (2025)

---

## 🎵 AI Music Generation Models

### 1. MusicGen (Meta AudioCraft) ⭐ **RECOMMENDED**
- **Developer**: Meta AI (Facebook Research)
- **License**: MIT (code), CC-BY-NC 4.0 (model weights - **non-commercial**)
- **Parameters**: 300M, 1.5B, and 3.3B parameter models available
- **Max Duration**: Variable, can generate longer sequences
- **Hardware**: 16GB VRAM recommended (your RTX 5070 Ti is perfect!)

**Pros:**
- State-of-the-art text-to-music quality
- Controllable generation (style, genre, mood)
- Part of AudioCraft ecosystem (also includes AudioGen)
- Active development, strong community
- MIT licensed code (easy to modify and integrate)

**Cons:**
- Model weights are **non-commercial** (CC-BY-NC 4.0)
- Requires GPU with 16GB+ for best quality
- Not optimized for very short clips (intro/outro stingers)

**Use Cases for Storytime:**
- Background ambient music during narration
- Theme music for episodes
- Scene-specific music (adventure music, calm music, etc.)

---

### 2. Stable Audio Open
- **Developer**: Stability AI
- **License**: Fully open source
- **Duration**: Up to 47 seconds
- **Specialty**: Audio samples, sound effects, production elements
- **New**: Stable Audio Open Small (2025) - 341M parameters, mobile-optimized

**Pros:**
- **Commercially viable** (fully open license)
- Perfect duration for intro/outro music (30-47s)
- Fine-tunable on custom audio data
- Trained on Freesound + Free Music Archive (respects creator rights)
- Lightweight Small variant available

**Cons:**
- **Not optimized for full songs, melodies, or vocals**
- Better for production elements than full musical pieces
- Shorter maximum duration than MusicGen

**Use Cases for Storytime:**
- Intro/outro theme music (perfect 5-10 second stingers)
- Transition sounds between scenes
- Short musical accents

---

### 3. AudioCraft Comparison

| Feature | MusicGen | Stable Audio Open |
|---------|----------|-------------------|
| License | Non-commercial | Fully open |
| Max Length | Longer sequences | 47 seconds |
| Best For | Full background music | Short production elements |
| VRAM | 16GB recommended | More efficient |
| Fine-tuning | Yes | Yes (emphasized feature) |

---

## 🔊 Sound Effects Generation Models

### 1. AudioGen (Meta AudioCraft) ⭐ **RECOMMENDED**
- **Developer**: Meta AI (same as MusicGen)
- **License**: MIT (code), CC-BY-NC 4.0 (model weights)
- **Training**: Public sound effects dataset
- **Part of**: AudioCraft framework

**Capabilities:**
- Generate environmental sounds (forest ambience, rain, wind)
- Sound effects (footsteps, door creaks, animal sounds)
- Foley effects (rustling leaves, water splashing)
- Text prompt based: "dog barking", "footsteps on wooden floor", "car honking"

**Pros:**
- Integrated with MusicGen in AudioCraft (one installation)
- High-quality sound effect generation
- Controllable via text prompts
- Same hardware as MusicGen (efficient stack)

**Cons:**
- Non-commercial license (same restriction)
- May need fine-tuning for very specific sounds

**Use Cases for Storytime:**
- Character actions (footsteps, door opening)
- Environmental ambience (forest sounds, wind, rain)
- Animal sounds (bear growling, birds chirping)
- Props and objects (cookie jar opening, pages turning)

---

### 2. AudioLDM2
- **Developer**: Open source community
- **License**: Open source
- **Technology**: Latent Diffusion Models
- **Capabilities**: Speech, sound effects, music, and beyond

**Pros:**
- Versatile (can do sound effects AND music)
- Zero-shot audio manipulation (style transfer)
- Text-guided generation
- High fidelity with AudioLDM2

**Cons:**
- Less specialized than AudioGen
- May require more experimentation for consistent results
- Separate installation/framework from AudioCraft

**Use Cases for Storytime:**
- Similar to AudioGen, but more experimental
- Good for unique/unusual sounds that need creativity
- Audio style transfer (change existing sound's style)

---

### 3. Amphion (2025 Toolkit)
- **Developer**: Open-MMLAB
- **License**: Open source
- **Released**: v0.2 Technical Report (January 2025)
- **Purpose**: Comprehensive toolkit for Audio, Music, and Speech Generation

**Pros:**
- Brand new (actively developed in 2025)
- Comprehensive research toolkit
- Good for reproducible research
- Helps junior researchers get started

**Cons:**
- Very new (less proven in production)
- More research-oriented than production-ready
- Documentation may be limited

**Use Cases:**
- Research and experimentation
- Custom model training
- If AudioCraft doesn't meet needs

---

## 🎯 Recommended Stack for Storytime Podcast

### Phase 1: Quick Start (Non-Commercial Podcast)
```
TTS:           Kokoro-82M (narration)
Music:         MusicGen 300M (background music)
Sound Effects: AudioGen (foley and effects)
```
**All via AudioCraft** (one installation, integrated workflow)

### Phase 2: Commercial Podcast
```
TTS:           Kokoro-82M (narration)
Music:         Stable Audio Open (intro/outro themes)
Sound Effects: Pre-recorded library OR fine-tune Stable Audio Open
```
**Licensing Safe** for monetization

---

## 🖥️ Hardware Compatibility

| Model | VRAM | RTX 5070 Ti | Notes |
|-------|------|-------------|-------|
| MusicGen 300M | ~4-6GB | ✅ Excellent | Fast generation |
| MusicGen 1.5B | ~10-12GB | ✅ Good | Better quality |
| MusicGen 3.3B | ~16GB+ | ⚠️ Tight | Use for final production |
| AudioGen | ~4-6GB | ✅ Excellent | Same as MusicGen 300M |
| Stable Audio Open | ~6-8GB | ✅ Excellent | Efficient |
| Stable Audio Small | ~2-4GB | ✅ Perfect | Mobile-optimized |

**Your RTX 5070 Ti (16GB)** can comfortably run:
- MusicGen 1.5B + AudioGen simultaneously
- Or MusicGen 3.3B for highest quality music

---

## 🚀 Integration Strategy

### Option A: AudioCraft-First (Recommended for MVP)
```python
from audiocraft.models import MusicGen, AudioGen

# Generate background music
music_model = MusicGen.get_pretrained('medium')  # 1.5B params
music = music_model.generate(["calm forest ambient music"])

# Generate sound effects
sfx_model = AudioGen.get_pretrained('medium')
footsteps = sfx_model.generate(["footsteps on wooden floor"])
```

**Pros**: Single framework, integrated workflow, proven quality
**Cons**: Non-commercial license restriction

### Option B: Stable Audio for Commercial Use
```python
from stable_audio_tools import get_pretrained_model

model = get_pretrained_model("stabilityai/stable-audio-open-1.0")
audio = model.generate("upbeat children's theme music, 10 seconds")
```

**Pros**: Commercial-friendly, fine-tunable, perfect for short clips
**Cons**: Less versatile for longer background music

---

## 📝 Workflow Integration

### Complete Episode Generation Pipeline
```
1. Script → TTS (Kokoro) → Narration.wav
2. Scene descriptions → MusicGen → Background_Music.wav
3. Action cues → AudioGen → Sound_Effects.wav
4. Mix all layers → FFmpeg → Final_Episode.mp3
```

### Example Scene
```yaml
scene:
  narration: "Barnaby walked through the forest..."
  music_prompt: "peaceful forest ambience, soft strings"
  sound_effects:
    - time: 2.5s
      prompt: "footsteps on leaves"
    - time: 5.0s
      prompt: "bird chirping"
```

---

## 💡 Next Steps

### Immediate Testing
- [ ] Install AudioCraft on ai-runners
- [ ] Test MusicGen with "calm children's story music" prompt
- [ ] Test AudioGen with "footsteps, forest sounds" prompts
- [ ] Measure generation speed on RTX 5070 Ti
- [ ] Create sample 30s story scene with TTS + music + SFX

### Licensing Decision
- [ ] Decide: Non-commercial podcast OR commercial?
- [ ] If commercial: Explore Stable Audio Open fine-tuning
- [ ] If non-commercial: Go all-in on AudioCraft

### Production Pipeline
- [ ] Design YAML format for scene descriptions (music + SFX cues)
- [ ] Build audio mixing script (FFmpeg or pydub)
- [ ] Create SFX library cache (pre-generate common sounds)
- [ ] Define music themes per story type (adventure, bedtime, silly)

---

## 📚 Resources

**AudioCraft:**
- GitHub: https://github.com/facebookresearch/audiocraft
- Demo: https://ai.meta.com/resources/models-and-libraries/audiocraft/
- License: MIT (code), CC-BY-NC 4.0 (weights)

**Stable Audio Open:**
- GitHub: https://github.com/Stability-AI/stable-audio-tools
- Hugging Face: https://huggingface.co/stabilityai/stable-audio-open-1.0
- License: Fully open source

**AudioLDM2:**
- GitHub: https://github.com/haoheliu/AudioLDM2
- Demo: https://audioldm.github.io/

**Amphion:**
- GitHub: https://github.com/open-mmlab/Amphion

---

**Last Updated**: 2025-10-21
**Related**: TTS_MODEL_RESEARCH.md
