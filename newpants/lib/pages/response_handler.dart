import 'package:cloud_firestore/cloud_firestore.dart';

class ResponseHandler {
  static Future<void> saveResponse(String name, String response) async {
    CollectionReference collRef = FirebaseFirestore.instance.collection('client');
    await collRef.add({
      'name': name,
      'response': response,
    });
  }
}
