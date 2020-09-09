import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/screens/JobSeeker/JobSeekerShowProfile.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';


class AddLanguageProficiency extends StatefulWidget {
  @override
  _AddLanguageProficiencyState createState() =>
      _AddLanguageProficiencyState();
}

class _AddLanguageProficiencyState extends State<AddLanguageProficiency> {
  List<String> Language = <String>[
    'Select',
    'Arabic',
    'English',
    'Spanish',
    'Italian',
    'French',
    'German',
    'Russian',
    'Chinese',
    'Japanese',
    'Korean',
    'Turkish',
    'Others'
  ];

  List<String> _selectReadingChoice = ['High', 'Medium', 'Low'];
  int _defaultReadingChoiceIndex,_defaultReadingChoiceIndex1;
  List<String> _selectWritingChoice = ['High', 'Medium', 'Low'];
  int _defaultWritingChoiceIndex,_defaultWritingChoiceIndex1;
  List<String> _selectSpeakingChoice = ['High', 'Medium', 'Low'];
  int _defaultSpeakingChoiceIndex,_defaultSpeakingChoiceIndex1;
  String r='High',w='High',s='High',r1='High',w1='High',s1='High' ,language='Select',language1='Select';

  void Updateinfo () async {

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('Users').document(user.uid).updateData({"First Language":language,
      "Read Level":r,"Write Level":w,"Speak level":s,"Second Language":language1,
      "Second Read Level":r1,"Second Write Level":w1,"Second Speak level":s1});
    print(user.uid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _defaultReadingChoiceIndex = 0;
    _defaultWritingChoiceIndex = 0;
    _defaultSpeakingChoiceIndex = 0;
    _defaultReadingChoiceIndex1 = 0;
    _defaultWritingChoiceIndex1 = 0;
    _defaultSpeakingChoiceIndex1 = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header2(
        context,
        titleText: Strings.languageProficiency,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: viewportConstraints.maxWidth),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: language,
                        icon: Icon(Icons.language),
                        iconSize: 20,
                        elevation: 16,
                        style: TextStyle(color: Color(0xFF203354)),
                        underline: Container(
                          height: 2,
                          color: Colors.blueAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            language = newValue;
                          });
                        },
                        items: <String>[
                          'Select',
                          'Arabic',
                          'English',
                          'Spanish',
                          'Italian',
                          'French',
                          'German',
                          'Russian',
                          'Chinese',
                          'Japanese',
                          'Korean',
                          'Turkish',
                          'Others'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }).toList(),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Reading*',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          3,
                              (int index) {
                            return ChoiceChip(
                              label: Text(
                                _selectReadingChoice[index],
                                style: TextStyle(color: Colors.white, fontSize: 15.0),
                              ),
                              backgroundColor: Colors.black26,
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              selected: _defaultReadingChoiceIndex == index,
                              selectedColor: Theme.of(context).primaryColor,
                              onSelected: (bool selected) {
                                setState(() {
                                  _defaultReadingChoiceIndex = selected ? index : 0;
                                  r=_selectReadingChoice.elementAt(_defaultReadingChoiceIndex);
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Writing*',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          3,
                              (int index) {
                            return ChoiceChip(
                              label: Text(
                                _selectWritingChoice[index],
                                style: TextStyle(color: Colors.white, fontSize: 15.0),
                              ),
                              backgroundColor: Colors.black26,
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              selected: _defaultWritingChoiceIndex == index,
                              selectedColor: Theme.of(context).primaryColor,
                              onSelected: (bool selected) {
                                setState(() {
                                  _defaultWritingChoiceIndex = selected ? index : 0;
                                  w=_selectWritingChoice.elementAt(_defaultWritingChoiceIndex);
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Speaking*',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          3,
                              (int index) {
                            return ChoiceChip(
                              label: Text(
                                _selectSpeakingChoice[index],
                                style: TextStyle(color: Colors.white, fontSize: 15.0),
                              ),
                              backgroundColor: Colors.black26,
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              selected: _defaultSpeakingChoiceIndex == index,
                              selectedColor: Theme.of(context).primaryColor,
                              onSelected: (bool selected) {
                                setState(() {
                                  _defaultSpeakingChoiceIndex = selected ? index : 0;
                                  s=_selectSpeakingChoice.elementAt(_defaultSpeakingChoiceIndex);
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: SizeConfig.screenWidth,
                        child: new Divider(color: Colors.blueGrey),
                      ),
                      SizedBox(height: 20,),
                      DropdownButton<String>(
                        value: language1,
                        icon: Icon(Icons.language),
                        iconSize: 20,
                        elevation: 16,
                        style: TextStyle(color: Color(0xFF203354)),
                        underline: Container(
                          height: 2,
                          color: Colors.blueAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            language1 = newValue;
                          });
                        },
                        items: <String>[
                          'Select',
                          'Arabic',
                          'English',
                          'Spanish',
                          'Italian',
                          'French',
                          'German',
                          'Russian',
                          'Chinese',
                          'Japanese',
                          'Korean',
                          'Turkish',
                          'Others'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }).toList(),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Reading*',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          3,
                              (int index) {
                            return ChoiceChip(
                              label: Text(
                                _selectReadingChoice[index],
                                style: TextStyle(color: Colors.white, fontSize: 15.0),
                              ),
                              backgroundColor: Colors.black26,
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              selected: _defaultReadingChoiceIndex1 == index,
                              selectedColor: Theme.of(context).primaryColor,
                              onSelected: (bool selected) {
                                setState(() {
                                  _defaultReadingChoiceIndex1 = selected ? index : 0;
                                  r1=_selectReadingChoice.elementAt(_defaultReadingChoiceIndex1);
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Writing*',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          3,
                              (int index) {
                            return ChoiceChip(
                              label: Text(
                                _selectWritingChoice[index],
                                style: TextStyle(color: Colors.white, fontSize: 15.0),
                              ),
                              backgroundColor: Colors.black26,
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              selected: _defaultWritingChoiceIndex1 == index,
                              selectedColor: Theme.of(context).primaryColor,
                              onSelected: (bool selected) {
                                setState(() {
                                  _defaultWritingChoiceIndex1 = selected ? index : 0;
                                  w1=_selectWritingChoice.elementAt(_defaultWritingChoiceIndex1);
                                });
                              },
                            );
                          },
                        ).toList(),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Speaking*',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          3,
                              (int index) {
                            return ChoiceChip(
                              label: Text(
                                _selectSpeakingChoice[index],
                                style: TextStyle(color: Colors.white, fontSize: 15.0),
                              ),
                              backgroundColor: Colors.black26,
                              padding: EdgeInsets.all(5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              selected: _defaultSpeakingChoiceIndex1 == index,
                              selectedColor: Theme.of(context).primaryColor,
                              onSelected: (bool selected) {
                                setState(() {
                                  _defaultSpeakingChoiceIndex1 = selected ? index : 0;
                                  s1=_selectSpeakingChoice.elementAt(_defaultSpeakingChoiceIndex1);
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
          onPressed: () async {
Updateinfo();
Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) =>
            JobSeekerShowProfile()));
          }),
    );
  }
}
