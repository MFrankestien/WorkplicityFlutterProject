import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Workplicity/model/jobshot.dart';

class Joboperation {
  final Firestore _firestore = Firestore.instance;

  addJob(JobsHot jobsHot) {
    _firestore.collection('Jobs').add({
      'Job Nature':jobsHot.JobNature,
      'Job Categories':jobsHot.JobCat,
      'FirmID':jobsHot.firmid,
      'FirmName': jobsHot.companyName,
      'JobTitle': jobsHot.title,
      'JobRequirements': jobsHot.requirement,
      'Salary': jobsHot.salary,
      'Deadline': jobsHot.deadline,
      'JobDescription': jobsHot.description,
      'Education': jobsHot.education,
      'Imageurl': jobsHot.image,
      'Location': jobsHot.location,
      'Vacancy': jobsHot.vacancies
    });
  }

  Stream<QuerySnapshot> loadjob() {
    return _firestore.collection('Jobs').snapshots();
  }



deleteJob(documentId){
    _firestore.collection('Jobs').document(documentId).delete();

}

editJob(data,documentId){
  _firestore.collection('Jobs').document(documentId).updateData(data);
}

}

