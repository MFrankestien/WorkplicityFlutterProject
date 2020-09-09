import 'package:Workplicity/model/JobSeeker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:Workplicity/services/job.dart';
import 'package:Workplicity/screens/Firm/CVreview.dart';

class ViewJobApplicants extends StatefulWidget {
  String userid;
  String Jobid;


  ViewJobApplicants({this.userid,this.Jobid});

  @override
  _ViewJobApplicantsState createState() => _ViewJobApplicantsState(userid,Jobid);
}

class _ViewJobApplicantsState extends State<ViewJobApplicants> {
  final _job = Joboperation();

  String userid;
  String Jobid;


  _ViewJobApplicantsState(this.userid,this.Jobid);

  @override
  initState()   {
    super.initState();
    print(Jobid);
  }

  Widget build(BuildContext context) {
    ListTile makeListTile(JobSeeker cv) => ListTile(
      isThreeLine: true,
      title: Text(
        cv.name,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            cv.Email,
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '🎓 Education:',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      cv.EducationLvl,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '📱 Phone:',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      cv.Phone,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Image(
        width: 60.0,
        height: 60.0,
        image: (cv.imageurl!=null)?NetworkImage(cv.imageurl):AssetImage(
            'assets/images/jobdefault.png'),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CVreview(jobseeker: cv,)));
      },
    );

    Card makeCard(JobSeeker cv) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        height: 160.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: makeListTile(cv),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
          appBar: Firmheader(context, titleText: 'Job Applicants'),
          body:  StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Applicants').where('JobID',isEqualTo:Jobid).snapshots(),
              builder: (context,snapshot) {
                if (snapshot.hasData) {
                  List _cv = [];
                  for (var doc in snapshot.data.documents) {
                    var data = doc.data;
                    _cv.add(JobSeeker(
                      jobtitle: data['JobTitle'],
                      docId: doc.documentID,
                      date: data['DOB'].toDate(),
                      fname: data['First Name'],
                      lname: data['Last Name'],
                      imageurl: data['Imageurl'],
                      Email: data['Email'],
                      Phone: data['Phone'],
                      EducationLvl: data['Education Level'],
                      name:  data['First Name']+ data['Last Name'],
                      religon: data['Religion'],
                      City: data['City'],
                      FullAdress: data['Full Adress'],
                      gender: data['Gender'],
                      Objective: data['Objective'],
                      nationalid: data['NationalID '],
                      InstituteName: data['Institute Name'],
                      Result: data['Result'],
                        PassingYear: data['Passing Year'],
                      CompanyName: data['Company Name'],
                      Responsabilities: data['Responsibilities'],
                    StartingYear: data['Start Date'],
                    EndYear: data['End Date'],
                        FirstLangauge: data['First Language'],
                        FirstLangReadingLvl: data['Read Level One'],
                      FirstLanguageWritingLvl: data['Wirte Level One'],
                      FirstLanguageSpeakingLvl: data['Speak Level Second'],
                      SecondLangauge: data['Second Language'],
                      SecondLangReadingLvl: data['Read Level Second'],
                      SecondLanguageWritingLvl: data['Write Level Second'],
                      SecondLanguageSpeakingLvl: data['Speak level One'],






                    ));

                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _cv.length,
                    itemBuilder: (BuildContext context, int index) {
                      return makeCard(_cv[index]);

                    },
                  );
                }
                else {
                  return Center(child: Text('loading ..'));
                }
              })),
    );
  }
}