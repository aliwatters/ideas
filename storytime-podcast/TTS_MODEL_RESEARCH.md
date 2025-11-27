# Self-Hosted TTS Model Research

> Research on open-source TTS models suitable for ai-runners infrastructure (as of 2025)

## Top Candidates for Storytime Podcast

### 1. Kokoro-82M ⭐ **RECOMMENDED**
- **Developer**: Based on StyleTTS2 and ISTFTNet
- **Parameters**: 82 million (lightweight)
- **Performance**: <0.3s processing time, fastest in class
- **Quality**: Comparable to much larger models in blind tests
- **License**: Open-source
- **Best For**: Production use with fast inference needs

**Pros:**
- Extremely fast generation (critical for batch processing)
- Small model size (easy to load on any of your GPUs)
- High quality output
- No encoder/diffusion overhead

**Cons:**
- Newer model, may have less community support
- Voice cloning capabilities unclear

---

### 2. XTTS-v2
- **Developer**: Coqui AI (community-maintained since 2024)
- **Languages**: 17 languages
- **Voice Cloning**: 6-second sample for voice replication
- **Quality**: Excellent, captures emotional tone and speaking style
- **License**: ⚠️ **Coqui Public Model License (Non-Commercial Use Only)**

**Pros:**
- Proven in production
- Excellent voice cloning (great for character voices)
- Captures emotion and prosody
- Large community

**Cons:**
- **Non-commercial license** (may not be suitable for monetized podcast)
- Heavier compute requirements
- Slower than Kokoro

---

### 3. Chatterbox (Resemble AI)
- **Status**: #1 trending TTS model on Hugging Face (2025)
- **Language**: English
- **Latency**: <200ms TTFB (time to first byte) on suitable hardware
- **License**: Open-source

**Pros:**
- Low latency (great for real-time if needed)
- Currently most popular
- Active development

**Cons:**
- English-only
- Less information on voice cloning capabilities

---

### 4. Dia (Nari Labs)
- **Specialty**: Podcast-style audio
- **Features**: Multi-speaker support, voice cloning
- **Quality**: Very impressive, podcast-ready

**Pros:**
- **Purpose-built for podcasts** ✅
- Multi-speaker native support
- Voice cloning included
- High quality output

**Cons:**
- Newer model, less documentation
- Performance metrics not widely published

---

## Recommendation for Storytime Podcast

### Phase 1 MVP: **Kokoro-82M**
- Fast enough for iteration during development
- Production-quality output
- Will run efficiently on any of your ai-runners GPUs
- Open-source license (safe for commercial use)

### Phase 2 (Character Voices): **Evaluate Dia**
- If podcast-specific features prove valuable
- Multi-speaker capabilities for different characters
- Voice cloning for custom character creation

### Alternative: **XTTS-v2**
- **Only if podcast remains non-commercial**
- Best voice cloning capabilities
- Most proven in production

---

## Hardware Compatibility

All models should run well on your infrastructure:

| Model     | VRAM Needed | RTX 5070 Ti 16GB | NVIDIA DGX Spark | Halo Strix 128 |
|-----------|-------------|------------------|------------------|----------------|
| Kokoro    | ~4-6 GB     | ✅ Excellent      | ✅ Excellent      | ✅ Excellent    |
| XTTS-v2   | ~8-10 GB    | ✅ Good           | ✅ Excellent      | ✅ Excellent    |
| Chatterbox| ~6-8 GB     | ✅ Good           | ✅ Excellent      | ✅ Excellent    |
| Dia       | ~8-12 GB    | ✅ Feasible       | ✅ Excellent      | ✅ Excellent    |

**Note**: Your RTX 5070 Ti (16GB) can handle any of these models comfortably. The DGX Spark and Halo Strix are overkill for TTS but enable batch processing multiple episodes in parallel.

---

## Implementation Priority

1. **Start with Kokoro-82M** - Fastest iteration, commercially viable
2. **Test with sample scripts** - Validate quality meets "kids podcast" standards
3. **Benchmark on ai-runners** - Measure actual inference time on your hardware
4. **Evaluate Dia if multi-speaker is critical** - May simplify character voice handling
5. **Avoid XTTS-v2 unless non-commercial** - License restriction

---

## Next Steps

- [ ] Install Kokoro-82M on ai-runners
- [ ] Create simple inference script
- [ ] Generate test audio with sample story text
- [ ] Listen test with kids (ultimate quality check!)
- [ ] Benchmark: measure seconds of audio generated per second of inference time
- [ ] Document ai-runners API integration pattern

---

**Sources:**
- BentoML TTS Model Guide (2025)
- Inferless TTS Model Comparison
- Modal Blog: Open-Source TTS Models
- Hugging Face Model Hub
