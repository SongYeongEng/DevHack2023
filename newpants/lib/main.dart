import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import './pages/jobs.dart';
import './pages/job_recommendation.dart';
import './pages/splash_screen.dart';
import './pages/speechTest.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'YOUR_API_KEY',
      appId: '1:415578718144:android:083523c6b2521e0add9225',
      messagingSenderId: '415578718144',
      projectId: 'devhack2023-ebaf9',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: SplashScreen(), // Set SplashScreen as the initial screen
      routes: {
        '/home': (context) => MyHomePage(title: 'Flutter Demo Home Page'), // Your main content page
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
    
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
       
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobRecommendationPage()),
              );
            },
            child: const Text('Job Prediction'),),


            ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobsScreen()),
              );
            },
            child: const Text('Go Job List'),),

            ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SpeechRecognitionPage()),
              );
            },
            child: const Text('Speech Test'),),
          ],
        ),
      ),
    );
  }
}
