abstract class SpeechService {
  Future<void> startListening({
    required Function(String) onResult,
    required Function() onListeningEnd,
    required Function(String) onError,
  });
} 