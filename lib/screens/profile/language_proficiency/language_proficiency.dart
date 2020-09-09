import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/JobSeeker/profile_main.dart';
import 'package:Workplicity/screens/profile/language_proficiency/add_language_proficiency.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';
import 'add_language_proficiency.dart';


class LanguageProficiency extends StatefulWidget {
  @override
  _LanguageProficiencyState createState() =>
      _LanguageProficiencyState();
}

class _LanguageProficiencyState extends State<LanguageProficiency> {

  String r,w,s,r1,w1,s1 ,languagee,language1;
  void Updateinfo () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"First Language":'',
      "Read Level":'',"Write Level":'',"Speak level":'',});
    print(user.uid);
  }
  void Updateinfo1 () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"Second Language":'',
      "Second Read Level":'',"Second Write Level":'',"Second Speak level":''});
    print(user.uid);
  }
  loadinfo() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();


    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {

        languagee = DocumentSnapshot.data['First Language'];
        r = DocumentSnapshot.data['Read Level'];
        w = DocumentSnapshot.data['Write Level'];
        s=DocumentSnapshot.data['Speak level'];
        language1 = DocumentSnapshot.data['Second Language'];
        r1 = DocumentSnapshot.data['Second Read Level'];
        w1 = DocumentSnapshot.data['Second Write Level'];
        s1=DocumentSnapshot.data['Second Speak level'];


      }

      );

    });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header2(
        context,
        titleText: Strings.languageProficiency,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: viewportConstraints.maxWidth),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.white,
                          elevation: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const ListTile(
                                leading: Icon(Icons.translate, size: 30),
                                title:Text('First language',
                                    style: TextStyle(
                                        color: Colors.teal, fontSize: 25)),
                              ),

                              Padding(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    (languagee!= null)?Text(
                                      '◘ $languagee',
                                      style: TextStyle(fontSize: 20),
                                    ):
                                    Text('Complete your profile to show ',style: TextStyle(fontSize: 20),),
                                    Divider(),
                                    SizedBox(height: 20,),

                                    (r!= null)?Text(
                                      '◘ Reading: $r',
                                      style: TextStyle(fontSize: 18),
                                    ):
                                    Text('Complete your profile to show ',style: TextStyle(fontSize: 18),),
                                    Divider(),
                                    (w!= null)?Text(
                                      '◘ Writing: $w',style: TextStyle(fontSize: 18),
                                    ):
                                    Text('Complete your profile to show ',style: TextStyle(fontSize: 18),),
                                    Divider(),
                                    (s!= null)?Text(
                                      '◘ Speaking: $s',style: TextStyle(fontSize: 18),
                                    ):
                                    Text('Complete your profile to show ',style: TextStyle(fontSize: 18),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddLanguageProficiency()));
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              size: 30,
                                            ),
                                            onPressed: (){
                                              Updateinfo();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileMain()));
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                child: new Divider(color: Colors.blueGrey),
                              ),
                              const ListTile(
                                leading: Icon(Icons.translate, size: 30),
                                title:Text('Second language',
                                    style: TextStyle(
                                        color: Colors.teal, fontSize: 25)),
                              ),

                              Padding(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    (language1!= null)?Text(
                                      '◘ $language1',
                                      style: TextStyle(fontSize: 20),
                                    ):
                                    Text('Complete your profile to show ',style: TextStyle(fontSize: 20),),
                                    Divider(),
                                    SizedBox(height: 20,),

                                    (r1!= null)?Text(
                                      '◘ Reading: $r1',
                                      style: TextStyle(fontSize: 18),
                                    ):
                                    Text('Complete your profile to show ',style: TextStyle(fontSize: 18),),
                                    Divider(),
                                    (w1!= null)?Text(
                                      '◘ Writing: $w1',style: TextStyle(fontSize: 18),
                                    ):
                                    Text('Complete your profile to show ',style: TextStyle(fontSize: 18),),
                                    Divider(),
                                    (s1!= null)?Text(
                                      '◘ Speaking: $s1',style: TextStyle(fontSize: 18),
                                    ):
                                    Text('Complete your profile to show ',style: TextStyle(fontSize: 18),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        IconButton(
                                            icon: Icon(
                                              Icons.edit,
                                              size: 30,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddLanguageProficiency()));
                                            }),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              size: 30,
                                            ),
                                            onPressed: (){
                                              Updateinfo1();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileMain()));
                                            })
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),

    );
  }

  @override
  void initState() {
    super.initState();
    loadinfo();
  }
}
