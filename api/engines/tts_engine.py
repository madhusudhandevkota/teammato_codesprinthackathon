from elevenlabs import VoiceSettings
from elevenlabs.client import ElevenLabs
from pydub import AudioSegment
from pydub.playback import play
import io

class tts_service:
    def __init__(self):
        self.client = ElevenLabs(api_key="sk_121b99b0809b125747b991d227527dee12b6dd73f930b9eb")
        
    def get_TTS(self,text):
        # audio_buffer = io.BytesIO()
        # response = self.client.text_to_speech.convert(
        #     voice_id="IKne3meq5aSn9XLyUdCD",
        #     optimize_streaming_latency="0",
        #     output_format="mp3_22050_32",
        #     text=text,
        #     voice_settings=VoiceSettings(
        #         stability=0.1,
        #         similarity_boost=0.3,
        #         style=0.2,
        #     ),
        # )

        # for chunk in response:
        #     audio_buffer.write(chunk)
        # audio_buffer.seek(0) 
        
        # audio = AudioSegment.from_mp3(audio_buffer)
        # play(audio)
        audio_buffer = io.BytesIO()
        
        with open('output.wav', 'rb') as file:
            for chunk in iter(lambda: file.read(4096), b''):
                audio_buffer.write(chunk)
        audio_buffer.seek(0)
        return audio_buffer


