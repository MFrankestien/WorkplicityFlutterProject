import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SearchResult.dart';

class SearchMain extends StatefulWidget {
  String urls;

  SearchMain({this.urls});

  @override
  _SearchMainState createState() => _SearchMainState(urls);
}

class _SearchMainState extends State<SearchMain> {
  int _jobCategory;
  int _jobLocation;
  int _jobSalary;
  int _jobType;
  String selectedjobType,selectedjobLocation,selectedjobtype,startv;
  RangeValues values= RangeValues(1000,20000);
  RangeLabels labels = RangeLabels('1000','20000');


  _SearchMainState(this.urls);

  SharedPreferences preferences;
  String urls;
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

  List<String> jobCategory = <String>[
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
    'Others'
  ];

  List <String> jobType = <String> [
    'Part Time',
    'Full Time',
    'Contract',
    'internship',
    'Freelance',
  ];

  String Fname,Lname,name;
  load() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {
      setState(() {
        Fname = DocumentSnapshot.data['FirstName'];
        Lname = DocumentSnapshot.data['LastName'];
        name='$Fname $Lname';
        print(Fname); print(Lname);
      });

    });}


  @override
  void initState() {
    super.initState();
    load();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => preferences = prefs);
      urls =preferences.getString("Url");
    });}

  void _onExitTap() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Exit',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Are you sure you want to close the App',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                          child: FlatButton(
                            child: Text('Yes'),
                            color: Colors.blue,
                            onPressed: () {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop');
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50.0,
                          child: FlatButton(
                            child: Text('No'),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar:AppBar(title: Text('Advanced Search',style:TextStyle(
        fontSize: 25.0,
        color: Colors.white,
      ),), ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 350.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 8.0)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Icon(
                              Icons.my_location,
                              size: 22.0,
                            ),
                          ),
                          Text(
                            ' Job Location',
                            style: TextStyle(fontSize: 20.0),
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
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              Text(
                                value,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _jobLocation = jobLocation.indexOf(value);
                          selectedjobLocation=value;
                          print(selectedjobLocation);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 350.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 8.0)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isDense: false,
                      isExpanded: true,
                      hint: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Icon(
                              FontAwesomeIcons.briefcase,
                              size: 22.0,
                            ),
                          ),
                          Text(
                            ' Job Categories',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      value: _jobCategory == null ? null : jobCategory[_jobCategory],
                      items: jobCategory.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              Text(
                                value,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _jobCategory = jobCategory.indexOf(value);
                          selectedjobType=value;
                          print(selectedjobType);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 350.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 8.0)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Icon(
                              FontAwesomeIcons.tag,
                              size: 22.0,
                            ),
                          ),
                          Text(
                            ' Job Type',
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                      value: _jobType == null
                          ? null
                          : jobType[_jobType],
                      items: jobType.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              Text(
                                value,
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _jobType = jobType.indexOf(value);
                          selectedjobtype=value.trim();
                          print(selectedjobtype);
                        });
                      },
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(

              children: <Widget>[


                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text ('Salary',style: TextStyle(fontSize: 20)),
                ),
                Container(
                  width:300 ,
                  child: RangeSlider(min : 1000, max : 20000 , values: values,
                      divisions: 20000,
                      labels:labels,
                      onChanged: (value){setState(() {
                        values = value;
                        labels = RangeLabels (value.start.toInt().toString(),value.end.toInt().toString());
                        startv=value.start.toInt().toString();
                        print(startv);

                      });}),
                ),
              ],
            ),
            Container(
              width: 200.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {


                      if(selectedjobLocation==null&&selectedjobType==null&&selectedjobtype==null&&startv==null){
                        Fluttertoast.showToast(
                            msg: "Please Enter Requiered Parameters",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                      else{



                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(selectedjobLocation:selectedjobLocation , selectedjobType:selectedjobType , selectedjobtype:selectedjobtype, startv:startv )));
                      }






                    },
                    textColor: Colors.white,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFFed213a),
                            Color(0xFF93291e),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.search),
                          Text('  Search Job', style: TextStyle(fontSize: 20)
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
