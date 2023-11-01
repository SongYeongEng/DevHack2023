import 'package:flutter/material.dart';
import '../jobClass.dart';
import '../firebaseStore.dart';

class JobsScreen extends StatefulWidget {
  @override
  _JobsScreenState createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  List<Job> jobs = [];

  @override
  void initState() {
    super.initState();
    // Load job data from Firestore when this screen is initialized
    _loadJobData();
  }

  _loadJobData() async {
    List<Job> jobList = await FirebaseService().getJobs();
    setState(() {
      jobs = jobList;
    });
  }

  void _showAddJobDialog(BuildContext context) {
    Job newJob = Job(
      jobClass: '', // Initialize with an empty string or any default value
      companyName: '', // Initialize with an empty string or any default value
      jobDescription: '', // Initialize with an empty string or any default value
    ); // Create an empty job or initialize with default values
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Job'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                onChanged: (value) {
                  newJob.jobClass = value;
                },
                decoration: InputDecoration(labelText: 'Job Title'),
              ),
              TextFormField(
                onChanged: (value) {
                  newJob.companyName = value;
                },
                decoration: InputDecoration(labelText: 'Company Name'),
              ),
              TextFormField(
                onChanged: (value) {
                  newJob.jobDescription = value;
                },
                decoration: InputDecoration(labelText: 'Job Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                FirebaseService().addJob(newJob).then((_) {
                  // Trigger a refresh of the JobsScreen after adding the job.
                  _loadJobData();
                  Navigator.of(context).pop();
                });
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void refresh() {
    // Refresh the page by loading job data again
    _loadJobData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          Job job = jobs[index];
          return Card(
            child: ExpansionTile(
              title: Text(job.jobClass),
              children: <Widget>[
                ListTile(
                       title: Text("Company Name: ${job.companyName}"),
                     ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(job.jobDescription),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Define what happens when the button is pressed
                    // This is where you can add the button's functionality
                  },
                  child: Text('Apply'), // The text displayed on the button
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddJobDialog(context);
        },
        tooltip: 'Add Job',
        child: Icon(Icons.add),
      ),
    );
  }
}
