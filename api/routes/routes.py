from flask import Flask, request, jsonify, send_file, Blueprint
from PIL import Image
import io
import sys
import os
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from engines.stt_engine import stt_service
from engines.llm_engine import llm_service
from engines.tts_engine import tts_service
from engines.classifier_engine import Classifier
from pyngrok import ngrok

# Create Blueprint with /api prefix
api_bp = Blueprint('api', __name__, url_prefix='/api')

llm_service = llm_service()
tts_service = tts_service()
stt_service = stt_service()
          
@api_bp.route('/upload-image', methods=['POST'])
def upload_image():
    if 'image' not in request.files:
        return jsonify({'error': 'No image file found in the request'}), 400
    image_file = request.files['image']

    try:
        image = Image.open(image_file)
        predicted_class = Classifier.classify_insects(image)
        response = llm_service.generate_insect_info(predicted_class)
        return response, 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500


@api_bp.route('/ask-bot', methods=['POST'])
def get_followup():
    data = (request.get_json())
    prompt = data.get('text', None)
    insect = data.get('insect', None)
    print("question", prompt)
    response = llm_service.generate_followup(insect, prompt)
    print(response)
    return response, 200
    
                                        
@api_bp.route('/get-tts', methods=['POST'])
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

@api_bp.route('/ask-bot-audio', methods = ['POST'])
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
    

app = Flask(__name__)
app.register_blueprint(api_bp)

if(__name__ == "__main__"):
    #ngrok.set_auth_token("2zGZUFfEsQ6mqXbUH10181VVMCO_5WiRd157VZn9CfeXxZBj9")
    #public_url = ngrok.connect(3001)
    #print(" * ngrok tunnel URL:", public_url)
    app.run(debug=True, port=3001, host="0.0.0.0")

    