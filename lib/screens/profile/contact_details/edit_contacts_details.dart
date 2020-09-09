import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/Firm/FirmShowProfie.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';

class EditContactDetails extends StatefulWidget {
  @override
  _EditContactDetailsState createState() => _EditContactDetailsState();
}

class _EditContactDetailsState extends State<EditContactDetails> {
  TextEditingController _Fulladdress,_phone,_email;
  @override
  // ignore: must_call_super
  void initState() {
    loadContact();
  }
  String Firmcity,Fulladress,Phonenumber,Firmemail;
  final _formkeyNJ = GlobalKey<FormState>();
  int _jobType;
  int _jobLocation;
  List<String> jobLocation = <String>[
    'Cairo',
    'Alexandria',
    'Al Gīzah',
    '6 October',
    'Zamalek',
    'Mohandesen',
    'Nasr city',
    'Masr El gdeda',
    'Zayed City',
    'Rehab',
    'fifth settlement',
    'Dokki',
    'Ismailia',
    'Port Said',
    'Luxor',
    'Sūhāj',
    'Al Mansurah',
    'Suez',
    'Al Minya',
    'Damanhur',
    'Bani Suwayf',
    'Asyuţ',
    'Tanta',
    'Al Fayyum',
    'Aswan',
    'Qina',
    'Mallawi',
    'Al Arish',
    'Banha',
    'Kafr EL Shaykh',
    'Jirja',
    'Marsa Matruh',
    'Isna',
    'Bani Mazar',
    'Safajah',
    'Sinai',
    'Siwah',
    'Al Alamayn',
    'Al Sallūm',
    'Al Ghardaqah',
    'Rafaḩ',
    'Shibin al Kawm',
    'Damietta',
    'Ash Shaykh Zuwayd',
    'Az Zaqaziq'
  ];

  loadContact() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
_Fulladdress= new TextEditingController();
    _phone= new TextEditingController();
    _email= new TextEditingController();
    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {

        _phone.text = DocumentSnapshot.data['FirmPhone'];
        _Fulladdress.text = DocumentSnapshot.data['Fulladress'];
        _email.text = DocumentSnapshot.data['Firmemail'];
        Firmcity = DocumentSnapshot.data['Location'];


      }

      );

    });}
  void Updatecontact () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"FirmPhone":_phone.text,
    "Fulladress":_Fulladdress.text,"Firmemail":_email.text,"Location":Firmcity});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: header2(context, titleText: Strings.contactDetails,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key:_formkeyNJ ,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
                ),
                SizedBox(height: 10.0),
                PageTitle(
                    titleText: 'Firm Address',fontSize: 25.0
                ),
                SizedBox(height: 25.0),
                DropdownButton<String>(
                  hint: Row(
                    children: <Widget>[
                      (Firmcity!=null) ? Text(
                        Firmcity,
                        style: TextStyle(fontSize: 20.0),
                      ): SizedBox(
                    child: CircularProgressIndicator(),
                  ),
                    ],
                  ),
                  value: _jobLocation == null
                      ? null
                      : jobLocation[_jobLocation],
                  items: jobLocation.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: <Widget>[
                          Text(
                            value,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      Firmcity = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: _Fulladdress,
                        validator: (val) =>
                        val.isEmpty ? 'Enter the full address' : null,
                        onChanged: (val) {
                          TextSelection previousSelection = _Fulladdress.selection;
                          _Fulladdress.text = val;
                          _Fulladdress.selection = previousSelection;

                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          labelText: "House No./Road No./Street*",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                PageTitle(
                    titleText: 'Firm Number',fontSize: 25.0
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
controller: _phone,
                        keyboardType: TextInputType.number,
                        validator: (val) =>
                        val.isEmpty ? 'Enter Firm Phone Number ' : null,
                        onChanged: (val) {
                          TextSelection previousSelection = _phone.selection;
                          _phone.text = val;
                          _phone.selection = previousSelection;

                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            labelText: "Firm Phone Number*"
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.0),
                PageTitle(
                    titleText: 'Email Address',fontSize: 25.0
                ),
                SizedBox(height: 10.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                       controller: _email,
                        onChanged: (val) {
                          TextSelection previousSelection = _email.selection;
                          _email.text = val;
                          _email.selection = previousSelection;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            labelText: "Email Address"
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          backgroundColor: Colors.blueAccent,
          onPressed: () async {
    if (_formkeyNJ.currentState.validate()) {
   Updatecontact();
   print("Done");
   Navigator.push(
       context,
       MaterialPageRoute(
           builder: (context) => FirmShowProfile()));
    }

            }
          ),
    );
  }


}

