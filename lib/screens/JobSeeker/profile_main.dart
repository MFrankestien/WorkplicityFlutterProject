import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Workplicity/screens/JobSeeker/JobSeekerContactInformation.dart';
import 'package:Workplicity/screens/JobSeeker/JobSeekerShowProfile.dart';
import 'package:Workplicity/screens/JobSeeker/career_application.dart';
import 'package:Workplicity/screens/main_menu/navbar_builder.dart';
import 'package:Workplicity/screens/profile/academic_qualification/academic_qualification.dart';
import 'package:Workplicity/screens/profile/employment_history/employment_history_null.dart';
import 'package:Workplicity/screens/profile/language_proficiency/language_proficiency.dart';
import 'package:Workplicity/screens/profile/profile_details/personal_details.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/widgets/bottomInfoBar.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ProfileMain extends StatefulWidget {
  String userid;


  ProfileMain({this.userid});

  @override
  _ProfileMainState createState() => _ProfileMainState(userid);
}

class _ProfileMainState extends State<ProfileMain> {
  String userid;
  String Fname,Lname,Firmname,name;


  _ProfileMainState(this.userid);
  SharedPreferences preferences;
  String urls;

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
        name='$Fname $Lname';
        print(Fname); print(Lname);
      });

    });}
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => preferences = prefs);
      urls = preferences.getString("Url");
      load();
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipBehavior: Clip.antiAlias,
              clipper: HomeClipper2(),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 150,left: 15,top: 15,bottom: 15),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                                },
                                child: Icon(
                                  Icons.home,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>JobSeekerShowProfile()));
                                },
                                child: Icon(
                                  Icons.person_pin,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Hero(
                              tag: 'profileImage',
                              child: ProfileImageContainer(
                                height: 80.0,
                                width: 80.0,
                                backgroundImage:(urls!=null)?NetworkImage(urls):NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png',
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(height: 10,),
                              (name!=null)?Text(
                                '$Fname $Lname',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ):  SizedBox(
                                child: CircularProgressIndicator(),
                                height: 15.0,
                                width: 15.0,
                              ),
                              (name!=null)?Text(
                                '',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ):  SizedBox(
                                child: CircularProgressIndicator(),
                                height: 15.0,
                                width: 15.0,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Personal Details',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PersonalDetail(userid: userid)));
                      },
                      child: ListTile(
                        title: Text(
                          'Personal  ',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        leading: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                  FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobSeekerContactDetails()));
                      },
                      child: ListTile(
                          title: Text('Contact Details',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                          leading: Icon(Icons.contacts,
                              color: Theme.of(context).primaryColor))),
                  FlatButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CareerApplication())),
                      child: ListTile(
                          title: Text('Career and Application Information',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                          leading: Icon(Icons.insert_drive_file,
                              color: Theme.of(context).primaryColor))),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Education',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AcademicQualification())),
                      child: ListTile(
                        title: Text(
                          'Academic Qualification',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        leading: Icon(
                          Icons.school,
                          color: Theme.of(context).primaryColor,
                        ),
                      )),


                  SizedBox(
                    height: 20.0,
                    width: 320.0,
                    child: Divider(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Employment History',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  FlatButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmploymentHistoryNull())),
                      child: ListTile(
                        title: Text(
                          'Employment History',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        leading: Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                        ),
                      )),

                  SizedBox(
                    height: 20.0,
                    width: 320.0,
                    child: Divider(color: Theme.of(context).primaryColor),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Other Information',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),

                  FlatButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LanguageProficiency())),
                      child: ListTile(
                          title: Text('Language Proficiency',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
                          leading: Icon(Icons.language,
                              color: Theme.of(context).primaryColor))),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomInfoBar(),
    );
  }
}
