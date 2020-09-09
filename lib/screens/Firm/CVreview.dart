import 'package:Workplicity/model/JobSeeker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:Workplicity/widgets/header.dart';
import 'dart:async';

class CVreview extends StatefulWidget {
  final JobSeeker jobseeker;
  CVreview({this.jobseeker});
  @override
  _CVreviewState createState() => _CVreviewState();
}

class _CVreviewState extends State<CVreview> {


  Future<void> CustomLaunch(command) async {
    if (await canLaunch(command) != null){
    await launch (command);

    } else {print('Couldnt Launch $command');}
  }


  var myFormat = DateFormat('d-MM-yyyy');



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String Email=widget.jobseeker.Email;
    String fullname=widget.jobseeker.fname+widget.jobseeker.lname;
    String JobTitle = widget.jobseeker.jobtitle;
    String CompanyName = widget.jobseeker.CompanyName;

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Image(
                      width: 100.0,
                      height: 100.0,
                      image: (widget.jobseeker.imageurl!=null)?NetworkImage(widget.jobseeker.imageurl):NetworkImage(
                        'https://i.stack.imgur.com/l60Hf.png',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: SizeConfig.screenWidth,
                          child: new Divider(color: Colors.blueGrey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (widget.jobseeker.name!=null)?Text(
                            widget.jobseeker.name,
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ):  SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        ClipPath(
          clipBehavior: Clip.antiAlias,
          clipper: HomeClipper2(),
          child:  Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Center(
              child: topContentText,
            ),
          ),
        ),

      ],
    );

    final bottomContentText = Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ////Personal Information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                    'Personal Information:',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(
                children: <Widget>[

                  Expanded(
                    flex: 2,
                    child: Text(
                      '📅 Date Of Birth:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: (widget.jobseeker.date!=null)?Text(
                      myFormat.format(widget.jobseeker.date),
                      style: TextStyle(fontSize: 18.0),
                    ):
                    Text('Complete your profile to show '),
                  ),
                ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '👨👩 Gender:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.gender!=null)?Text(
                    widget.jobseeker.gender,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    ' 🙏 Religion:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.religon!=null)?Text(
                    widget.jobseeker.religon,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    ' ║▌ National ID:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.nationalid!=null)?Text(
                    widget.jobseeker.nationalid,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),

            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          /////////////////////////////////////Contact Information/////////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                    'Contact Information:',
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '📍 City:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.City!=null)?Text(
                    widget.jobseeker.City,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '🏢 Address:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.FullAdress!=null)?Text(
                    widget.jobseeker.FullAdress,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '📞 Phone:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.Phone!=null)?Text(
                    widget.jobseeker.Phone,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    '📧 E-mail:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.Email!=null)?Text(
                    widget.jobseeker.Email,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          /////////////////////////////////////Career Application/////////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Career Information:',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'My Objective:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.Objective!=null)?Text(
                    widget.jobseeker.Objective,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),

            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),

          /////////////////////////////////////Education/////////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Academic Qualifications :',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Institute Name:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.InstituteName!=null)?Text(
                    widget.jobseeker.InstituteName,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Academic Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.EducationLvl!=null)?Text(
                    widget.jobseeker.EducationLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Result:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.Result!=null)?Text(
                    widget.jobseeker.Result,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Passing Year:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.PassingYear!=null)?Text(
                    widget.jobseeker.PassingYear,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          /////////////////////////////////////Employment History/////////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Employment History :',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Company Name:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.CompanyName!=null)?Text(
                    widget.jobseeker.CompanyName,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Department:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.Department!=null)?Text(
                    widget.jobseeker.Department,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Responsibilities:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: (widget.jobseeker.Responsabilities!=null)?Text(
                      widget.jobseeker.Responsabilities,
                      style: TextStyle(fontSize: 18.0),
                    ):
                    Text('Complete your profile to show '),
                  ),
                ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Start Year:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.StartingYear!=null)?Text(
                    widget.jobseeker.StartingYear,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'End Year:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.EndYear!=null)?Text(
                    widget.jobseeker.EndYear,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,)
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          /////////////////////////////////////Language Proficiency//////////////////////////////////
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Language Proficiency :',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 250.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'First Language',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 170.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'First Language:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.FirstLangauge!=null)?Text(
                    widget.jobseeker.FirstLangauge,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Reading Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.FirstLangReadingLvl!=null)?Text(
                    widget.jobseeker.FirstLangReadingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Writing Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.FirstLanguageWritingLvl!=null)?Text(
                    widget.jobseeker.FirstLanguageWritingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Speaking Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.FirstLanguageSpeakingLvl!=null)?Text(
                    widget.jobseeker.FirstLanguageSpeakingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.only(top:10.0),
                child: Text(
                  'Second Language',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:10.0),
                child: Container(
                  width: 170.0,
                  child: new Divider(color: Theme.of(context).primaryColor),
                ),
              ),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Second Language:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.SecondLangauge!=null)?Text(
                    widget.jobseeker.SecondLangauge,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Reading Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.SecondLangReadingLvl!=null)?Text(
                    widget.jobseeker.SecondLangReadingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Writing Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.SecondLanguageWritingLvl!=null)?Text(
                    widget.jobseeker.SecondLanguageWritingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
              SizedBox(height: 10,),
              Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text(
                    'Speaking Level:',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: (widget.jobseeker.SecondLanguageSpeakingLvl!=null)?Text(
                    widget.jobseeker.SecondLanguageSpeakingLvl,
                    style: TextStyle(fontSize: 18.0),
                  ):
                  Text('Complete your profile to show '),
                ),
              ],),
            ],
          ),
          Container(
            width: SizeConfig.screenWidth,
            child: new Divider(color: Colors.blueGrey),
          ),
          SizedBox(height: 20,),
          Row(
            children: <Widget>[
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(color: Colors.red, onPressed: (){
                Firestore.instance
                    .collection('Applicants')
                    .document(widget.jobseeker.docId).updateData({'Accepted':false});
                CustomLaunch('mailto:$Email?subject=$JobTitle - $CompanyName  &body= Thank you very much $fullname for your interest in employment opportunities with $CompanyName company.\n \nThis message is to inform you that we have selected a candidate who is a match for the job requirements of the position.\n \nWe appreciate you taking the time to apply for employment with our company and wish you the best of luck in your future endeavors.\n \n We have a place for you with us still!!\n\n We have provided a list of feedback on how you can improve yourself down below:\n\n 1-..........\n\n 2-..........\n\n 3-.......... \n\n We wish that you will reach out for us in the future as well after considering our feedback \n\n Best regards,$CompanyName');
              }, child: Text('Reject'),
               ),
            )),
              Expanded(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(color: Colors.green, onPressed: (){

                  Firestore.instance
                      .collection('Applicants')
                      .document(widget.jobseeker.docId).updateData({'Accepted':true});
                  CustomLaunch('mailto:$Email?subject=$JobTitle - $CompanyName &body= Hello MR/Mrs $fullname \n \n We extend our gratitude and would like to inform you for being accepted for the position of $JobTitle in $CompanyName.\n \n We are delighted and looking forward to commencing work with you.\n \n Best Regards, $CompanyName');

                }, child: Text('Accept')),
              ))

            ],
          ),

        ],
      ),
    );
    return WillPopScope(
      onWillPop: () => Future.value(true),
      child: Scaffold(
        appBar: CReview(context, titleText: 'C.V Review',docid: widget.jobseeker.docId),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[topContent, bottomContentText],
          ),
        ),
      ),
    );
  }


}

