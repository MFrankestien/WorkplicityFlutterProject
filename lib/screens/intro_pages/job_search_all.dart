import 'package:flutter/material.dart';
import 'package:Workplicity/screens/intro_pages/sign_in_page.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/constants2.dart';
import 'package:Workplicity/utils/lists.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/bottomInfoBar.dart';
import 'package:Workplicity/utils/size_config.dart';

class JobSearchAll extends StatefulWidget {
  @override
  _JobSearchAllState createState() => _JobSearchAllState();
}

class _JobSearchAllState extends State<JobSearchAll> {
  int _jobType;
  int _jobLocation;
  int _jobTitle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            BackgroundWidget(size: size),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                alignment: Alignment.center,
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                IconButton(
                                  icon: new Icon(
                                    Icons.account_circle,
                                    color: Colors.blueAccent,
                                  ),
                                  iconSize: 35.0,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInPage()));
                                  },
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  Strings.searchJob,
                                  style: kH4DPATextStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: SizeConfig.screenWidth,
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                    color: Theme.of(context).accentColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: new Text(Strings.jobTypeDropdown),
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
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            width: SizeConfig.screenWidth,
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                    color: Theme.of(context).accentColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                hint: new Text(Strings.LocationDropdown),
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
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            width: SizeConfig.screenWidth,
                            height: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                border: Border.all(
                                    color: Theme.of(context).accentColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                hint: Text(Strings.searchJob),
                                value: _jobTitle == null
                                    ? null
                                    : Lists.jobCatagories[_jobTitle],
                                items: Lists.jobCatagories.map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _jobTitle =
                                        Lists.jobCatagories.indexOf(value);
                                  });
                                },
                              ),),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              print('search');
                            },
                            child: Container(
                              width: SizeConfig.screenWidth,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: Theme.of(context).accentColor)),
                              child: Container(
                                color: Theme.of(context).accentColor,
                                child: GestureDetector(
                                  child: ListTile(
                                    leading: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                        size: 30.0,
                                      ),
                                    ),
                                    title: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 50.0, bottom: 10.0),
                                        child: Text(
                                          Strings.search,
                                          style: kH2WTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              print('hotjobs');
                            },
                            child: Container(
                              width: SizeConfig.screenWidth,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                      color: Theme.of(context).accentColor)),
                              child: Container(
                                child: GestureDetector(
                                  child: ListTile(
                                    leading: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Icon(
                                        Icons.whatshot,
                                        color: Color(0xFFDE1E37),
                                        size: 30.0,
                                      ),
                                    ),
                                    title: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 50.0, bottom: 10.0),
                                        child: Text(
                                          Strings.viewNewJobs,
                                          style: kH2BTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: floatingActionButtonNext(
          context, MaterialPageRoute(builder: (context) => SignInPage())),
      bottomNavigationBar: BottomInfoBar(),
    );
  }
}
