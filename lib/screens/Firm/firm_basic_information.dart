import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/registration/success_page.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/utils/strings.dart';

class FirmBasicInformation extends StatefulWidget {
  String fname;
  String lname;
  String title;
  String userid;


  FirmBasicInformation({this.fname,this.lname,this.title, this.userid});

  @override
  _FirmBasicInformationState createState() =>
      _FirmBasicInformationState(fname,lname,title, userid);
}

class _FirmBasicInformationState extends State<FirmBasicInformation> {
  void Updatecontact () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"FirstName":fname,
      "LastName":lname,"Title":title,"FirmName":firmname,"Firmemail":firmname,'Location':dropdownValue1,'FirmSpeciality':dropdownValue});
  }
  final _formKeyPI = GlobalKey<FormState>();
  String userid;
  String fname = '';
  String lname = '';
  String title = '';
  String firmname;
  String firmemail;
  String dropdownValue ='Accounting/Finance' ;
  String dropdownValue1 ='Cairo' ;
  _FirmBasicInformationState(this.fname,this.lname,this.title, this.userid);

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
              BackButtonPop(),
              SizedBox(
                height: 6.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  alignment: Alignment.center,
                  height: SizeConfig.screenHeight,
                  width: SizeConfig.screenWidth,
                  child: Form(
                    key: _formKeyPI,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 100, left: 50.0, right: 50.0, bottom: 20.0),
                          child: LinearProgressIndicator(
                            backgroundColor: Color(0xFFD7D7D7),
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                            value: 0.9,
                          ),
                        ),
                        PageTitle(
                          titleText: Strings.BasicCompanyInfo,
                          fontSize: 25.0,
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter Firm Name' : null,
                          onChanged: (val) {
                            setState(() => firmname = val);
                          },
                          decoration: InputDecoration(
                            labelText: Strings.firmName,
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

                          onChanged: (val) {
                            setState(() => firmemail = val);
                          },
                          decoration: InputDecoration(
                            labelText: Strings.firmEmail,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFF203354), width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        Text("Select a Company Industry",style: TextStyle(fontSize: 19),),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButton<String>(
                          value: dropdownValue ,
                          icon: Icon(Icons.build),
                          iconSize: 20,
                          elevation: 16,
                          style: TextStyle(color: Color(0xFF203354)), underline: Container(
                          height: 2,
                          color: Colors.blueAccent,
                          ),
                          onChanged: (String newValue) {
                          setState(() {
                          dropdownValue = newValue;
                          });},
                          items: <String>[
                            'Accounting/Finance',
                            'Bank/ Non-Bank Fin. Institution',
                            'Commercial/Supply Chain',
                            'Education/Training',
                            'Engineer/Architects',
                            'Garments/Textile',
                            'HR/Org. Development',
                            'Gen Mgt/Admin',
                            'Design/Creative',
                            'Production/Operation',
                            'Hospitality/ Travel/ Tourism',
                            'Beauty Care/ Health & Fitness',
                            'Electrician/ Construction/ Repair',
                            'IT & Telecommunication',
                            'Marketing/Sales',
                            'Customer Support/Call Centre',
                            'Media/Ad./Event Mgt.',
                            'Medical/Pharma',
                            'Agro (Plant/Animal/Fisheries)',
                            'NGO/Development',
                            'Research/Consultancy',
                            'Secretary/Receptionist',
                            'Data Entry/Operator/BPO',
                            'Driving/Motor Technician',
                            'Security/Support Service',
                            'Law/Legal',
                            'Others'].map((String value) {
                return DropdownMenuItem<String>(
                value: value,
                child: Text(value,style:TextStyle(fontSize: 18),),
                );
                }).toList(),

                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Select a Company Location",style: TextStyle(fontSize: 19),),
                        SizedBox(
                          height: 10.0,
                        ),
                        DropdownButton<String>(
                          value: dropdownValue1 ,
                          icon: Icon(Icons.location_city),
                          iconSize: 20,
                          elevation: 16,
                          style: TextStyle(color: Color(0xFF203354)), underline: Container(
                          height: 2,
                          color: Colors.blueAccent,
                        ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue1 = newValue;
                            });},
                          items: <String>['Cairo',
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
                            'Az Zaqaziq'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,style:TextStyle(fontSize: 18),),
                            );
                          }).toList(),

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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          backgroundColor: Colors.blueAccent,
          onPressed: () {
            if (_formKeyPI.currentState.validate()) {
Updatecontact();
              print(fname);
              print(lname);
              print(firmemail);
              print(firmname);
              print(title);
              print(userid);
              print(dropdownValue);
              print(dropdownValue1);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SuccessPage(
                      userid: userid)));
            }
          }),
    );
  }
}
