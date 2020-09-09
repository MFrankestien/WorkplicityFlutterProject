import 'package:flutter/material.dart';
import 'package:Workplicity/screens/intro_pages/sign_in_page.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: SignInPage()
    );
  }}