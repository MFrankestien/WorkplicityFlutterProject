import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Workplicity/model/jobshot.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/widgets/header.dart';

class FirmShowProfile extends StatefulWidget {
  final JobsHot jobsHot;
  FirmShowProfile({this.jobsHot});
  @override
  _FirmShowProfileState createState() => _FirmShowProfileState();
}

class _FirmShowProfileState extends State<FirmShowProfile> {
  String Fname,Lname,Firmname,Imageurl,name,Title,City,FullAdress,Firmemail,phone,gender;
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
        Firmname = DocumentSnapshot.data['FirmName'];
        Title = DocumentSnapshot.data['Title'];
        Imageurl = DocumentSnapshot.data['ImageURL'];
        City=DocumentSnapshot.data['Location'];
        FullAdress=DocumentSnapshot.data['Fulladress'];
        Firmemail=DocumentSnapshot.data['Firmemail'];
        phone=DocumentSnapshot.data['FirmPhone'];
        gender=DocumentSnapshot.data['Gender'];
        date=DocumentSnapshot.data['DOB'].toDate();
        name = '$Fname $Lname';
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
                    flex: 1,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Personal Information:',
                  style: TextStyle(fontSize: 18.0),
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
                  flex: 1,
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
                  flex: 1,
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

            ],
          ),
          SizedBox(height: 20,),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Firm Contact Information:',
                  style: TextStyle(fontSize: 18.0),
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
                 flex: 1,
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
                  flex: 1,
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
                  flex: 1,
                  child: Text(
                    '📞 Phone:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (phone!=null)?Text(
                    phone,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    '📧 Firm E-mail:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (Firmemail!=null)?Text(
                    Firmemail,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
            ],
          ),

        ],
      ),
    );

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: showprofileheader(context, titleText: 'My Profile'),
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
