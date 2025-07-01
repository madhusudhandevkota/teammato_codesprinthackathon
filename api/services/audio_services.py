from google.cloud import speech_v1p1beta1 as speech
import io
import os
import sys
import ffmpeg
from pydub import AudioSegment

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = "/home/crazyanonymous/Krishi Sathi/Krishi-Sathi/api/services/keys/myprojecthackathonnec-e45dedae8996.json"

def convert_audio(input_file):
    try:
        ffmpeg.input(input_file).output(
            "output.wav",
            format="wav",     
            acodec="pcm_s16le", 
            ac=1,            
            ar="16000"       
        ).run(overwrite_output=True)
        print(f"Conversion successful! File saved to: {input_file}")
    except Exception as e:
        print(f"Error during conversion : e")

def convert_audio_from_buffer(input_buffer):
    output_buffer = io.BytesIO()

    try:
        process = (
            ffmpeg
            .input('pipe:0')
            .output('pipe:1', format="wav", acodec="pcm_s16le", ac=1, ar="16000")
            .run_async(pipe_stdin=True, pipe_stdout=True, pipe_stderr=True)
        )

        wav_output, stderr = process.communicate(input=input_buffer.getvalue())

        output_buffer.write(wav_output)
        output_buffer.seek(0)
        
        print("Conversion successful!")
        return output_buffer
    except ffmpeg.Error as e:
        error_message = e.stderr.decode()
        print(f"Error during conversion: {error_message}")
        return None

def convert_audio_to_linear16(input_buffer):
    try:    
        audio = AudioSegment.from_file(input_buffer)
        converted_audio = audio.set_frame_rate(16000).set_channels(1).set_sample_width(2)

        output_buffer = io.BytesIO()
        converted_audio.export(output_buffer, format="wav")

        output_buffer.seek(0)
        return output_buffer.read()
    except Exception as e:
        print(e)
        return None

def create_buffer(file_path):
    audio_buffer = io.BytesIO()
    with io.open('output.wav', "rb") as audio_file:
        content = audio_file.read()
        for chunk in iter(lambda: audio_file.read(4096), b''):
                audio_buffer.write(chunk)
    return audio_buffer
