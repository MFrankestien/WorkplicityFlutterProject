import 'package:Workplicity/screens/Search/SearchMain.dart';
import 'package:Workplicity/screens/Search/SearchResult.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Workplicity/screens/Firm/add_new_jobs.dart';
import 'package:Workplicity/screens/Firm/firm_profile_main.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirmHomeSearch extends StatefulWidget {
  @override
  _FirmHomeSearchState createState() => _FirmHomeSearchState();
}

class _FirmHomeSearchState extends State<FirmHomeSearch> {
  RangeValues value =RangeValues(1,100);
  int _jobType;
  int _jobLocation;
  String selectedjobType,selectedjobLocation;

  SharedPreferences preferences;
  String urls;
  String Fname,Lname,Firmname,name;
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

  List<String> jobType = <String>[
    'Accounting/Finance',
    'Bank',
    'Non-Bank Fin. Institution',
    'Commercial/Supply Chain',
    'Education/Training',
    'Engineer/Architects',
    'Garments/Textile',
    'HR/Org. Development',
    'Gen Mgt/Admin',
    'Design/Creative',
    'Production/Operation',
    'Hospitality/Travel/Tourism',
    'Beauty Care/Health & Fitness',
    'Electrician/Construction/Repair',
    'IT & Telecommunication',
    'Marketing/Sales',
    'Customer Support/Call Centre',
    'Media/Ad./Event Mgt.',
    'Medical/Pharma',
    'Agro(Plant/Animal/Fisheries)',
    'NGO/Development',
    'Research/Consultancy',
    'Secretary/Receptionist',
    'Data Entry/Operator/BPO',
    'Driving/Motor Technician',
    'Security/Support Service',
    'Law/Legal',
    'Others'
  ];

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
        Firmname = DocumentSnapshot.data['FirmName'];
        name='$Fname $Lname';
        print(Fname); print(Lname); print(Firmname);
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
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Material(
              elevation: 15.0,
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0)),
              child: Container(
                height: 240.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: GestureDetector(
                                onTap: () {
                                  print('Notifications');
                                },
                                child: Icon(
                                  Icons.notifications_active,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: GestureDetector(
                                onTap: _onExitTap,
                                child: Icon(
                                  Icons.exit_to_app,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FirmProfileMain()));
                            },
                            child: Hero(
                              tag: 'profileImage',
                              child: ProfileImageContainer(
                                height: 90.0,
                                width: 90.0,
                                backgroundImage:
                                (urls!=null)?NetworkImage(urls):NetworkImage(
                                  'https://i.stack.imgur.com/l60Hf.png',
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(height: 20,),
                              (name!=null)?Text(
                                '$Fname $Lname',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ):  SizedBox(
                                child: CircularProgressIndicator(),
                                height: 15.0,
                                width: 15.0,
                              ),
                (name!=null)?Text(
                  '$Firmname',
                  style: TextStyle(
                      fontSize: 15.0, color: Colors.white),
                ):  SizedBox(
                  child: CircularProgressIndicator(),
                  height: 15.0,
                  width: 15.0,
                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
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
                      value: _jobType == null ? null : jobType[_jobType],
                      items: jobType.map((String value) {
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
                      onChanged: (value) {
                        setState(() {
                          _jobType = jobType.indexOf(value);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(FontAwesomeIcons.filter),
                  FlatButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchMain()));
                    },
                    child: GestureDetector(
                      child: Text('Advanced Search',
                        style: TextStyle(
                            fontSize: 18, color: Color(0xFF0D47A1)),
                      ),),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              width: 200.0,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      if(selectedjobLocation!=null){

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(selectedjobLocation:selectedjobLocation)));

                        print('1');
                      }
                      if(selectedjobType!=null){

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(selectedjobType:selectedjobType)));
                        print('2');
                      }
                      if(selectedjobLocation!=null&&selectedjobType!=null){

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(selectedjobLocation:selectedjobLocation , selectedjobType:selectedjobType)));
                        print('3');
                      }
                      if(selectedjobLocation==null&&selectedjobType==null){
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
                          Text('  Search Job', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddNewJob()));
                    },
                    textColor: Colors.white,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0097A7),
                            Color(0xFF212121),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.plus),
                          Text('    Add Job ', style: TextStyle(fontSize: 20)),
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
