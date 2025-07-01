from google.cloud import speech_v1p1beta1 as speech
import io
import os
import ffmpeg
import pydub
from services.audio_services import convert_audio_from_buffer, convert_audio_to_linear16


class stt_service:
    
    def __init__(self):
        self.client = speech.SpeechClient()
        os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/home/crazyanonymous/Krishi Sathi/Krishi-Sathi/api/services/keys/myprojecthackathonnec-e45dedae8996.json"
        
    def transcribe_audio(self, input_buffer):
        res = ""
        try:
            # content = convert_audio_from_buffer(input_buffer)
            # with io.open('audio_nep.wav', "rb") as audio_file:
                # content = audio_file.read()
            content = convert_audio_to_linear16(input_buffer)
            print(type(content))
            audio = speech.RecognitionAudio(content=content)
            config = speech.RecognitionConfig(
                encoding=speech.RecognitionConfig.AudioEncoding.LINEAR16,
                sample_rate_hertz=16000,  
                language_code="ne-NP"     
            )

            response = self.client.recognize(config=config, audio=audio)
            
            for result in response.results:
                print("Transcript: {}".format(result.alternatives[0].transcript))
                res = res + format(result.alternatives[0].transcript)
        except Exception as e:
            print("ERRPR", e)
        finally:
            return res
            
    def test_google_authentication(self):
        try:
            client = speech.SpeechClient()
            print("Google Cloud Speech-to-Text API authentication successful!")
        except Exception as e:
            print("Authentication failed:", e)
