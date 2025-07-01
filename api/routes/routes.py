from flask import Flask, request, jsonify, send_file
from PIL import Image
import io
import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from engines.stt_engine import stt_service
from engines.llm_engine import llm_service
from engines.tts_engine import tts_service


app =Flask(__name__)
llm_service =llm_service()
tts_service = tts_service()
stt_service = stt_service()
          
@app.route('/upload-image', methods=['POST'])
def upload_image():
    if 'image' not in request.files:
        return jsonify({'error': 'No image file found in the request'}), 400
    image_file = request.files['image']

    try:
        image = Image.open(image_file)
        predicted_class = Classifier.classify_insects(image)
        # response = predicted_class
        response = llm_service.generate_insect_info(predicted_class)
        return response, 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500


@app.route('/ask-bot', methods=['POST'])
def get_followup():
    data = (request.get_json())
    prompt = data.get('text', None)
    insect = data.get('insect', None)
    print("question", prompt)
    response = llm_service.generate_followup(insect, prompt)
    print(response)
    return response, 200
    
                                        
@app.route('/get-tts', methods=['POST'])
def get_tts():
    data = (request.get_json())
    prompt = data.get('text', None)
    print(prompt)
    
    audio_buffer = tts_service.get_TTS(prompt)
    
    if audio_buffer.getbuffer().nbytes == 0:
        return {'error': 'Audio generation failed'}, 500
    
    return send_file(
        audio_buffer,
        as_attachment=True,
        download_name='output.wav',
        mimetype='audio/wav'
    )

@app.route('/ask-bot-audio', methods = ['POST'])
def get_answer_from_audio():
    if 'audio' not in request.files:
        return "No audio file found in the request.", 400
    try:  
        audio_file = request.files['audio']
        input_audio = audio_file.read()

        input_buffer = io.BytesIO(input_audio)
        res = stt_service.transcribe_audio(input_buffer)
        
        return str(res),200
    except Exception as e:
        print(e)
        return "SERVER ERROR", 500

if(__name__ == "__main__"):
    app.run(debug=True, port = 3001)