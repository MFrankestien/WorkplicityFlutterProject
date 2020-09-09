import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference jobseekersCollection =
      Firestore.instance.collection('Users');
  final CollectionReference FirmCollection =
      Firestore.instance.collection('Users');
  final CollectionReference job =
  Firestore.instance.collection('Jobs');






  // Updating User Data
  Future<void> updateUserData(
      String fName, String lName, String jobtype, String gender) async {
    return await jobseekersCollection.document(uid).setData({
      'FirstName': fName,
      'LastName': lName,
      'UserType': jobtype,
      'Gender': gender
    });
  }



  Future<void> updateJobSeekerData(String fName, String lName, String phone,
      String usertype, String jobtype, String gender) async {
    return await jobseekersCollection.document(uid).setData({
      'FirstName': fName,
      'LastName': lName,
      'Phone': phone,
      'UserType': usertype,
      'JobType': jobtype,
      'Gender': gender
    });
  }



  Future<void> updateFirmData(
    String fName,
    String lName,
    String title,
    String usertype,
  ) async {
    return await FirmCollection.document(uid).setData({
      'FirstName': fName,
      'LastName': lName,
      'Title': title,
      'UserType': usertype,
    });
  }
}
