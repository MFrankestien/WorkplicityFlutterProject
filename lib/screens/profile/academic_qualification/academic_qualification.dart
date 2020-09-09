import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';
import 'edit_academic_qualification.dart';


class AcademicQualification extends StatefulWidget {
  @override
  _AcademicQualificationPage3State createState() =>
      _AcademicQualificationPage3State();
}

class _AcademicQualificationPage3State extends State<AcademicQualification> {
  String _edulevel,_instname,_result,_year;

  loadinfo() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();


    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {

        _edulevel = DocumentSnapshot.data['Education Level'];
        _instname = DocumentSnapshot.data['Institute Name'];
        _result= DocumentSnapshot.data['Result'];
        _year=DocumentSnapshot.data['Passing Year'];


      }

      );

    });}
  void Deleteinfo () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"Education Level":' ',
      "Institute Name":' ',"Result":' ',"Passing Year":' '});
    print(user.uid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header2(context, titleText: Strings.academicQualification,),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight*.7,
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
                          leading: Icon(Icons.school, size: 50),
                          title: Text('',
                              style: TextStyle(
                                  color: Colors.teal, fontSize: 25)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              (_instname!=null)?Text(
                                '◘ Institute Name: $_instname',
                                style: TextStyle(fontSize: 18),
                              ):  SizedBox(
                                child: CircularProgressIndicator(),
                                height: 15.0,
                                width: 15.0,
                              ),
                              Divider(),
                              (_edulevel!=null)?Text(
                                '◘ Education Level: $_edulevel',
                                style: TextStyle(fontSize: 18),
                              ):  SizedBox(
                                child: CircularProgressIndicator(),
                                height: 15.0,
                                width: 15.0,
                              ),
                              Divider(),
                              (_result!=null)?Text(
                                '◘ Result: $_result',
                                style: TextStyle(fontSize: 18),
                              ):  SizedBox(
                                child: CircularProgressIndicator(),
                                height: 15.0,
                                width: 15.0,
                              ),
                              Divider(),
                              (_year!=null)? Text(
                                '◘ Passing Year: $_year',
                                style: TextStyle(fontSize: 18),
                              ):  SizedBox(
                                child: CircularProgressIndicator(),
                                height: 15.0,
                                width: 15.0,
                              ),
                              Divider(),
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
                                                    EditAcademicQualification()));
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 30,
                                      ),
                                      onPressed:(){
Deleteinfo();

                                      })
                                ],
                              ),
                            ],
                          ),
                        )
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
  }

  @override
  void initState() {
    super.initState();
    loadinfo();

  }
}
