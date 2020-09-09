import 'package:Workplicity/model/JobSeeker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobSeekerOperaations{
  final Firestore _firestore = Firestore.instance;

  addCv(JobSeeker jobSeeker){

    _firestore.collection('Applicants').add({
      'First Name':jobSeeker.fname,
      'Last Name':jobSeeker.lname,
      'Imageurl': jobSeeker.imageurl,
      'City': jobSeeker.City,
      'Full Adress': jobSeeker.FullAdress,
      'Email': jobSeeker.Email,
      'Phone': jobSeeker.Phone,
      'Gender': jobSeeker.gender,
      'Objective': jobSeeker.Objective,
      'NationalID ':jobSeeker..nationalid,
      'Religion': jobSeeker.religon,
      'Institute Name': jobSeeker.InstituteName,
      'Education Level': jobSeeker.EducationLvl,
      'Result': jobSeeker.Result,
      'Passing Year': jobSeeker.PassingYear,
      'Company Name': jobSeeker.CompanyName,
      'Department': jobSeeker.Department,
      'Responsibilities': jobSeeker.Responsabilities,
      'Start Date': jobSeeker.StartingYear,
      'End Date': jobSeeker.EndYear,
      'First Language': jobSeeker.FirstLangauge,
      'Read Level One': jobSeeker.FirstLangReadingLvl,
      'Wirte Level One': jobSeeker.FirstLanguageWritingLvl,
      'Speak Level Second': jobSeeker.SecondLanguageSpeakingLvl,
      'FirmID':jobSeeker.FirmId,
      'JobID': jobSeeker.Jobid,
      'Second Language': jobSeeker.SecondLangauge,
      'Read Level Second': jobSeeker.SecondLangReadingLvl,
      'Write Level Second': jobSeeker.SecondLanguageWritingLvl,
      'Speak level One': jobSeeker.FirstLanguageSpeakingLvl,
      'Expected Salary': jobSeeker.ExpectedSalary,
      'Present Salary': jobSeeker.PresentSalary,
      'DOB': jobSeeker.date,

    });
  }
  deletecv(documentId){
    _firestore.collection('Applicants').document(documentId).delete();

  }

}