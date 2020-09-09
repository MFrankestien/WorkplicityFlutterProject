
import 'package:Workplicity/model/user.dart';
import 'package:Workplicity/screens/JobSeeker/profile_main.dart';
import 'package:Workplicity/screens/main_menu/AppliedJobs.dart';
import 'package:Workplicity/services/JoobSeekerServicies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/model/jobshot.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class JobDetailsPage extends StatefulWidget {
  final JobsHot jobsHot;
  bool show;


  JobDetailsPage({this.jobsHot,this.show});

  @override
  _JobDetailsPageState createState() => _JobDetailsPageState(show);
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  String apply='Apply for job';
  bool show;

  _JobDetailsPageState(this.show);

  final  _Jobseeker = JobSeekerOperaations();
  String Fname,Lname,Imageurl,name,userid,City,FullAdress,Email,Phone,gender,JobLevel,JobNature,Objective,nationalid,religon;
  String InstituteName,EducationLvl,Result,PassingYear,CompanyName,Department,Responsabilities,StartingYear,EndYear,ExpectedSalary,PresentSalary;
  String FirstLangauge,FirstLangReadingLvl,FirstLanguageWritingLvl,FirstLanguageSpeakingLvl;
  String SecondLangauge,SecondLangReadingLvl,SecondLanguageWritingLvl,SecondLanguageSpeakingLvl;

  DateTime date ;

  @override
  void initState() {
    super.initState();
    loadprofile();

  }

  var myFormat = DateFormat('d-MM-yyyy');
  loadprofile() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {
        ExpectedSalary=DocumentSnapshot.data['ExpectedSalary'];
        PresentSalary=DocumentSnapshot.data['PresentSalary'];
        Fname = DocumentSnapshot.data['FirstName'];
        Lname = DocumentSnapshot.data['LastName'];
        Imageurl = DocumentSnapshot.data['ImageURL'];
        City=DocumentSnapshot.data['Location'];
        FullAdress=DocumentSnapshot.data['Fulladress'];
        gender=DocumentSnapshot.data['Gender'];
        date=DocumentSnapshot.data['DOB'].toDate();
        Email=DocumentSnapshot.data['Email'];
        Phone=DocumentSnapshot.data['Phone'];
        name = '$Fname $Lname';
        JobNature = DocumentSnapshot.data['JobNature'];
        JobLevel = DocumentSnapshot.data['JobLevel'];
        Objective = DocumentSnapshot.data['Objective'];
        InstituteName = DocumentSnapshot.data['Institute Name'];
        EducationLvl = DocumentSnapshot.data['Education Level'];
        Result = DocumentSnapshot.data['Result'];
        PassingYear = DocumentSnapshot.data['Passing Year'];
        CompanyName = DocumentSnapshot.data['Company Name'];
        Department = DocumentSnapshot.data['Department'];
        Responsabilities = DocumentSnapshot.data['Responsibilities'];
        StartingYear = DocumentSnapshot.data['Start Date'];
        EndYear = DocumentSnapshot.data['End Date'];
        nationalid=DocumentSnapshot.data['National ID'];
        religon=DocumentSnapshot.data['Religion'];

        ///////////////////////////////////////////////////Language/////////////////////////////////////////
        FirstLangauge = DocumentSnapshot.data['First Language'];
        FirstLangReadingLvl = DocumentSnapshot.data['Read Level'];
        FirstLanguageWritingLvl = DocumentSnapshot.data['Write Level'];
        FirstLanguageSpeakingLvl = DocumentSnapshot.data['Speak level'];
        SecondLangauge = DocumentSnapshot.data['Second Language'];
        SecondLangReadingLvl = DocumentSnapshot.data['Second Read Level'];
        SecondLanguageWritingLvl = DocumentSnapshot.data['Second Write Level'];
        SecondLanguageSpeakingLvl = DocumentSnapshot.data['Second Speak level'];

        print(date);
        print(Lname);
        print(Fname);
      }

      );

    });}







  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image(
                  width: 100.0,
                  height: 100.0,
                  image: (widget.jobsHot.image!=null)?NetworkImage(widget.jobsHot.image):AssetImage(
                      'assets/images/jobdefault.png'),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.jobsHot.companyName,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          child: new Divider(color: Colors.blueGrey),
        ),
        SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            widget.jobsHot.title,
            style: TextStyle(color: Colors.white, fontSize: 25.0),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '💲 Salary:',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Text(
                      widget.jobsHot.salary,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '👥 Vacancies:',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Text(
                      widget.jobsHot.vacancies,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '🎓 Education:',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Text(
                      widget.jobsHot.education,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      '📋 Job Nature:',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Text(
                      widget.jobsHot.JobNature,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '📍 Location:',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                    Text(
                      widget.jobsHot.location,
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Center(
            child: topContentText,
          ),
        ),
      ],
    );

    final bottomContentText = Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Job Information",
            style: TextStyle(fontSize: 25.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Job Descrption / Responsibility",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Text(
                widget.jobsHot.description,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(height: 50,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  "Job Requirements",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Text(
                widget.jobsHot.requirement,
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap:show? () async {
                  if(Fname==null||Lname==null||Phone==null||FullAdress==null||Email==null||gender==null||City==null||Imageurl==null||EducationLvl==null||PassingYear==null||Result==null||InstituteName==null||Objective==null||JobNature==null||JobLevel==null||religon==null||nationalid==null){
                    Fluttertoast.showToast(
                        msg: "Please complete profile to apply",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 10,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 20.0
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfileMain()));
                  }
                  else {
                    FirebaseUser user = await FirebaseAuth.instance.currentUser();
                    Firestore.instance.collection('Applicants').add({
                      'UserId':user.uid,
                      'Imageurl': Imageurl,
                      'First Name':Fname,
                      'Last Name':Lname,
                      'FirmID':widget.jobsHot.firmid,
                      'JobID': widget.jobsHot.jobId,
                      'NationalID ':nationalid,
                      'Company Name': CompanyName,
                      'DOB': date,
                      'Department': Department,
                      'Email': Email,
                      'Education Level': EducationLvl,
                      'End Date': EndYear,
                      'Start Date': StartingYear,
                      'Expected Salary': ExpectedSalary,
                      'First Language': FirstLangauge,
                      'Full Adress': FullAdress,
                      'Gender': gender,
                      'Institute Name': InstituteName,
                      'City':City,
                      'Objective':Objective,
                      'Passing Year': PassingYear,
                      'Phone': Phone,
                      'Present Salary': PresentSalary,
                      'Read Level One': FirstLangReadingLvl,
                      'Speak level One': FirstLanguageSpeakingLvl,
                      'Wirte Level One': FirstLanguageWritingLvl,
                      'Second Language': SecondLangauge,
                      'Read Level Second': SecondLangReadingLvl,
                      'Speak Level Second': SecondLanguageSpeakingLvl,
                      'Write Level Second': SecondLanguageWritingLvl,
                      'Religion': religon,
                      'Responsibilities':Responsabilities,
                      'Result': Result,
                      'Accepted': false,
                      'FirmName':widget.jobsHot.companyName,
                      'FImageurl':widget.jobsHot.image,
                      'Deadline':widget.jobsHot.deadline,
                      'Education':widget.jobsHot.education,
                      'Job Nature':widget.jobsHot.JobNature,
                      'JobDescription':widget.jobsHot.description,
                      'JobRequirement':widget.jobsHot.requirement,
                      'JobTitle':widget.jobsHot.title,
                      'Location':widget.jobsHot.location,
                      'Salary':widget.jobsHot.salary,
                      'Vacancy':widget.jobsHot.vacancies,




                    });
                    Fluttertoast.showToast(
                        msg: "You Applied To This Job Successfully",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 10,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 20.0
                    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AppliedJobs()));

                  }}:(){
                  Fluttertoast.showToast(
                      msg: "You Already Applied To This Job",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 10,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 20.0
                  );
                }

                ,
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF203354),
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                      ],

                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(5, 5),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      apply,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),


        ],
      ),
    );


        return  Scaffold(
          appBar: JobSeekerHeader(context, titleText: 'Job Details'),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[topContent, bottomContentText],
            ),
          ),
        );

  }
}
