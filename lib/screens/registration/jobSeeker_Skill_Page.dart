import 'package:flutter/material.dart';
import 'package:Workplicity/screens/registration/personal_Information.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/lists.dart';
import 'package:Workplicity/utils/strings.dart';

class SkillPage extends StatefulWidget {
  String userid ;

  SkillPage({this.userid});

  @override
  _SkillPageState createState() => _SkillPageState(userid);
}

class _SkillPageState extends State<SkillPage> {
  String selected = '';
  String userid ;

  _SkillPageState(this.userid);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Stack(
              children: <Widget>[
                BackgroundWidget(size: size),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  alignment: Alignment.center,
                  height: size.height,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50.0, right: 50.0, top: 80, bottom: 10),
                        child: LinearProgressIndicator(
                          backgroundColor: Color(0xFFD7D7D7),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
                          value: 0.5,
                        ),
                      ),
                      PageTitle(
                        titleText: Strings.jobSelectionPageTitle,
                        fontSize: 25.0,
                      ),
                      SizedBox(height: 25),
                      Container(
                        height: 450,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: ListView.builder(
                                itemCount: Lists.jobCatagories.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0.0,
                                        bottom: 5.0,
                                        left: 15.0,
                                        right: 15.0),
                                    child: Container(
                                      width: 300.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .accentColor)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: ListTile(
                                          onTap: () {
                                            selected = Lists.jobCatagories
                                                .elementAt(index);
                                          },
                                          title: Text(
                                            '${Lists.jobCatagories[index]}',
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
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
              print(selected);
              print(userid);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>NamePage(selectedjob:selected , userid:userid)));
            }),
      ),
    );
  }
}
