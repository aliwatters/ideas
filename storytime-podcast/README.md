# Storytime Podcast - Automated Audio Generation

> Self-hosted TTS pipeline for generating high-quality kids' story time podcast episodes using ai-runners infrastructure

## 🎯 Problem Statement

**What problem does this solve?**

Creating a daily kids' podcast requires consistent, high-quality audio narration. Manual recording is time-consuming and hard to maintain consistency. Commercial TTS services have recurring costs and vendor lock-in. We need an automated, self-hosted solution that produces natural-sounding narration from text scripts.

**Who is it for?**

- **Primary creators**: "Dad Camp" team (your daughters) - need an easy way to turn written stories into audio episodes
- **Technical operator**: You - need reliable, automated pipeline with minimal maintenance
- **End listeners**: Kids and families - need engaging, natural-sounding story narration

**Why now?**

- Self-hosted AI models (TTS, voice cloning) have reached production quality
- You have powerful ai-runners infrastructure (Halo Strix 128, RTX 5070 Ti 16GB, NVIDIA DGX Spark)
- Git-based workflow enables version control and collaboration for episode scripts
- Automation frees up time to focus on story creation, not production

## 💡 Solution

**Core Value Proposition:**

A fully automated audio generation pipeline that transforms text scripts into production-ready podcast episodes using self-hosted AI models, with no recurring API costs and complete control over voice quality.

**Key Features:**

1. **Episode Script System** - Git-based YAML metadata + text scripts for version-controlled episode management
2. **Self-Hosted TTS Generation** - Integration with ai-runners infrastructure for natural narration
3. **Audio Processing Pipeline** - Automated normalization, music mixing, and enhancement
4. **Quality Control System** - Preview generation and validation before final export

## 🔍 Research

**Existing Solutions:**

| Solution | Pros | Cons | Pricing |
|----------|------|------|---------|
| ElevenLabs | Excellent voice quality, easy API | Vendor lock-in, recurring cost | $5-99/mo |
| Google Cloud TTS | Enterprise-grade, WaveNet voices | Pay-per-use, requires internet | ~$4/1M chars |
| Descript Overdub | Good for editing, voice cloning | Desktop app, limited automation | $24/mo |
| Anchor/Spotify | Free hosting, built-in TTS | Low quality TTS, limited control | Free |

**Key Differentiators:**

- **Zero recurring costs** - Self-hosted models, no per-character fees
- **Complete control** - Fine-tune voices, adjust processing, no vendor limitations
- **Privacy** - All content stays on your infrastructure
- **Custom voices** - Can train/clone specific voices for different characters
- **Git-native workflow** - Version control, collaboration, CI/CD integration

**Technical Feasibility:**

- [x] ai-runners infrastructure available and powerful enough for TTS workloads
- [x] Open-source TTS models (XTTS, Coqui, StyleTTS2) are production-ready
- [x] Python ecosystem has mature audio processing libraries (pydub, librosa, ffmpeg)
- [ ] Need to validate model performance on your specific hardware

## 🏗️ Technical Overview

**Potential Tech Stack:**

- **TTS Models**: XTTS v2, Coqui TTS, or StyleTTS2 (running on ai-runners)
- **Audio Processing**: FFmpeg, pydub, librosa (normalization, mixing)
- **Backend**: Python scripts, ai-runners integration
- **Content Management**: Git repository with YAML metadata + text scripts
- **Workflow Automation**: (Future) GitHub Actions or local orchestration
- **Audio Enhancement**: Background music mixing, sound effects, noise reduction

**Key Integrations:**

- **ai-runners**: Self-hosted AI model serving infrastructure at ~/git/ai-runners
  - Halo Strix 128 - High-capacity model serving
  - RTX 5070 Ti 16GB - Fast inference GPU
  - NVIDIA DGX Spark - Enterprise-grade processing
- **Audio Libraries**: FFmpeg for format conversion, pydub for programmatic editing

**Estimated Complexity:**

- [ ] Low (< 1 week)
- [x] Medium (1-4 weeks) - Phase 1 only (audio generation)
- [ ] High (1+ months)

## 📊 Phase 1 Scope (Current Focus)

This draft focuses on the **audio generation system** - transforming scripts into production-ready audio files.

**Out of Scope for Phase 1:**
- RSS feed generation
- Cloud storage/hosting (S3, Droplet)
- Podcast directory publishing
- Analytics and monitoring

## 📝 Feature Breakdown

Phase 1 features to be specified in detail:

1. **Episode Script System** - YAML metadata + text script format for episode definition
   - Spec: `episode-script-system/spec.feature`
   - Define metadata schema (title, description, season, episode, etc.)
   - Text script format with narrator/character markers

2. **TTS Generation Engine** - Integration with ai-runners for audio synthesis
   - Spec: `tts-generation/spec.feature`
   - Model selection and configuration
   - Voice assignment per character
   - Generation queue and progress tracking

3. **Audio Processing Pipeline** - Post-processing for podcast-ready output
   - Spec: `audio-processing/README.md`
   - Normalization and loudness standards (LUFS -16 for podcasts)
   - Background music mixing
   - Intro/outro insertion

4. **Quality Control System** - Validation and preview before final export
   - Spec: `quality-control/README.md`
   - Duration validation
   - Audio quality checks (clipping, silence detection)
   - Quick preview generation

## 🚀 MVP Scope

**Essential for Phase 1:**
- Episode script system with YAML metadata
- Basic TTS generation using one model on ai-runners
- Simple audio normalization
- Manual quality check (listen and approve)

**Future Enhancements:**
- Multi-character voice support with different models
- **AI-generated background music** (MusicGen or Stable Audio Open)
- **AI-generated sound effects** (AudioGen for footsteps, ambience, foley)
- Audio mixing pipeline (narration + music + effects)
- Automated RSS feed generation (Phase 2)
- Cloud publishing pipeline (Phase 3)

## 📚 Resources

**TTS Models to Evaluate:**

- [XTTS v2](https://github.com/coqui-ai/TTS) - State-of-art voice cloning, multi-lingual
- [StyleTTS2](https://github.com/yl4579/StyleTTS2) - High quality, human-like prosody
- [Bark](https://github.com/suno-ai/bark) - Generative audio model, good for effects
- [Piper TTS](https://github.com/rhasspy/piper) - Fast, lightweight, neural TTS
- **See [TTS_MODEL_RESEARCH.md](./TTS_MODEL_RESEARCH.md)** for detailed comparison

**Music & Sound Effects Generation:**

- [AudioCraft (MusicGen + AudioGen)](https://github.com/facebookresearch/audiocraft) - Meta's text-to-music and sound effects
- [Stable Audio Open](https://github.com/Stability-AI/stable-audio-tools) - Open-source music generation (commercial-friendly)
- [AudioLDM2](https://github.com/haoheliu/AudioLDM2) - Versatile audio generation
- **See [AUDIO_GENERATION_RESEARCH.md](./AUDIO_GENERATION_RESEARCH.md)** for detailed comparison

**Audio Processing:**

- [FFmpeg Documentation](https://ffmpeg.org/documentation.html)
- [Podcast Audio Standards](https://podnews.net/article/loudness-war-podcast-audio) - LUFS -16 target
- [pydub Documentation](https://github.com/jiaaro/pydub)

**ai-runners Integration:**

- See ~/git/ai-runners for infrastructure details and API documentation

**Production Pipeline:**

- See [thetalekeeper](https://github.com/aliwatters/thetalekeeper) for the audio drama production pipeline
  - Radio script parser (`.radio` format)
  - FFmpeg audio mixing with stems
  - Storyteller persona script generator
  - End-to-end orchestration

## 🎯 Success Metrics

**Phase 1 Complete When:**

- Can convert a text script → production-ready MP3 in under 5 minutes
- Audio quality meets podcast standards (LUFS -16, no clipping)
- "Dad Camp" team can edit YAML and trigger generation easily
- Generated audio sounds natural enough for kids' content (tested with sample listeners)

## 📅 Next Steps

- [x] Define Phase 1 scope and features
- [ ] Write Gherkin specs for Episode Script System
- [ ] Write Gherkin specs for TTS Generation
- [ ] Research and test TTS models on ai-runners
- [ ] Create sample episode metadata and script
- [ ] Prototype audio generation script
- [ ] Build audio processing pipeline
- [ ] Create quality control checklist

---

**Status:** Specification (Draft)

**Created:** 2025-10-21

**Last Updated:** 2025-10-21

**Related Issues:** [ideas#7](https://github.com/aliwatters/ideas/issues/7)

**Implementation:** [thetalekeeper](https://github.com/aliwatters/thetalekeeper)
