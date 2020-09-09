import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Workplicity/model/jobshot.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/widgets/header.dart';


class JobSeekerShowProfile extends StatefulWidget {
  final JobsHot jobsHot;
  JobSeekerShowProfile({this.jobsHot});
  @override
  _JobSeekerShowProfileState createState() => _JobSeekerShowProfileState();
}

class _JobSeekerShowProfileState extends State<JobSeekerShowProfile> {
  String Fname,Lname,Firmname,Imageurl,name,Title,City,FullAdress,Email,Phone,gender,JobLevel,JobNature,Objective;
  String InstituteName,EducationLvl,Result,PassingYear,CompanyName,Department,Responsabilities,StartingYear,EndYear;
  String FirstLangauge,FirstLangReadingLvl,FirstLanguageWritingLvl,FirstLanguageSpeakingLvl;
  String SecondLangauge,SecondLangReadingLvl,SecondLanguageWritingLvl,SecondLanguageSpeakingLvl;
  String expectedSalary,nationalID,religion,presentSalary;
  DateTime date ;
  var myFormat = DateFormat('d-MM-yyyy');

  load() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {
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
        expectedSalary = DocumentSnapshot.data['ExpectedSalary'];
        nationalID = DocumentSnapshot.data['NationalID'];
        religion = DocumentSnapshot.data['Religion'];
        presentSalary = DocumentSnapshot.data['PresentSalary'];

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
        print(Firmname);
      }

      );

    });}

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Image(
                      width: 100.0,
                      height: 100.0,
                      image: (Imageurl!=null)?NetworkImage(Imageurl):NetworkImage(
                        'https://i.stack.imgur.com/l60Hf.png',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10,left: 8,bottom:8,right: 8),
                          child: (Firmname!=null)?Text(
                            '$Firmname Organization',
                            style: TextStyle(
                                fontSize: 25.0, color: Colors.white),
                          ):  SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          child: new Divider(color: Colors.blueGrey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (name!=null)?Text(
                            name,
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ):  SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: (Title!=null)?Text(
                            Title,
                            style: TextStyle(
                                fontSize: 18.0, color: Colors.white),
                          ):  SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        ClipPath(
          clipBehavior: Clip.antiAlias,
          clipper: HomeClipper2(),
          child:  Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: topContentText,
            ),
          ),
        ),

      ],
    );

    final bottomContentText = Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ////Personal Information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Personal Information:',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(
                children: <Widget>[

                Expanded(
                  flex: 2,
                  child: Text(
                    '📅 Date Of Birth:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (date!=null)?Text(
                    myFormat.format(date),
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '👨👩 Gender:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (gender!=null)?Text(
                    gender,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    ' 🙏 Religion:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (religion!=null)?Text(
                    religion,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    ' ║▌ National ID:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (nationalID!=null)?Text(
                    nationalID,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),

            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          /////////////////////////////////////Contact Information/////////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Contact Information:',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '📍 City:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (City!=null)?Text(
                    City,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '🏢 Address:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (FullAdress!=null)?Text(
                    FullAdress,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '📞 Phone:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (Phone!=null)?Text(
                    Phone,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '📧 E-mail:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (Email!=null)?Text(
                    Email,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          /////////////////////////////////////Career Application/////////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Career Information:',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'My Objective:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (Objective!=null)?Text(
                    Objective,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Looking for Job Level of:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (JobLevel!=null)?Text(
                    JobLevel,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Looking for Job Nature of:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (JobNature!=null)?Text(
                    JobNature,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Present Salary:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (presentSalary!=null)?Text(
                    presentSalary,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Expected Salary:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (expectedSalary!=null)?Text(
                    expectedSalary,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),

            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),

          /////////////////////////////////////Education/////////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Academic Qualifications :',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Institute Name:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (InstituteName!=null)?Text(
                    InstituteName,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Academic Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (EducationLvl!=null)?Text(
                    EducationLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Result:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (Result!=null)?Text(
                    Result,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Passing Year:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (PassingYear!=null)?Text(
                    PassingYear,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          /////////////////////////////////////Employment History/////////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Employment History :',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Company Name:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (CompanyName!=null)?Text(
                    CompanyName,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Department:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (Department!=null)?Text(
                    Department,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Responsibilities:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (Responsabilities!=null)?Text(
                    Responsabilities,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Start Year:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (StartingYear!=null)?Text(
                    StartingYear,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'End Year:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (EndYear!=null)?Text(
                    EndYear,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,)
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          /////////////////////////////////////Language Proficiency//////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Language Proficiency :',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'First Language',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 170.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'First Language:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (FirstLangauge!=null)?Text(
                    FirstLangauge,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Reading Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (FirstLangReadingLvl!=null)?Text(
                    FirstLangReadingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Writing Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (FirstLanguageWritingLvl!=null)?Text(
                    FirstLanguageWritingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Speaking Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (FirstLanguageSpeakingLvl!=null)?Text(
                    FirstLanguageSpeakingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Second Language',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 170.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Second Language:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (SecondLangauge!=null)?Text(
                    SecondLangauge,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Reading Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (SecondLangReadingLvl!=null)?Text(
                    SecondLangReadingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Writing Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (SecondLanguageWritingLvl!=null)?Text(
                    SecondLanguageWritingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Speaking Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (SecondLanguageSpeakingLvl!=null)?Text(
                    SecondLanguageSpeakingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),

        ],
      ),
    );

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: jobseekershowprofileheader(context, titleText: 'My Profile'),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[topContent, bottomContentText],
          ),
        ),
      ),
    );
  }


}
