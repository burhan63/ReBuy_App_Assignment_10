import 'speech_service.dart';

class WebSpeech implements SpeechService {
  @override
  Future<void> startListening({
    required Function(String) onResult,
    required Function() onListeningEnd,
    required Function(String) onError,
  }) async {
    onError('Web speech is only available in browsers');
  }
} 