import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/profile/academic_qualification/academic_qualification.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:Workplicity/screens/JobSeeker/JobSeekerShowProfile.dart';

class EditAcademicQualification extends StatefulWidget {
  @override
  _EditAcademicQualificationState createState() =>
      _EditAcademicQualificationState();
}

class _EditAcademicQualificationState
    extends State<EditAcademicQualification> {

  final _formkey = GlobalKey<FormState>();
  TextEditingController _edulevel,_instname,_result,_year;
  void Updateinfo () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"Education Level":_edulevel.text,
      "Institute Name":_instname.text,"Result":_result.text,"Passing Year":_year.text});
    print(user.uid);
  }

  @override
  void initState() {
    super.initState();
    loadContact();
  }

  loadContact() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _edulevel= new TextEditingController();
    _instname= new TextEditingController();
    _result= new TextEditingController();
    _year= new TextEditingController();

    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {

        _edulevel.text = DocumentSnapshot.data['Education Level'];
        _instname.text = DocumentSnapshot.data['Institute Name'];
        _result.text = DocumentSnapshot.data['Result'];
        _year.text=DocumentSnapshot.data['Passing Year'];


      }

      );

    });}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header2(context, titleText: Strings.academicQualification),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: viewportConstraints.maxWidth),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key:_formkey ,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            controller: _edulevel,
                            validator: (val) =>
                            val.isEmpty ? 'Enter Your Lavel of Education ' : null,
                            onChanged: (val){
                              TextSelection previousSelection = _edulevel.selection;
                              _edulevel.text = val;
                              _edulevel.selection = previousSelection;

                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Level of Education*",
                              labelText: 'Level of Education*',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        TextFormField(
                            controller: _instname,
                            validator: (val) =>
                            val.isEmpty ? 'Enter Your Institute Name ' : null,
                            onChanged: (val){
                              TextSelection previousSelection = _instname.selection;
                              _instname.text = val;
                              _instname.selection = previousSelection;

                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Institute Name*",
                              labelText: 'Institute Name*',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        TextFormField(
                            controller: _result,
                            validator: (val) =>
                            val.isEmpty ? 'Enter Your Result ' : null,
                            onChanged: (val){
                              TextSelection previousSelection = _result.selection;
                              _result.text = val;
                              _result.selection = previousSelection;

                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Result*",
                              labelText: 'Result*',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _year,
                            validator: (val) =>
                            val.isEmpty ? 'Enter Your Passing Year ' : null,
                            onChanged: (val){
                              TextSelection previousSelection = _year.selection;
                              _year.text = val;
                              _year.selection = previousSelection;

                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Passing Year*",
                              labelText: 'Passing Year*',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
          onPressed: () async {
            if (_formkey.currentState.validate()) {

              Updateinfo();
              print('done');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          JobSeekerShowProfile()));
            }

          }),
    );
  }
}
