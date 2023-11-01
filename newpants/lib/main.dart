import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(JobMatchingApp());
}

class JobMatchingApp extends StatefulWidget {
  @override
  _JobMatchingAppState createState() => _JobMatchingAppState();
}

class _JobMatchingAppState extends State<JobMatchingApp> {
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
    // Add your job preferences data here...
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Job Matching App'),
          backgroundColor: Color.fromARGB(255, 78, 57, 76), // Change the app bar color.
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                for (int i = 0; i < 5; i++)
                  Card(
                    margin: EdgeInsets.all(16), // Add some margin around each card.
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(questions[i],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Slider(
                            value: questionResponses[i],
                            onChanged: (value) {
                              setState(() {
                                questionResponses[i] = value;
                              });
                            },
                            min: 1, // Adjust the scale min value.
                            max: 5, // Adjust the scale max value.
                            divisions: 4, // Divide the scale into 4 steps.
                            label: questionResponses[i].toString(),
                            activeColor: const Color.fromARGB(255, 158, 111, 167), // Set the active color.
                          ),
                        ],
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: matchJob,
                  child: Text('Match Job'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal, // Change the button color.
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
      ),
    );
  }
}
