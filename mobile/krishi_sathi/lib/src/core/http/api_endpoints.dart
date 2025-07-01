class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 30000);
  static const Duration receiveTimeout = Duration(seconds: 30000);

  static const String baseUrl = "http://172.20.10.5:3001/";
  //static const String baseUrl = "https://ea6d-2400-9500-c01b-3f5b-9eec-1cff-ff6a-77af.ngrok-free.app/";
  static const String uploadImage = "$baseUrl/upload-image";
  static const String getAudio = "$baseUrl/get-tts";
  static const String askBot = "$baseUrl/ask-bot";
  static const String audioTranscript = "$baseUrl/ask-bot-audio";
}
