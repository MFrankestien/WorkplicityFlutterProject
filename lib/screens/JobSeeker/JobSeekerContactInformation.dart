import 'package:flutter/material.dart';
import 'package:Workplicity/screens/JobSeeker/JobSeekerEditContactDetails.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/bottomInfoBar.dart';
import 'package:Workplicity/widgets/header.dart';

class JobSeekerContactDetails extends StatefulWidget {
  @override
  _JobSeekerContactDetailsState createState() => _JobSeekerContactDetailsState();
}

class _JobSeekerContactDetailsState extends State<JobSeekerContactDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header2(
        context, titleText: Strings.contactDetails, actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder:
                    (context) => JobSeekerEditContactDetails()));
          },
          icon: Icon(Icons.edit),
        ),
      ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: FieldTitleWithIcon(
                title: "Address",
                icon: Icons.my_location,
              ),
            ),

            ContainerCareer(

            ),
            Center(
              child: SizedBox(
                width: 320.0,
                child: Divider(color: Colors.black38),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: FieldTitleWithIcon(
                title: "Phone Number",
                icon: Icons.phone,
              ),
            ),
            ContainerCareer(

            ),
            Center(
              child: SizedBox(
                width: 320.0,
                child: Divider(color: Colors.black38),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: FieldTitleWithIcon(
                title: "Email Address",
                icon: Icons.alternate_email,
              ),
            ),
            ContainerCareer(

            ),
            Center(
              child: SizedBox(
                width: 320.0,
                child: Divider(color: Colors.black38),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomInfoBar(),
    );
  }
}
