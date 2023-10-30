import 'package:cloud_firestore/cloud_firestore.dart';
import 'jobClass.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Job>> getJobs() async {
    QuerySnapshot querySnapshot = await _firestore.collection('jobList').get();
    List<Job> jobs = [];

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        jobs.add(Job.fromMap(data));
      }
    });

    return jobs;
  }

  Future<void> addJob(Job job) async {
    await _firestore.collection('jobList').add({
      'jobClass': job.jobClass, 
       'companyName': job.companyName, 
       'jobDescription': job.jobDescription, // Replace 'title' with the actual field name in your Firestore
      // Add other job properties as needed
    });
  }
}
