import 'package:Workplicity/screens/intro_pages/sign_in_page.dart';
import 'package:Workplicity/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Workplicity/screens/main_menu/more/interview_invitation.dart';
import 'package:Workplicity/screens/main_menu/more/new_jobs.dart';
import 'package:Workplicity/services/auth.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirmMoreSettings extends StatefulWidget {
  @override
  _FirmMoreSettingsState createState() => _FirmMoreSettingsState();
}

class _FirmMoreSettingsState extends State<FirmMoreSettings> {
  void _doOpenPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => Wrapper()));
  }
  deleteuser() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();

   preferences.clear();
    print('done');
    print(preferences.get("UserType"));
    await _auth.signOut();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => SignInPage()));

  }

  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Firmheader(context, titleText: 'More'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewJobs()));
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.userClock),
                title: Text('Job Application Deadline'),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InterviewInvitation()));
              },
              child: ListTile(
                leading: Icon(FontAwesomeIcons.handshake),
                title: Text('Interview Invitation'),
              ),
            ),

            Container(
              width: 360.0,
              child: Divider(
                thickness: 2.0,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(FontAwesomeIcons.star),
                title: Text('Rate Us on Google Play Store'),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(FontAwesomeIcons.inbox),
                title: Text('Feedback and Support'),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(FontAwesomeIcons.lock),
                title: Text('Privacy Policy'),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Icon(FontAwesomeIcons.solidStickyNote),
                title: Text('Terms and Policies'),
              ),
            ),
            GestureDetector(
              onTap: () async{
                deleteuser();
              },
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.powerOff,
                  color: Colors.red,
                ),
                title: Text(
                  'Log out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
