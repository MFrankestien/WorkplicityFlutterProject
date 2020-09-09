import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Workplicity/screens/intro_pages/reset_password.dart';
import 'package:Workplicity/screens/registration/Signup_type.dart';
import 'package:Workplicity/screens/Firm/firm_info.dart';
import 'package:Workplicity/services/auth.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/constants2.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Workplicity/screens/wrapper.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // text field state
  String email = '';
  String password = '';
  String error = '';
  final Firestore _firestore =Firestore.instance;
  String type,id,Url;
  bool nodata = true;


getusertype() async{
    FirebaseUser userid = await FirebaseAuth.instance.currentUser();
    id=userid.uid;
    var usertype=await _firestore.collection('Users').document(userid.uid).get().then
    ((DocumentSnapshot) async {
      type = DocumentSnapshot.data['UserType'];
      Url=   DocumentSnapshot.data['ImageURL'];
      SharedPreferences preferences=await SharedPreferences.getInstance();
      preferences.setString("User", id);
      preferences.setString("UserType",DocumentSnapshot.data['UserType'] );
      preferences.setString('Url', DocumentSnapshot.data['ImageURL']);
      nodata=false;
      print(type);
      print(Url);
      });}

@override
void initState() {
    // TODO: implement initState
    super.initState();
    type = null;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Stack(
            children: <Widget>[
              BackgroundWidget(size: size),
//              BackButtonPop(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  alignment: Alignment.center,
                  height: size.height,
                  width: size.width,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        PageTitle(
                          titleText: Strings.loginPageTitle,
                          fontSize: 40.0,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                          decoration: InputDecoration(
                            labelText: Strings.SignInEmail,
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
                          validator: (val) => val.length < 8
                              ? 'Enter a password 8+ chars long'
                              : null,
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: Strings.SignInPassword,
                            fillColor: Colors.green,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF203354), width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic result =
                                  await _auth.signInWithEmailAndPassword(
                                      email.trim(), password.toLowerCase());
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Could not sign in with those credentials wrong Email or Password';
                                });
                              } else{
                                  await getusertype();

                                  Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => Wrapper(id:id,UserType: type,)));}


                            }
                          },
                          child: Container(
                            width: 1500,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF203354),
                                  Color(0xFF0D47A1),
                                  Color(0xFF1976D2),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(5, 5),
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, bottom: 10.0, top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ResetPage()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 75.0),
                                    child: Text(
                                      Strings.forgetPassword,
                                      style: TextStyle(
                                          fontSize: 18, color: Color(0xFF0D47A1)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              Strings.socialSignIn,
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RawMaterialButton(
                                  onPressed: () {
                                    print("Google");
                                  },
                                  child: new Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                  shape: new CircleBorder(),
                                  elevation: 2.0,
                                  fillColor: Color(0xFFDE1E37),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    print("Facebook");
                                  },
                                  child: new Icon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                  shape: new CircleBorder(),
                                  elevation: 2.0,
                                  fillColor: Color(0xFF3B5999),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                                RawMaterialButton(
                                  onPressed: () {
                                    print("linkedin");
                                  },
                                  child: new Icon(
                                    FontAwesomeIcons.linkedinIn,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                  shape: new CircleBorder(),
                                  elevation: 2.0,
                                  fillColor: Color(0xFF0177B5),
                                  padding: const EdgeInsets.all(15.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Dont have an account?',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 15.0,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Create Account");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Registration()));
                              },
                              child: Text(
                                Strings.createAccount,
                                style: kH19BTextStyle,
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                          ],
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
    );
  }
}
