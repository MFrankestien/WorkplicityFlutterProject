import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/profile/employment_history/employment_history_null.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:Workplicity/screens/JobSeeker/JobSeekerShowProfile.dart';
class AddEmploymentHistory extends StatefulWidget {
  @override
  _AddEmploymentHistoryState createState() => _AddEmploymentHistoryState();
}

class _AddEmploymentHistoryState extends State<AddEmploymentHistory> {
  TextEditingController _compname,_dep,_resp,_starty,_endy;
  final _key1 = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    loadContact();
  }

  loadContact() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _compname= new TextEditingController();
    _dep= new TextEditingController();
    _resp= new TextEditingController();
    _starty= new TextEditingController();
    _endy= new TextEditingController();
    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {

        _compname.text = DocumentSnapshot.data['Company Name'];
        _dep.text = DocumentSnapshot.data['Department'];
        _resp.text = DocumentSnapshot.data['Responsibilities'];
        _starty.text=DocumentSnapshot.data['Start Date'];
        _endy.text=DocumentSnapshot.data['End Date'];


      }

      );

    });}
  void Updateinfo () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"Company Name":_compname.text,
      "Department":_dep.text,"Responsibilities":_resp.text,"Start Date":_starty.text ,"End Date":_endy.text});
    print(user.uid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header2(
        context,
        titleText: Strings.employmentHistory,
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
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key:_key1 ,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            controller: _compname,
                            validator: (val) =>
                            val.isEmpty ? 'Enter Your Company Name ' : null,
                            onChanged: (val){
                              TextSelection previousSelection = _compname.selection;
                              _compname.text = val;
                              _compname.selection = previousSelection;

                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Company Name*",
                              labelText: 'Company Name*',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),

                        TextFormField(
                            controller: _dep,
                            validator: (val) =>
                            val.isEmpty ? 'Enter Your Department ' : null,
                            onChanged: (val){
                              TextSelection previousSelection = _dep.selection;
                              _dep.text = val;
                              _dep.selection = previousSelection;

                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Department*",
                              labelText: 'Department*',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        TextFormField(
                            controller: _resp,
                            validator: (val) =>
                            val.isEmpty ? 'Enter Your Responsibilities ' : null,
                            onChanged: (val){
                              TextSelection previousSelection = _resp.selection;
                              _resp.text = val;
                              _resp.selection = previousSelection;

                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Responsibilities",
                              labelText: 'Responsibilities',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: 130,
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _starty,
                                  validator: (val) =>
                                  val.isEmpty ? 'Enter Your Start Year ' : null,
                                  onChanged: (val){
                                    TextSelection previousSelection = _starty.selection;
                                    _starty.text = val;
                                    _starty.selection = previousSelection;

                                  },
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.teal,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Start Date*",
                                    labelText: 'Start Date*',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 130,
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (val) =>
                                  val.isEmpty ? 'Enter Your End Year ' : null,
                                  onChanged: (val){
                                    TextSelection previousSelection = _endy.selection;
                                    _endy.text = val;
                                    _endy.selection = previousSelection;

                                  },
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.teal,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "End Date*",
                                    labelText: 'End Date*',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 32.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                  )),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 100,
                        ),
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
            if (_key1.currentState.validate()) {

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
