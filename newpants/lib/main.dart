import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './pages/jobs.dart';
import './pages/splash_screen.dart';

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

  
  final nameController = TextEditingController();
  final responseController = TextEditingController();


  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        
        child: Column(
    
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: responseController,
              decoration: const InputDecoration(labelText: 'Response'),
            ),

            ElevatedButton(
            onPressed: () {
              // Define the action to be taken when the button is pressed.
              CollectionReference collRef = FirebaseFirestore.instance.collection('client');
              collRef.add({
                'name': nameController.text,
                'response': responseController.text,
              });

            },
            child: const Text('Add Response')),


            ElevatedButton(
            onPressed: () {
              // Push the SecondScreen onto the navigation stack when the button is pressed.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobsScreen()),
              );
            },
            child: const Text('Go to Second Screen'),),

          ],
        ),
      ),
    );
  }
}
