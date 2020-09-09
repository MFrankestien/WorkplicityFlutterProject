import 'package:Workplicity/screens/Firm/ViewJobApplicants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/model/jobshot.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:Workplicity/services/job.dart';

class FirmJobApplications extends StatefulWidget {
  String userid;

  FirmJobApplications({this.userid});

  @override
  _FirmJobApplicationsState createState() => _FirmJobApplicationsState(userid);
}

class _FirmJobApplicationsState extends State<FirmJobApplications> {


  String userid;


  _FirmJobApplicationsState(this.userid);

  @override
  initState()   {
    super.initState();
  }

  Widget build(BuildContext context) {
    ListTile makeListTile(JobsHot job) => ListTile(
      isThreeLine: true,
      title: Text(
        job.title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            job.companyName,
            style: TextStyle(fontSize: 15.0),
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    '📅 Deadline:',
                    style: TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    job.deadline,
                    style: TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    '👥 Vacancies',
                    style: TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    job.vacancies+ ' Positions available ',
                    style: TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
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
                      job.education,
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
                      '📋 Job Nature:',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      job.JobNature,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewJobApplicants(userid: userid,Jobid:job.jobId)));

                  },
                  child: Container(
                    width: 250,
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF203354),
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                        ],

                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(5, 5),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'View Applicants',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],

            ),
          ),
        ],
      ),
      trailing: Image(
        width: 40.0,
        height: 40.0,
        image: (job.image!=null)?NetworkImage(job.image):AssetImage(
            'assets/images/jobdefault.png'),
      ),
    );

    Card makeCard(JobsHot job) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        height: 200.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: makeListTile(job),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          appBar: Firmheader(context, titleText: 'Jobs Applications'),
          body:  StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Jobs').where('FirmID',isEqualTo: userid).snapshots(),
              builder: (context,snapshot) {
                if (snapshot.hasData) {
                  List _pjobs = [];
                  for (var doc in snapshot.data.documents) {
                    var data = doc.data;

                    _pjobs.add(JobsHot(
                        jobId: doc.documentID,
                        JobNature: data['Job Nature'],
                        firmid:   data['FirmID'],
                        companyName: data['FirmName'],
                        title: data['JobTitle'],
                        requirement: data['JobRequirements'],
                        salary: data['Salary'],
                        deadline: data['Deadline'],
                        description: data['JobDescription'],
                        education: data['Education'],
                        image: data['Imageurl'],
                        location: data['Location'],
                        vacancies: data['Vacancy']));
                    print(_pjobs);
                    print("Pjobs");
                  }
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _pjobs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return makeCard(_pjobs[index]);

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