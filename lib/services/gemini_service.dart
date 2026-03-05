import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _systemPrompt = '''
You are a friendly AI travel assistant for the "Visit Jordan" tourism app.
Your ONLY purpose is to help users learn about tourism in Jordan.

You may ONLY discuss:
- Tourist attractions in Jordan (Petra, Wadi Rum, Dead Sea, Jerash, Amman, Aqaba, Madaba, Ajloun, etc.)
- Travel routes and itineraries within Jordan
- Best times to visit Jordan
- Jordanian food and cuisine
- Jordanian culture, history, and heritage
- Visa and entry requirements for Jordan
- Accommodation and transport in Jordan
- Practical travel tips for visiting Jordan

If the user asks about ANYTHING unrelated to Jordan tourism (e.g. other countries, general knowledge, coding, politics, personal advice, etc.), politely decline and redirect them back to Jordan travel topics.

Keep responses concise, friendly, and use relevant emojis. Always encourage users to visit Jordan.
Start every response in a helpful, warm tone. Never go off-topic.
''';

  GenerativeModel? _model;
  ChatSession? _chat;
  String? _currentApiKey;

  bool get isInitialised => _model != null;

  void initialise(String apiKey) {
    _currentApiKey = apiKey;
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(_systemPrompt),
      generationConfig: GenerationConfig(
        temperature: 0.7,
        maxOutputTokens: 512,
      ),
    );
    _chat = _model!.startChat();
  }

  void reset() {
    if (_model != null) {
      _chat = _model!.startChat();
    }
  }

  Future<String> sendMessage(String message) async {
    if (_chat == null) {
      throw Exception('Gemini not initialised. Please set your API key first.');
    }
    try {
      final response = await _chat!.sendMessage(Content.text(message));
      return response.text ?? 'Sorry, I could not generate a response. Please try again.';
    } on GenerativeAIException catch (e) {
      final msg = e.message.toLowerCase();
      if (msg.contains('api key') || msg.contains('invalid') || msg.contains('api_key_invalid')) {
        throw Exception('invalid_key');
      }
      // Surface the actual Gemini error message so we can debug it
      throw Exception('Gemini error: ${e.message}');
    }
    // Do NOT have a catch-all — let socket/network errors surface naturally
  }

  String? get currentApiKey => _currentApiKey;
}

// Singleton instance
final geminiService = GeminiService();
