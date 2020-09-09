import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/profile/profile_details/upload_photo.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/widgets/header.dart';
import 'edit_personal_details.dart';

class PersonalDetail extends StatefulWidget {
  String userid;

  PersonalDetail(
      {this.firstName,
      this.lastName,
      this.fatherName,
      this.motherName,
      this.dob,
      this.religion,
      this.gender,
      this.maritalStatus,
      this.nationality,
      this.nid,
      this.userid});

  final String firstName;
  final String lastName;
  final String fatherName;
  final String motherName;
  final String dob;
  final String religion;
  final String gender;
  final String maritalStatus;
  final String nationality;
  final String nid;

  @override
  _PersonalDetailState createState() => _PersonalDetailState(userid);
}

class _PersonalDetailState extends State<PersonalDetail> {
  String userid;

  _PersonalDetailState(this.userid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header2(
        context,
        titleText: "Personal Details",
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditPersonalDetails(userid: userid)));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 120,
                    width: 120,
                    child: FloatingActionButton(
                      onPressed: () {
                       return Navigator.push(
                           context, MaterialPageRoute(builder: (context) => UploadPhotoPage()));
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        size: 80.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                ListTile(
                    title: Text('Code Solution', textAlign: TextAlign.center),
                    subtitle: Text('info@codesolution101.com',
                        textAlign: TextAlign.center)),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: FieldTitleWithIcon(
                              title: "Date of Birth",
                              icon: Icons.calendar_today,
                            ),
                          ),
                          ProfileInputField(
                            initValue: widget.dob,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: FieldTitleWithIcon(
                              title: "Religion",
                              icon: Icons.featured_video,
                            ),
                          ),
                          ProfileInputField(
                            initValue: widget.religion,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: FieldTitleWithIcon(
                              title: "Nationality",
                              icon: Icons.flag,
                            ),
                          ),
                          ProfileInputField(
                            initValue: widget.nationality,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: FieldTitleWithIcon(
                              title: "National ID No.",
                              icon: Icons.contact_mail,
                            ),
                          ),
                          ProfileInputField(
                            initValue: widget.nid,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: FieldTitleWithIcon(
                              title: "Gender",
                              icon: Icons.supervisor_account,
                            ),
                          ),
                          ProfileInputField(
                            initValue: widget.gender,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
