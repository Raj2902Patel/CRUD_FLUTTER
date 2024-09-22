import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  Future createInfo(Map<String, dynamic> empInfo, String id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(id)
        .set(empInfo);
  }

  Future<Stream<QuerySnapshot>> readInfo() async {
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }
}
