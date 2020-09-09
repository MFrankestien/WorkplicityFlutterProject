import 'package:flutter/material.dart';
import 'package:Workplicity/services/auth.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/strings.dart';

class ResetPage extends StatefulWidget {
  @override
  _ResetPageState createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  // text field state
  String email = '';
  String warning;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              BackgroundWidget(size: size),
              BackButtonPop(),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
                child: Container(
                  alignment: Alignment.center,
                  height: size.height,
                  width: size.width,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 15),
                          PageTitle(
                            titleText: Strings.Reset,
                            fontSize: 40.0,
                          ),
                          SizedBox(height: 50),
                          showAlert(),
                          SizedBox(height: 50),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            decoration: InputDecoration(
                              labelText: 'Enter your Email',
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF203354), width: 2.0),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                warning =
                                    "A password reset link has been sent to $email";
                              }
                              submit();
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
                                  'Reset',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget showAlert() {
    if (warning != null) {
      return Container(
        color: Colors.amber,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(
                warning,
                maxLines: 3,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  void submit() async {
    await _auth.sendPasswordResetEmail(email);
  }
}
