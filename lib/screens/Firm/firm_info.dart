import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/Firm/firm_basic_information.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/utils/strings.dart';

class FirmNamePage extends StatefulWidget {
  String userid;

  FirmNamePage({this.userid});

  @override
  _FirmNamePageState createState() => _FirmNamePageState(userid);
}

class _FirmNamePageState extends State<FirmNamePage> {

  final _formKeyPI = GlobalKey<FormState>();
  String userid;
  String fName = '';
  String lName = '';
  String title = '';
  _FirmNamePageState(this.userid);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: <Widget>[
                BackgroundWidget(size: size),
                SizedBox(
                  height: 6.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    child: Form(
                      key: _formKeyPI,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 100, left: 50.0, right: 50.0, bottom: 20.0),
                            child: LinearProgressIndicator(
                              backgroundColor: Color(0xFFD7D7D7),
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.green),
                              value: 0.6,
                            ),
                          ),
                          PageTitle(
                            titleText: Strings.FirmContactPageTitle,
                            fontSize: 25.0,
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter First Name' : null,
                            onChanged: (val) {
                              setState(() => fName = val);
                            },
                            decoration: InputDecoration(
                              labelText: Strings.firstName,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF203354), width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Last Name' : null,
                            onChanged: (val) {
                              setState(() => lName = val);
                            },
                            decoration: InputDecoration(
                              labelText: Strings.lastName,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF203354), width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Your Ttile' : null,
                            onChanged: (val) {
                              setState(() => title = val);
                            },
                            decoration: InputDecoration(
                              labelText: Strings.hrtitle,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF203354), width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.navigate_next),
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              if (_formKeyPI.currentState.validate()) {
                print(fName);
                print(lName);
                print(title);
                print(userid);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FirmBasicInformation(
                          fname: fName,
                          lname: lName,
                          title: title,
                          userid: userid,
                        )));
              }
            }),
      ),
    );
  }
}
