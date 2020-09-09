import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Workplicity/screens/Firm/firm_profile_main.dart';
import 'package:Workplicity/screens/JobSeeker/profile_main.dart';

class SuccessPage extends StatefulWidget {
  String userid;

  SuccessPage({this.userid});

  @override
  _SuccessPageState createState() => _SuccessPageState(userid);
}

class _SuccessPageState extends State<SuccessPage> {
  String userid;

  final Firestore _firestore =Firestore.instance;
  String type;



  Future<void> getusertype() async{
    FirebaseUser userid = await FirebaseAuth.instance.currentUser();
    var usertype=await _firestore.collection('Users').document(userid.uid).get().then
      ((DocumentSnapshot) async {
      type = DocumentSnapshot.data['UserType'];
      print(type);
    });}

  _SuccessPageState(this.userid);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: new Icon(Icons.arrow_back),
                              iconSize: 35.0,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 70.0,
                        ),
                        Image(
                          image: AssetImage('assets/images/medal_badge.png'),
                          height: 200.0,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Congratulations',
                            style: TextStyle(
                              fontSize: 30.0,
                            ),
                          ),
                          Text(
                            'Your Account has been created',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      )),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: 360.0,
                        height: 70.0,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () async {
                                  await getusertype();
                                  if(type.toString()=='Jobseeker'){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileMain(userid: userid)));}
                                else{
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FirmProfileMain()));
                                }
                              },
                              child: Card(
                                color: Color(0xFF2E64A4),
                                child: ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                  title: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 50.0),
                                      child: Text(
                                        'Complete Your profile',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
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
        ),
      ),
    );
  }
}
