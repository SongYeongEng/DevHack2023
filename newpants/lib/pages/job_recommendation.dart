import 'package:flutter/material.dart';
import './response_handler.dart'; // Import the ResponseHandler class

class JobRecommendationPage extends StatefulWidget {
  @override
  _JobRecommendationPageState createState() => _JobRecommendationPageState();
}

class _JobRecommendationPageState extends State<JobRecommendationPage> {
  final nameController = TextEditingController();
  final responseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Recommendation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/job-think.png'), // Replace with the path to your image asset

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
                ResponseHandler.saveResponse(nameController.text, responseController.text);
                // You can also display a confirmation message or navigate to another screen here.
              },
              child: const Text('Job Prediction'),
            ),

           
          ],
        ),
      ),
    );
  }
}
