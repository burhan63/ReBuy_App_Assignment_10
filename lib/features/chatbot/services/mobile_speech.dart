import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'speech_service.dart';

class MobileSpeech implements SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _hasProcessedResult = false;

  @override
  Future<void> startListening({
    required Function(String) onResult,
    required Function() onListeningEnd,
    required Function(String) onError,
  }) async {
    try {
      _hasProcessedResult = false;
      bool available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            onListeningEnd();
          }
        },
        onError: (error) => onError(error.errorMsg),
      );

      if (available) {
        await _speech.listen(
          onResult: (result) {
            if (result.finalResult && !_hasProcessedResult) {
              _hasProcessedResult = true;
              onResult(result.recognizedWords);
            }
          },
          listenFor: const Duration(seconds: 30),
          pauseFor: const Duration(seconds: 3),
          cancelOnError: true,
        );
      } else {
        onError('Speech recognition not available on device');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
} 