import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';

class SpeechRecognitionPage extends StatefulWidget {
  @override
  _SpeechRecognitionPageState createState() => _SpeechRecognitionPageState();
}

class _SpeechRecognitionPageState extends State<SpeechRecognitionPage> {
  final speech = SpeechToText();
  final translator = GoogleTranslator();
  String recognizedText = "Recognized text will appear here.";
  bool isListening = false;

  Future<void> startListening() async {
    if (!isListening) {
      if (await speech.initialize()) {
        await speech.listen(
          onResult: (result) {
            if (result.recognizedWords != null && result.recognizedWords.isNotEmpty) {
              translateAndDisplayText(result.recognizedWords);
            }
          },
        );
        setState(() {
          isListening = true;
        });
      }
    }
  }

  Future<void> stopListening() async {
    if (isListening) {
      await speech.stop();
      setState(() {
        isListening = false;
      });
    }
  }

  Future<void> translateAndDisplayText(String text) async {
    final translation = await translateText(text, to: 'en');
    setState(() {
      recognizedText = translation;
    });
  }

  Future<String> translateText(String text, {String to = 'en'}) async {
    Translation translation = await translator.translate(text, to: to);
    return translation.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Recognition and Translation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Recognized Text:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              recognizedText,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                startListening();
              },
              child: Text('Start Recording'),
            ),
            ElevatedButton(
              onPressed: () {
                stopListening();
              },
              child: Text('Stop Recording'),
            ),
          ],
        ),
      ),
    );
  }
}
