import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import 'package:camera/camera.dart';

class SpeechRecognitionPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  SpeechRecognitionPage(this.cameras);

  @override
  _SpeechRecognitionPageState createState() => _SpeechRecognitionPageState();
}

class _SpeechRecognitionPageState extends State<SpeechRecognitionPage> {
  final speech = SpeechToText();
  final translator = GoogleTranslator();
  late CameraController _cameraController;
  String recognizedText = "Recognized text will appear here.";
  bool isListening = false;
  int currentQuestionIndex = 0;
  final List<String> interviewQuestions = [
    "Tell me about yourself.",
    "What are your strengths?",
    "What are your weaknesses?",
    "Why do you want to work here?",
    "You can submit your response, thanks.",
  ];


  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.cameras[0], ResolutionPreset.medium);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

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

void nextQuestion() {
  setState(() {
    if (currentQuestionIndex >= 3) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('All Questions Answered'),
            content: Text('You have answered all the questions. Feel free to submit. Thanks.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );

      return; // Stop here
    }

    currentQuestionIndex = (currentQuestionIndex + 1);
    recognizedText = "Recognized text will appear here.";
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
      title: Text('Speech Recognition and Camera'),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.start, // Align elements to the top
      children: <Widget>[
        Container(
          width: 300,
          height: 200,
          child: _cameraController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _cameraController.value.aspectRatio,
                  child: CameraPreview(_cameraController),
                )
              : CircularProgressIndicator(),
        ),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Interview Question:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              interviewQuestions[currentQuestionIndex],
              style: TextStyle(fontSize: 18),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Recognized Text:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            recognizedText,
            style: TextStyle(fontSize: 18),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            startListening();
          },
          child: Text('Start Recording'),
        ),
        ElevatedButton(
            onPressed: () {
              nextQuestion();
            },
            child: Text('Next Question'),
        ),
          ElevatedButton(
            onPressed: () {
              stopListening();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Submission Successful'),
                    content: Text('Your responses have been successfully submitted. Thank you!'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text('Submit'),
          ),
      ],
    ),
  );
}
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MaterialApp(home: SpeechRecognitionPage(cameras)));
}
