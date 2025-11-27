Feature: TTS Audio Generation
  As a podcast producer
  I want to automatically convert episode scripts into natural-sounding audio
  So that I can produce episodes without manual recording

  Background:
    Given the ai-runners infrastructure is available at "http://localhost:8000"
    And the following TTS models are loaded on ai-runners:
      | Model Name   | Type       | Language | Status |
      | xtts_v2      | XTTS       | en       | ready  |
      | storyteller  | StyleTTS2  | en       | ready  |
      | bear_voice   | XTTS       | en       | ready  |
    And I have a valid episode metadata file at "episodes_meta/001_test.yaml"

  # ==============================================================================
  # Happy Path: Single Voice Generation
  # ==============================================================================

  Scenario: Generate audio from simple single-narrator script
    Given the episode script contains:
      """
      [NARRATOR]
      Once upon a time, in a cozy forest, there lived a bear named Barnaby.
      He loved cookies more than anything in the world.
      """
    And the episode metadata specifies:
      | Field       | Value              |
      | title       | Test Episode       |
      | voice_model | storyteller        |
      | season      | 1                  |
      | episode     | 1                  |
    When I run the TTS generation command
    Then the system should send a request to ai-runners with:
      | Parameter    | Value                                        |
      | model        | storyteller                                  |
      | text         | Once upon a time, in a cozy forest...       |
      | language     | en                                           |
    And I should receive an audio file "ep_s1_e01_raw.wav"
    And the audio duration should be between 10 and 15 seconds
    And the episode metadata should be updated with:
      | Field    | Value |
      | duration | ~12s  |
    And I should see a success message "Audio generated successfully"

  Scenario: Generate audio with calculated duration stored in metadata
    Given the episode script is 500 words long
    And the TTS model generates at approximately 150 words per minute
    When I run the TTS generation command
    Then the generated audio should be approximately 200 seconds long
    And the episode YAML file should be updated with "duration: 200"
    And the timestamp should be recorded in the YAML as "generated_at"

  # ==============================================================================
  # Multi-Character Generation
  # ==============================================================================

  Scenario: Generate audio with multiple character voices
    Given the episode script contains:
      """
      [NARRATOR]
      Barnaby looked everywhere for his cookie.

      [BARNABY]
      Where did I put that cookie?

      [NARRATOR]
      He searched high and low.

      [BARNABY]
      Maybe it's behind the tree!
      """
    And the episode metadata specifies character voices:
      | Character | Voice Model  | Pitch Shift |
      | NARRATOR  | storyteller  | 0           |
      | BARNABY   | bear_voice   | -3          |
    When I run the TTS generation command
    Then the system should make 4 separate TTS requests:
      | Segment | Text                                  | Model        |
      | 1       | Barnaby looked everywhere...          | storyteller  |
      | 2       | Where did I put that cookie?          | bear_voice   |
      | 3       | He searched high and low.             | storyteller  |
      | 4       | Maybe it's behind the tree!           | bear_voice   |
    And each audio segment should be saved temporarily
    And the segments should be concatenated with 50ms crossfades
    And the final output should be "ep_s1_e01_raw.wav"
    And the audio should have seamless transitions between voices

  Scenario: Apply voice effects to character audio
    Given the episode has a character "BARNABY" with settings:
      | Setting       | Value      |
      | voice_model   | bear_voice |
      | pitch_shift   | -3         |
      | speed_factor  | 0.95       |
    When audio is generated for BARNABY's dialogue
    Then the audio should be pitch-shifted down by 3 semitones
    And the audio playback speed should be 95% of normal
    And the voice should sound deeper and slower

  # ==============================================================================
  # Error Handling
  # ==============================================================================

  Scenario: Handle ai-runners service unavailable
    Given the ai-runners service is not responding at "http://localhost:8000"
    When I run the TTS generation command
    Then I should see an error "Failed to connect to ai-runners at http://localhost:8000"
    And the error should include "Check that ai-runners is running"
    And no audio file should be created
    And the episode metadata should not be modified

  Scenario: Handle TTS model failure during generation
    Given the ai-runners service is available
    But the TTS model "storyteller" returns an error "CUDA out of memory"
    When I run the TTS generation command
    Then I should see an error "TTS generation failed: CUDA out of memory"
    And the error should suggest "Try a smaller batch size or reload the model"
    And any partially generated audio files should be cleaned up
    And the episode should be marked as "failed" in a status log

  Scenario: Handle invalid character voice mapping
    Given the episode script references character "BARNABY"
    But the episode metadata does not define a voice for "BARNABY"
    When I run the TTS generation command
    Then I should see a warning "Character 'BARNABY' has no voice mapping, using default"
    And BARNABY's dialogue should be generated using the default narrator voice
    And the generation should complete successfully

  Scenario: Handle empty or invalid script
    Given the episode script file is empty
    When I run the TTS generation command
    Then I should see an error "Script file is empty"
    And no TTS request should be made to ai-runners
    And the command should exit with status code 1

  # ==============================================================================
  # Voice Model Selection
  # ==============================================================================

  Scenario: List available TTS models from ai-runners
    When I run "tts-gen --list-models"
    Then I should see a list of available models:
      | Model Name   | Type      | Language | Status |
      | xtts_v2      | XTTS      | en       | ready  |
      | storyteller  | StyleTTS2 | en       | ready  |
      | bear_voice   | XTTS      | en       | ready  |
    And each model should show its current status
    And I should be able to identify which models are ready for use

  Scenario: Test a voice model with sample text
    Given I want to preview how "bear_voice" sounds
    When I run "tts-gen --test-voice bear_voice --text 'Hello, this is a test'"
    Then ai-runners should generate a short audio sample
    And I should receive "test_bear_voice.mp3"
    And I should see "Preview saved to: test_bear_voice.mp3"
    And I can play the file to hear the voice quality

  # ==============================================================================
  # Configuration and Environment
  # ==============================================================================

  Scenario: Load TTS configuration from file
    Given a TTS config file exists at "config/tts_config.yaml" with:
      """
      ai_runners:
        endpoint: "http://192.168.1.100:8000"
        timeout: 180
      default_voice:
        model: "storyteller"
        temperature: 0.7
        language: "en"
      """
    When I run the TTS generation command
    Then the system should use "http://192.168.1.100:8000" as the ai-runners endpoint
    And requests should timeout after 180 seconds
    And the default voice should be "storyteller" with temperature 0.7

  Scenario: Override config with environment variables
    Given the config file specifies endpoint "http://localhost:8000"
    But the environment variable "AI_RUNNERS_ENDPOINT" is set to "http://192.168.1.50:9000"
    When I run the TTS generation command
    Then the system should use "http://192.168.1.50:9000" as the endpoint
    And the config file endpoint should be ignored

  # ==============================================================================
  # Progress Tracking
  # ==============================================================================

  Scenario: Display progress for long episode generation
    Given the episode script has 10 character segments
    When I run the TTS generation command
    Then I should see progress updates:
      """
      [1/10] Generating segment: NARRATOR (storyteller)
      [2/10] Generating segment: BARNABY (bear_voice)
      [3/10] Generating segment: NARRATOR (storyteller)
      ...
      [10/10] Generating segment: BARNABY (bear_voice)
      Concatenating segments...
      Finalizing audio...
      Done! Output: ep_s1_e01_raw.wav
      """
    And each progress update should show current segment and total count
    And the final message should include the output file path

  Scenario: Generate audio with verbose logging for debugging
    Given I want to debug TTS generation issues
    When I run "tts-gen --verbose" for an episode
    Then I should see detailed logs including:
      | Log Type         | Example                                    |
      | API Request      | "POST http://localhost:8000/v1/tts"        |
      | Request Payload  | "model: storyteller, text: Once upon..."   |
      | Response Time    | "TTS request completed in 2.3s"            |
      | Audio Stats      | "Generated 12.5s of audio at 24kHz"        |
      | Concatenation    | "Joining 4 segments with 50ms crossfade"   |
    And all temporary files should be logged
    And errors should include full stack traces
