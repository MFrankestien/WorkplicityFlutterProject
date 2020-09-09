import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/JobSeeker/JobSeekerShowProfile.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';

class EditCareerApplication extends StatefulWidget {

String userid;



  @override
  _EditCareerApplicationState createState() => _EditCareerApplicationState(userid);
}

class _EditCareerApplicationState extends State<EditCareerApplication> {


  String userid;

  _EditCareerApplicationState(this.userid);


  List<String> _selectJobLevel = [
    'Entry Level Job',
    'Part Time Job',
    'Top Level Job'
  ];
  int _defaultJobLevelSelected;
  List<String> _selectJobNature = [
    'Full Time',
    'Part Time',
    'Contract',
    'Internship',
    'Freelance'
  ];
  int _defaultJobNatureSelected;
  String objective = "";
  String presentSalary = "";
  String expectedSalary = "";
  String lookingFor = "";
  String availableFor = "";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _defaultJobLevelSelected = 0;
    _defaultJobNatureSelected = 0;
    loadContact();
  }

  void _objectiveExample() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                width: double.maxFinite,
                height: 300.0,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Objective',
                              style: TextStyle(fontSize: 20.0),
                            )
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Good Example'),
                      isThreeLine: true,
                      subtitle: Text(
                        'To Build a long-term career in [specific industry] with opportunities for career growth'
                        'To enhance my educational and professional skill ia a stable and dynamic workspace. To solve'
                        'problems in a creaive and effective manner in a challenging position',
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ListTile(
                      title: Text('Bad Example'),
                      isThreeLine: true,
                      subtitle: Text(
                        'My Objective is to deliver my best to satisfy my clients. I am dedicated and hard working'
                            'I will be much active to meet deadlines of your company',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _whatIsObjective() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                width: double.maxFinite,
                height: 200.0,
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Objective',
                              style: TextStyle(fontSize: 20.0),
                            )
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      isThreeLine: true,
                      subtitle: Text(
                        'Career objective is a short summary of your career growth that complements your experience and skills'
                            'and gives prospective employers a sense of your work-related ambitions',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  TextEditingController _objective,_presentSalary,_expectedSalary,_joblevel,_jobnature;
  final _formkeyJS = GlobalKey<FormState>();

  loadContact() async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    _objective = new TextEditingController();
    _presentSalary = new TextEditingController();
    _expectedSalary = new TextEditingController();
    _joblevel = new TextEditingController();
    _jobnature = new TextEditingController();

    var d = await Firestore.instance
        .collection('Users')
        .document(user.uid)
        .get()
        .then((DocumentSnapshot) async {

      setState(() {

        _objective.text = DocumentSnapshot.data['Objective'];
        _presentSalary.text = DocumentSnapshot.data['PresentSalary'];
        _expectedSalary.text = DocumentSnapshot.data['ExpectedSalary'];
        _joblevel.text = DocumentSnapshot.data['JobLevel'];
        _jobnature.text = DocumentSnapshot.data['JobNature'];


      }

      );

    });}
  void Updatecontact () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"Objective":_objective.text,
      "PresentSalary":_presentSalary.text,"ExpectedSalary":_expectedSalary.text,"JobLevel":lookingFor,"JobNature":availableFor});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header2(context, titleText: Strings.careerAndApplication),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formkeyJS,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                TextFormField(
                  validator: (val) =>
                  val.isEmpty ? 'Enter you Objective' : null,
                  onChanged: (val) {
                    TextSelection previousSelection = _objective.selection;
                    _objective.text= val;
                    _objective.selection = previousSelection;

                  },
                  controller: _objective,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Objective",
                  ),
                ),
                GestureDetector(
                  onTap: _whatIsObjective,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text('What is Objective?'),
                        ),
                      ),
                      Icon(Icons.help)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: _objectiveExample,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.remove_red_eye),
                        Container(
                          child: Text('Example'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                  val.isEmpty ? 'Enter Your Present Salary ' : null,
                  onChanged: (val) {
                    TextSelection previousSelection = _presentSalary.selection;
                    _presentSalary.text= val;
                    _presentSalary.selection = previousSelection;

                  },
                  controller: _presentSalary,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Present Salary",
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (val) =>
                  val.isEmpty ? 'Enter Your Expected Salary ' : null,
                  onChanged: (val) {
                    TextSelection previousSelection = _expectedSalary.selection;
                    _expectedSalary.text= val;
                    _expectedSalary.selection = previousSelection;

                  },
                  controller: _expectedSalary,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    labelText: "Expected Salary",
                  ),
                ),
                SizedBox(height: 10.0),
                PageTitle(titleText: 'Looking For(Job Level)', fontSize: 18.0),
                Divider(),
                Wrap(
                  spacing: 5.0,
                  children: List<Widget>.generate(
                    _selectJobLevel.length,
                    (int index) {
                      return ChoiceChip(
                        label: Text(
                          _selectJobLevel[index],
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        backgroundColor: Colors.black26,
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        selected: _defaultJobLevelSelected == index,
                        selectedColor: Theme.of(context).primaryColor,
                        onSelected: (bool selected) {
                          setState(() {
                            _defaultJobLevelSelected = selected ? index : 0;
                          });
                          lookingFor = _selectJobLevel[index];
                        },
                      );
                    },
                  ).toList(),
                ),
                SizedBox(height: 10.0),
                PageTitle(titleText: 'Avilable For(Job Nature)', fontSize: 18.0),
                Divider(),
                Wrap(
                  spacing: 5.0,
                  children: List<Widget>.generate(
                    _selectJobNature.length,
                    (int index) {
                      return ChoiceChip(
                        label: Text(
                          _selectJobNature[index],
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        backgroundColor: Colors.black26,
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        selected: _defaultJobNatureSelected == index,
                        selectedColor: Theme.of(context).primaryColor,
                        onSelected: (bool selected) {
                          setState(() {
                            _defaultJobNatureSelected = selected ? index : 0;
                            availableFor = _selectJobNature[index];
                          });
                        },
                      );
                    },
                  ).toList(),
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
            print(_jobnature);
            print(_joblevel);
            if (_formkeyJS.currentState.validate()) {
              Updatecontact();
              print("Done");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JobSeekerShowProfile()));
            }
          }
      ),
    );
  }
}
