import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';
import 'add_employment_history.dart';

class EmploymentHistoryNull extends StatefulWidget {
  @override
  _EmploymentHistoryNullState createState() => _EmploymentHistoryNullState();
}

class _EmploymentHistoryNullState extends State<EmploymentHistoryNull> {
  @override

  String _compname,_dep,_resp,_starty,_endy;


  @override
  void initState() {
    loadContact();
  }

  loadContact() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {

        _compname = DocumentSnapshot.data['Company Name'];
        _dep = DocumentSnapshot.data['Department'];
        _resp = DocumentSnapshot.data['Responsibilities'];
        _starty=DocumentSnapshot.data['Start Date'];
        _endy=DocumentSnapshot.data['End Date'];


      }

      );

    });}
    void Deleteinfo () async {

      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      Firestore.instance.collection('Users').document(user.uid).updateData({"Company Name":' ',
        "Department":' ',"Responsibilities":' ',"Start Date":' ',"End Date":' '});
      print(user.uid);
    }
    @override
    Widget build (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: header2(context, titleText: Strings.employmentHistory,),
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
                            leading: Icon(Icons.person, size: 50),
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

                                (_compname!=null)?Text(
                                  '◘ Company Name: $_compname',
                                  style: TextStyle(fontSize: 18),
                                ):  SizedBox(
                                  child: CircularProgressIndicator(),
                                  height: 15.0,
                                  width: 15.0,
                                ),
                                Divider(),
                            (_dep!=null)?Text(
                                  '◘ Department: $_dep',
                                  style: TextStyle(fontSize: 18),
                                ) :  SizedBox(
                              child: CircularProgressIndicator(),
                    height: 15.0,
                    width: 15.0,
                  ),
                                Divider(),
                                (_resp!=null)? Text(
                                  '◘ Responsibilities: $_resp',
                                  style: TextStyle(fontSize: 18),
                                ):  SizedBox(
                                  child: CircularProgressIndicator(),
                                  height: 15.0,
                                  width: 15.0,
                                ),
                                Divider(),
                                (_starty!=null)?Text(
                                  '◘ Start Year: $_starty',
                                  style: TextStyle(fontSize: 18),
                                ):  SizedBox(
                                  child: CircularProgressIndicator(),
                                  height: 15.0,
                                  width: 15.0,
                                ),
                                Divider(),
                                (_endy!=null)?Text(
                                  '◘ End Year: $_endy',
                                  style: TextStyle(fontSize: 18),
                                ):  SizedBox(
                                  child: CircularProgressIndicator(),
                                  height: 15.0,
                                  width: 15.0,
                                ),
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
                                                      AddEmploymentHistory()));
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


}
