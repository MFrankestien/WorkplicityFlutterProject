import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/model/jobshot.dart';
import 'package:Workplicity/screens/main_menu/job_details_page.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:Workplicity/services/job.dart';

class SearchResult extends StatefulWidget {

  String selectedjobType,selectedjobLocation,selectedjobtype,startv;


  SearchResult({this.selectedjobType, this.selectedjobLocation,this.selectedjobtype, this.startv,});

  @override
  _SearchResultState createState() => _SearchResultState(selectedjobType,selectedjobLocation,selectedjobtype,startv);
}

class _SearchResultState extends State<SearchResult> {
  final _job = Joboperation();
  final Firestore _firestore = Firestore.instance;
  List jobs;
  String selectedjobType,selectedjobLocation,selectedjobtype,startv;

  _SearchResultState(this.selectedjobType, this.selectedjobLocation,this.selectedjobtype,this.startv);

  @override
  void initState() {
    super.initState();
    print('n$selectedjobtype');
    print('s$startv');

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
        ],
      ),
      trailing: Image(
        width: 40.0,
        height: 40.0,
        image: (job.image!=null)?NetworkImage(job.image):AssetImage(
            'assets/images/jobdefault.png'),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobDetailsPage(jobsHot: job)));
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
      appBar: JobSeekerHeader(context, titleText: 'Hot Jobs'),
      body:  StreamBuilder<QuerySnapshot>(
          stream:  _firestore.collection('Jobs').where('Location',isEqualTo: selectedjobLocation ).where('Job Categories', isEqualTo: selectedjobType).where('Job Nature',isEqualTo: selectedjobtype).where('Salary',isGreaterThanOrEqualTo: startv).snapshots(),
          builder: (context,snapshot) {
            if (snapshot.hasData) {
              List _jobs = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;

                _jobs.add(JobsHot(
                    jobId: doc.documentID,
                    JobNature: data['Job Nature'],
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

                print(_jobs);
                print('jobs');
              }
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _jobs.length,
                itemBuilder: (BuildContext context, int index) {
                  return makeCard(_jobs[index]);

                },
              );
            }
            else {
              return Center(child: Text('loading ..'));
            }
          }),
    );
  }
}