import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String currentImage = 'assets/splash1.png'; // Initial image

  @override
  void initState() {
    super.initState();

    // After 2 seconds, change the image
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        currentImage = 'assets/splash2.png'; // New image
      });

      // After another 2 seconds, navigate to the main page
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed('/home');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color as needed
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(seconds: 2), // Duration of the transition
          child: Image.asset(
            currentImage,
            key: Key(currentImage), // Key to identify changes in the widget
          ),
          // Use a fade transition for smoother image transition
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
