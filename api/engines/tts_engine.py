from elevenlabs import VoiceSettings
from elevenlabs.client import ElevenLabs
from pydub import AudioSegment
from pydub.playback import play
import io

class tts_service:
    def __init__(self):
        self.client = ElevenLabs(api_key="sk_ac41edf2edceb23c7a4adfa9d3c25c767519cd0f0411c789")
        
    def get_TTS(self, text):
        audio_buffer = io.BytesIO()
        response = self.client.text_to_speech.convert(
            voice_id="IKne3meq5aSn9XLyUdCD",
            optimize_streaming_latency="0",
            output_format="mp3_22050_32",
            text=text,
            voice_settings=VoiceSettings(
                stability=0.1,
                similarity_boost=0.3,
                style=0.2,
            ),
        )
        # Write MP3 data to buffer
        for chunk in response:
            audio_buffer.write(chunk)
        audio_buffer.seek(0)

        # Convert MP3 buffer to WAV buffer using pydub
        mp3_audio = AudioSegment.from_file(audio_buffer, format="mp3")
        wav_buffer = io.BytesIO()
        mp3_audio.export(wav_buffer, format="wav")
        wav_buffer.seek(0)

        # (Optional) Play audio for debugging
        # play(mp3_audio)

        return wav_buffer


