import 'package:flutter/material.dart';
import 'package:Workplicity/utils/lists.dart';
import 'package:Workplicity/utils/size_config.dart';

class JobSearchSecond extends StatefulWidget {
  @override
  _JobSearchSecondState createState() => _JobSearchSecondState();
}

class _JobSearchSecondState extends State<JobSearchSecond> {
  int _jobType;
  int _jobLocation;

  int _jobKeyWord;
  int _jobSpecial;
  List<String> _selectExperience = [
    'Less than 1 year',
    '1 Year',
    '3 - 5 Years',
    '5 - 10 Years',
    'Over 10 Years'
  ];
  int _defaultExperienceSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _defaultExperienceSelected = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: <Widget>[
          SizedBox(
            height: 10.0,
            child: FlatButton(
              child: Text('Search'),
              color: Colors.red,
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 350.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                color: Color(0xFF000000), width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: new Text(
                                    'Keyword'),
                                value: _jobKeyWord == null
                                    ? null
                                    : Lists.jobKeyWord[_jobKeyWord],
                                items: Lists.jobKeyWord.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _jobKeyWord =
                                        Lists.jobKeyWord.indexOf(value);
                                  });
                                },
                              ),
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
                                color: Color(0xFF000000), width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: new Text(
                                    'General Category'),
                                value: _jobType == null
                                    ? null
                                    : Lists.jobType[_jobType],
                                items: Lists.jobType.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _jobType = Lists.jobType.indexOf(value);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: SizeConfig.screenWidth * .95,
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    Text("    OR    "),
                    Expanded(
                      child: Divider(
                        thickness: 2.0,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 350.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(
                                color: Color(0xFF000000), width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: new Text(
                                    'Special Skilled Category'),
                                value: _jobSpecial == null
                                    ? null
                                    : Lists.jobSpecial[_jobSpecial],
                                items: Lists.jobSpecial.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _jobSpecial =
                                        Lists.jobSpecial.indexOf(value);
                                  });
                                },
                              ),
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
                                color: Color(0xFF000000), width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
//                                iconEnabledColor: Colors.white,
//                                iconDisabledColor: Colors.white,
                                hint: new Text(
                                    'Location'),
                                value: _jobLocation == null
                                    ? null
                                    : Lists.jobLocation[_jobLocation],
                                items: Lists.jobLocation.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _jobLocation =
                                        Lists.jobLocation.indexOf(value);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: SizeConfig.screenWidth * .95,
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 2.0,
                        color: Colors.black,
                      ),
                    ),
                    Text("    Experience    "),
                    Expanded(
                      child: Divider(
                        thickness: 2.0,
                        color: Colors.black,
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Wrap(
                  spacing: 5.0,
                  children: List<Widget>.generate(
                    _selectExperience.length,
                        (int index) {
                      return ChoiceChip(
                        label: Text(
                          _selectExperience[index],
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        backgroundColor: Colors.black26,
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        selected: _defaultExperienceSelected == index,
                        selectedColor: Theme.of(context).primaryColor,
                        onSelected: (bool selected) {
                          setState(() {
                            _defaultExperienceSelected = selected ? index : 0;
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
  }
}
