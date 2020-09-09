import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/JobSeeker/profile_main.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/bottomInfoBar.dart';
import 'package:intl/intl.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditPersonalDetails extends StatefulWidget {
  String userid;

  EditPersonalDetails({this.userid});

  @override
  _EditPersonalDetailsState createState() => _EditPersonalDetailsState(userid);
}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {

  String userid;

  _EditPersonalDetailsState(this.userid);

  DateTime _date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
    );
    if (_date != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }


  TextEditingController _Firstname,_Lastname,_Gender,_Religion,_NationalID;
  final _formkeyJS = GlobalKey<FormState>();

  loadContact() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _Firstname= new TextEditingController();
    _Lastname= new TextEditingController();
    _Gender= new TextEditingController();
    _Religion= new TextEditingController();
    _NationalID= new TextEditingController();

    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {

        _Firstname.text = DocumentSnapshot.data['FirstName'];
        _Lastname.text = DocumentSnapshot.data['LastName'];
        _Religion.text = DocumentSnapshot.data['Religion'];
        _Gender.text = DocumentSnapshot.data['Gender'];
        _NationalID.text = DocumentSnapshot.data['NationalID'];

      }

      );

    });}
  void Updateinfo () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"FirstName":_Firstname.text,
      "LastName":_Lastname.text,"Gender":gender,"DOB":_date,"NationalID":_NationalID.text, "Religion":_Religion.text});



  }

  String gender = "";


  List<String> _selectGender = ['♂ Male', '♀ Female'];
  int _defaultGenderChoiceIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadContact();
    _defaultGenderChoiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    String _formatDate = DateFormat.yMMMd().format(_date);
    TextEditingController _textFieldController = TextEditingController();
    return Scaffold(
      appBar: header2(
        context,
        titleText: Strings.personalDetails,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkeyJS,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        validator: (val) =>
                        val.isEmpty ? 'Enter Your First Name ' : null,
                        onChanged: (val) {
                          TextSelection previousSelection = _Firstname.selection;
                          _Firstname.text= val;
                          _Firstname.selection = previousSelection;

                        },
                        controller: _Firstname,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          labelText: "First Name",
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller: _Lastname,
                        validator: (val) =>
                        val.isEmpty ? 'Enter Your Last Name ' : null,
                        onChanged: (val) {
                          TextSelection previousSelection = _Lastname.selection;
                          _Lastname.text = val;
                          _Lastname.selection = previousSelection;

                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          labelText: "Last Name",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[],
                ),
                SizedBox(height: 10.0),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: _InputDropdown(
                        labelText: "Date of Birth",
                        valueText: _formatDate,
                        onPressed: () {
                          selectDate(context);
                        },
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller: _Religion,
                        validator: (val) =>
                        val.isEmpty ? 'Enter Your Religion' : null,
                        onChanged: (val) {
                          TextSelection previousSelection = _Religion.selection;
                          _Religion.text = val;
                          _Religion.selection = previousSelection;

                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          labelText: "Religion",
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                PageTitle(titleText: 'Gender', fontSize: 20.0),
                SizedBox(height: 10.0),
                Wrap(
                  spacing: 5.0,
                  children: List<Widget>.generate(
                    2,
                    (int index) {
                      return ChoiceChip(
                        label: Text(
                          _selectGender[index],
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        backgroundColor: Colors.black26,
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        selected: _defaultGenderChoiceIndex == index,
                        selectedColor: Theme.of(context).primaryColor,
                        onSelected: (bool selected) {
                          setState(() {
                            _defaultGenderChoiceIndex = selected ? index : 0;
                            gender = _selectGender[index];
                          });
                        },
                      );
                    },
                  ).toList(),
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _NationalID,
                        validator: (val) =>
                        val.isEmpty ? 'Enter Your NationalID' : null,
                        onChanged: (val) {
                          TextSelection previousSelection = _NationalID.selection;
                          _NationalID.text = val;
                          _NationalID.selection = previousSelection;

                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                          labelText: "National ID",
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          backgroundColor: Colors.blueAccent,
          onPressed: () async {
            print(gender);
            if (_formkeyJS.currentState.validate()) {
              Updateinfo();
              print("Done");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileMain()));
            }

          }
      ),
      bottomNavigationBar: BottomInfoBar(),
    );
  }
}



class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.onPressed,
      this.onChanged})
      : super(key: key);

  final String labelText;
  final String valueText;
  final VoidCallback onPressed;
  final VoidCallback onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          labelText: labelText,
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText),
            new Icon(Icons.calendar_today,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}
