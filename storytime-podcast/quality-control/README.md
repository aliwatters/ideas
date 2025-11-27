# Quality Control System

**One-line description:** Validation and preview workflows to ensure podcast-ready audio quality

## User Story

As a **podcast producer**,
I want to **catch audio quality issues before final export**,
So that **every published episode meets professional standards**.

## Key Scenarios

### 1. Automated Quality Checks
- Detect clipping (audio exceeding 0 dBFS)
- Find excessive silence gaps (> 3 seconds)
- Validate LUFS levels (-16 LUFS ± 1)
- Confirm duration matches expected length (± 30 seconds)

### 2. Preview Generation
- Create a 30-second preview (first 15s + last 15s)
- Generate preview quickly for rapid iteration
- Listen and approve before full processing
- Flag issues for manual review

### 3. Manual Review Workflow
- Present generated audio in web interface or local player
- Display quality check results (pass/fail per metric)
- Allow approval, rejection, or regeneration
- Log decisions for audit trail

## Technical Details

**Quality Check Criteria:**

| Check | Threshold | Tool |
|-------|-----------|------|
| Clipping | 0 samples > 0 dBFS | `ffmpeg -af astats` |
| LUFS | -17 to -15 LUFS | `ffmpeg -af loudnorm` |
| Silence Gaps | Max 3 seconds | `ffmpeg silencedetect` |
| Duration | Metadata ± 30s | Length calculation |
| Bitrate | ≥ 128 kbps | File metadata |

**Preview Generation:**
```bash
# Extract first 15 seconds
ffmpeg -i full_audio.mp3 -t 15 -c copy intro_preview.mp3

# Extract last 15 seconds
ffmpeg -i full_audio.mp3 -sseof -15 -c copy outro_preview.mp3

# Concatenate
ffmpeg -i "concat:intro_preview.mp3|outro_preview.mp3" -c copy preview.mp3
```

**Approval Workflow:**
1. Generate episode audio
2. Run automated quality checks
3. Create 30s preview
4. Present results + preview link
5. Wait for approval (CLI prompt, web UI, or Git tag)
6. If approved → finalize and export
7. If rejected → log issue, allow re-generation
