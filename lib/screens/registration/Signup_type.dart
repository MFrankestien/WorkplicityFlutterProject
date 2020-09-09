import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Workplicity/screens/registration/Login_info_page.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/bottomInfoBar.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  bool isEmbloyee =true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: <Widget>[
              BackgroundWidget(size: size),
              BackButtonPop(),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Container(
                  alignment: Alignment.center,
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 150, bottom: 50),
                        child: PageTitle(
                          titleText: "I'm looking to..",
                          fontSize: 40.0,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmbloyee=false;
                                });
                                print(isEmbloyee);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PasswordPage(comefrom: isEmbloyee)));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      RawMaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.zero,
                                                bottomLeft: Radius.zero,
                                                bottomRight:
                                                Radius.circular(50.0)),
                                          ),
                                          onPressed: () {},
                                          fillColor: Color(0xFFDE1E37),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10,
                                                left: 10,
                                                right: 20,
                                                bottom: 20),
                                            child: Icon(
                                              FontAwesomeIcons.userTie,
                                              size: 40.0,
                                              color: Colors.white,
                                            ),
                                          )),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  Strings.firm,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontSize: 23.0),
                                                ),
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      left: 20),
                                                  child: Text(
                                                    Strings.firmtext,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontSize: 15.0),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            GestureDetector(

                              onTap: () {
                                setState(() {
                                  isEmbloyee=true;
                                });
                                print(isEmbloyee);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PasswordPage(comefrom:isEmbloyee)));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      RawMaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.0),
                                                topRight: Radius.zero,
                                                bottomLeft: Radius.zero,
                                                bottomRight:
                                                Radius.circular(50.0)),
                                          ),
                                          onPressed: () {},
                                          fillColor:
                                          Theme.of(context).accentColor,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10,
                                                left: 10,
                                                right: 20,
                                                bottom: 20),
                                            child: Icon(
                                              FontAwesomeIcons.userAlt,
                                              size: 40.0,
                                              color: Colors.white,
                                            ),
                                          )),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    Strings.jobSeeker,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontSize: 23.0),
                                                  ),
                                                  Text(
                                                    Strings.jobSeekertext,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontSize: 15.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomInfoBar(),
    );
  }
}