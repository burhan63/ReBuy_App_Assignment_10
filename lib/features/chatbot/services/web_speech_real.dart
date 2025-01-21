// Only used on web platform
import 'speech_service.dart';
import 'dart:js' as js;

class WebSpeech implements SpeechService {
  @override
  Future<void> startListening({
    required Function(String) onResult,
    required Function() onListeningEnd,
    required Function(String) onError,
  }) async {
    try {
      final recognition = js.JsObject(js.context['webkitSpeechRecognition']);
      recognition['continuous'] = false;
      recognition['interimResults'] = false;
      recognition['lang'] = 'en-US';

      bool hasProcessedResult = false;

      recognition['onresult'] = js.allowInterop((dynamic event) {
        final results = js.JsObject.fromBrowserObject(event)['results'];
        if (results != null && !hasProcessedResult) {
          final firstResult = js.JsObject.fromBrowserObject(results[0]);
          final firstAlternative = js.JsObject.fromBrowserObject(firstResult[0]);
          final transcript = firstAlternative['transcript'];
          
          if (transcript != null) {
            hasProcessedResult = true;
            onResult(transcript.toString());
          }
        }
      });

      recognition['onerror'] = js.allowInterop((dynamic event) {
        onError('Speech recognition error');
      });

      recognition['onend'] = js.allowInterop((_) {
        onListeningEnd();
      });

      recognition.callMethod('start');
    } catch (e) {
      onError('Speech recognition not available');
    }
  }
} 