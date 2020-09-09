
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/model/jobshot.dart';
import 'package:Workplicity/screens/main_menu/job_details_page.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:Workplicity/services/job.dart';

class AppliedJobs extends StatefulWidget {
  String userid;


  AppliedJobs({this.userid});

  @override
  _AppliedJobsState createState() => _AppliedJobsState(userid);
}

class _AppliedJobsState extends State<AppliedJobs> {
  final _job = Joboperation();

  String userid;
  bool show=false;


  _AppliedJobsState(this.userid);

  @override
  initState() {
    super.initState();
   getusertype();
  }
  getusertype() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    userid=user.uid;
    print(userid);}
  String status='Pending..';

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
            height: 7.0,
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
          SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            (job.Accepted==true)? Padding(
              padding: const EdgeInsets.only(left:35.0,bottom: 6),
              child: FlatButton(color: Colors.green ,onPressed: (){}, child: (Text('Accepted'))),
            ):Padding(
              padding: const EdgeInsets.only(left:35.0,bottom: 6),
              child: FlatButton(color: Colors.red,onPressed: (){}, child: Text('Rejected')),
            ),
          ],)
        ],
      ),
      trailing: Image(
        width: 40.0,
        height: 40.0,
        image: (job.image!=null)?NetworkImage(job.image):AssetImage(
            'assets/images/jobdefault.png'),
      ),
      onTap: () {
        print(show);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobDetailsPage(jobsHot: job,show:show)));
      },
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

    return Scaffold(
        appBar: JobSeekerHeader (context, titleText: 'Applied Jobs'),
        body:  StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('Applicants').where('UserId',isEqualTo: userid).snapshots(),
            builder: (context,snapshot) {
              if (snapshot.hasData) {


                List _pjobs = [];
                for (var doc in snapshot.data.documents) {
                  var data = doc.data;
print(userid);

                  _pjobs.add(JobsHot(
                      Accepted: data['Accepted'],
                      JobNature: data['Job Nature'].toString(),
                      firmid:   data['FirmID'],
                      companyName: data['FirmName'],
                      title: data['JobTitle'],
                      requirement:data['JobRequirement'],
                      salary: data['Salary'],
                      deadline: data['Deadline'],
                      description: data['JobDescription'],
                      education: data['Education'],
                      image:data['FImageurl'],
                      location:data['Location'],
                      vacancies:data['Vacancy']));
                  print(_pjobs.length);
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
            }));
  }
}