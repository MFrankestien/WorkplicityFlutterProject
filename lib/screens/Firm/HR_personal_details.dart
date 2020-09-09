import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/profile/profile_details/upload_photo.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:Workplicity/screens/Firm/edit_HR_personal_details.dart';

class HRpersonalDetails extends StatefulWidget {
  String userid;

  HRpersonalDetails(
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
  _HRpersonalDetailsState createState() => _HRpersonalDetailsState(userid);
}

class _HRpersonalDetailsState extends State<HRpersonalDetails> {
  String userid;

  _HRpersonalDetailsState(this.userid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header2(
        context,
        titleText: 'HR Personal Details',
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditHRPersonalDetails(userid: userid)));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadPhotoPage()));
                      },
                      child: Icon(
                        Icons.add_a_photo,
                        size: 80.0,
                        color: Theme.of(context).primaryColor,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: FieldTitleWithIcon(
                              title: "First Name",
                              icon: Icons.person,
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
                              title: "Last Name",
                              icon: Icons.person,
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
                              title: "Firm Name",
                              icon: Icons.location_city,
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
                              title: "Title",
                              icon: Icons.person,
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
