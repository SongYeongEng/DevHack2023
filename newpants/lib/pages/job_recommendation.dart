import 'package:flutter/material.dart';
import './response_handler.dart'; // Import the ResponseHandler class
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class JobRecommendationPage extends StatefulWidget {
  @override
  _JobRecommendationPageState createState() => _JobRecommendationPageState();
}

class _JobRecommendationPageState extends State<JobRecommendationPage> {
  final nameController = TextEditingController();
  final responseController = TextEditingController();

    final questions = [
    'I prefer working indoors',
    'I enjoy trying new adventurous activities',
    'I enjoy socializing and meeting new people',
    'I am considerate of other people\'s feelings',
    'I can handle stressful situations',
  ];

  final jobs = [
    'Fry Cook', 'IT', 'HR', 'Sales', 'Engineer', 'Chef', 'Customer Service',
    'Web Developer', 'Event Planner', 'Nurse', 'Graphic Designer', 'Teacher',
    'Accountant', 'Photographer', 'Electrician', 'Marketing Manager',
    'Project Manager', 'Pharmacist', 'Lawyer', 'Architect', 'Data Scientist'
  ];

  String matchedJob = '';

  List<double> questionResponses = [3, 3, 3, 3, 3];

  Map<String, List<double>> jobPreferences = {
    'Fry Cook': [2, 4, 1, 3, 5],
    'IT': [3, 1, 1, 4, 5],
    'HR': [3, 2, 5, 5, 3],
    'Sales': [3, 3, 5, 4, 4],
    'Engineer': [2, 3, 2, 4, 4],
    'Chef': [2, 5, 2, 2, 4],
    'Customer Service': [3, 4, 5, 4, 2],
    'Web Developer': [4, 2, 3, 4, 5],
    'Event Planner': [1, 4, 5, 4, 4],
    'Nurse': [4, 3, 4, 5, 5],
    'Graphic Designer': [3, 3, 3, 4, 4],
    'Teacher': [3, 4, 5, 4, 4],
    'Accountant': [4, 2, 3, 3, 4],
    'Photographer': [1, 3, 3, 2, 4],
    'Electrician': [2, 2, 3, 3, 4],
    'Marketing Manager': [3, 3, 5, 4, 5],
    'Project Manager': [3, 3, 4, 4, 4],
    'Pharmacist': [4, 3, 2, 5, 4],
    'Lawyer': [3, 2, 3, 4, 4],
    'Architect': [2, 2, 3, 3, 4],
    'Data Scientist': [4, 3, 3, 3, 5]
  };

  void matchJob() {
    int bestMatchIndex = 0;
    double bestMatchScore = double.maxFinite;

    for (int i = 0; i < jobs.length; i++) {
      double matchScore = 0.0;
      for (int j = 0; j < 5; j++) {
        final jobPreference = jobPreferences[jobs[i]];
        if (jobPreference != null) {
          matchScore += (questionResponses[j] - jobPreference[j]).abs();
        }
      }

      if (matchScore < bestMatchScore) {
        bestMatchScore = matchScore;
        bestMatchIndex = i;
      }
    }

    setState(() {
      matchedJob = jobs[bestMatchIndex];
    });

  

}


Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Job Matching App'),
        backgroundColor: Color.fromARGB(255, 78, 57, 76),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < 5; i++)
                    Card(
                      margin: EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              questions[i],
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Slider(
                              value: questionResponses[i],
                              onChanged: (value) {
                                setState(() {
                                  questionResponses[i] = value;
                                });
                              },
                              min: 1,
                              max: 5,
                              divisions: 4,
                              label: questionResponses[i].toString(),
                              activeColor: const Color.fromARGB(255, 158, 111, 167),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ElevatedButton(
                    onPressed: matchJob,
                    child: Text('Match Job'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                    ),
                  ),
                  if (matchedJob.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Matched Job: $matchedJob',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Image positioned on top
          Positioned(
            top: 20, // Adjust the top position
            left: 20, // Adjust the left position
            child: Image.asset(
              'assets/job-think.png', // Replace with the path to your image
              width: 100, // Adjust the width
              height: 100, // Adjust the height
            ),
          ),
        ],
      ),
    ),
  );
}

}