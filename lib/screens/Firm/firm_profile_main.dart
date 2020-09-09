import 'package:Workplicity/screens/Firm/FirmJobApplications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Workplicity/screens/Firm/FirmShowProfie.dart';
import 'package:Workplicity/screens/Firm/posted_Jobs.dart';
import 'package:Workplicity/screens/profile/contact_details/contacts_datails.dart';
import 'package:Workplicity/screens/Firm/HR_personal_details.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firm_home_page.dart';

class FirmProfileMain extends StatefulWidget {
  String userid;

  FirmProfileMain({this.userid});

  @override
  _FirmProfileMainState createState() => _FirmProfileMainState(userid);
}

class _FirmProfileMainState extends State<FirmProfileMain> {
  String userid;
  String Fname,Lname,Firmname,name;

  SharedPreferences preferences;
  String urls;


  void getuserid() async {FirebaseUser user = await FirebaseAuth.instance.currentUser();

  userid=user.uid;

  print(userid);}
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
              Firmname = DocumentSnapshot.data['FirmName'];
              name='$Fname $Lname';
              print(Fname); print(Lname); print(Firmname);
            });

      });}

  @override
  void initState() {
    super.initState();
    getuserid();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => preferences = prefs);
      urls = preferences.getString("Url");
      load();
    });}

  _FirmProfileMainState(this.userid);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FirmHomePage()));
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FirmShowProfile()));
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
                                  '$Firmname',
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
                      'Firm Details',
                      style:
                          TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                        onPressed: () {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HRpersonalDetails(userid: userid)));
                        },
                        child: ListTile(
                          title: Text(
                            'HR Details',
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
                                  builder: (context) => ContactDetails()));
                        },
                        child: ListTile(
                            title: Text('Firm Contact Details',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                            leading: Icon(Icons.location_city,
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
                      'Firm Jobs',
                      style:
                          TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostedJobFirm(userid: userid,))),
                        child: ListTile(
                          title: Text(
                            'Jobs',
                            style:
                                TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          leading: Icon(
                            Icons.business_center,
                            color: Theme.of(context).primaryColor,
                          ),
                        )),
                    FlatButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirmJobApplications(userid: userid,))),
                        child: ListTile(
                            title: Text('Job Applications',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                            leading: Icon(Icons.assignment_ind,
                                color: Theme.of(context).primaryColor))),
                    SizedBox(
                      height: 20.0,
                      width: 320.0,
                      child: Divider(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
