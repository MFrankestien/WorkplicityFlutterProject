import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:Workplicity/screens/Firm/firm_home_page.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:Workplicity/services/job.dart';
import 'package:Workplicity/model/jobshot.dart';

class AddNewJob extends StatefulWidget {
  @override
  _AddNewJobState createState() => _AddNewJobState();
}

class _AddNewJobState extends State<AddNewJob> {
  String jobvacancy;
  String jobTitle;
  String salary;
  String firmName,firmId;
  String requiredEducation;
  String jobDescription;
  String jobRequirements;
  String city = 'Select City';
  String JobCat = 'Select Job Categories';
  String JobNature = 'Select Job Nature';
  File _image;
  String urls;
  final _formkeyNJ = GlobalKey<FormState>();
  final Firestore _firestore = Firestore.instance;
  String type;

  final _jobOperation = Joboperation();

  DateTime _date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
    );
    if (_date != null && picked != _date) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downlaodUrl = await taskSnapshot.ref.getDownloadURL();
    if (downlaodUrl != null) {
      urls = downlaodUrl;
      print(urls);
    }
  }

  Future<List<DocumentSnapshot>> getProduceID() async {
    FirebaseUser userid = await FirebaseAuth.instance.currentUser();
    var data = await Firestore.instance.collection('Jobs').getDocuments();
    var productList = data.documents;
    print("Data length: ${productList.length}");
    for (int i = 0; i < productList.length; i++) {
      var productId = Firestore.instance
          .collection('products')
          .document(productList[i]['productId'])
          .documentID;
      if (productId != null) {
        print("Data: " + productId);
      }
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    String _formatDate = DateFormat.yMMMd().format(_date);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header2(
        context,
        titleText: Strings.AddJob,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                  minWidth: viewportConstraints.maxWidth),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formkeyNJ,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: Color(0xff476cfb),
                                child: ClipOval(
                                  child: new SizedBox(
                                      width: 150.0,
                                      height: 150.0,
                                      child: (_image != null)
                                          ? Image.file(
                                              _image,
                                              fit: BoxFit.fill,
                                            )
                                          : (urls != null)
                                              ? Image.network(
                                                  urls,
                                                  fit: BoxFit.fill,                                                )
                                              : Image(
                                                  image: AssetImage(
                                                      'assets/images/jobdefault.png'),
                                                )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 60.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_a_photo,
                                  size: 40.0,
                                ),
                                onPressed: () {
                                  getImage();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Job Title' : null,
                            onChanged: (val) {
                              setState(() => jobTitle = val);
                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Job Title",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Salary' : null,
                            onChanged: (val) {
                              setState(() => salary = val);
                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Salary',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Firm Name' : null,
                            onChanged: (val) {
                              setState(() => firmName = val);
                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Firm Name',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Required Education' : null,
                            onChanged: (val) {
                              setState(() => requiredEducation = val);
                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Required Education',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        DropdownButton<String>(
                          value: city,
                          icon: Icon(Icons.location_city),
                          iconSize: 20,
                          elevation: 16,
                          style: TextStyle(color: Color(0xFF203354)),
                          underline: Container(
                            height: 2,
                            color: Colors.blueAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              city = newValue;
                            });
                          },
                          items: <String>[
                            'Select City',
                            'Cairo',
                            'Alexandria',
                            'Al Gīzah',
                            '6 October',
                            'Zamalek',
                            'Mohandesen',
                            'Nasr city',
                            'Masr El gdeda',
                            'Zayed City',
                            'Rehab',
                            'fifth settlement',
                            'Dokki',
                            'Ismailia',
                            'Port Said',
                            'Luxor',
                            'Sūhāj',
                            'Al Mansurah',
                            'Suez',
                            'Al Minya',
                            'Damanhur',
                            'Bani Suwayf',
                            'Asyuţ',
                            'Tanta',
                            'Al Fayyum',
                            'Aswan',
                            'Qina',
                            'Mallawi',
                            'Al Arish',
                            'Banha',
                            'Kafr EL Shaykh',
                            'Jirja',
                            'Marsa Matruh',
                            'Isna',
                            'Bani Mazar',
                            'Safajah',
                            'Sinai',
                            'Siwah',
                            'Al Alamayn',
                            'Al Sallūm',
                            'Al Ghardaqah',
                            'Rafaḩ',
                            'Shibin al Kawm',
                            'Damietta',
                            'Ash Shaykh Zuwayd',
                            'Az Zaqaziq'
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
                        Divider(),
                        DropdownButton<String>(
                          value: JobNature,
                          icon: Icon(Icons.location_city),
                          iconSize: 20,
                          elevation: 16,
                          style: TextStyle(color: Color(0xFF203354)),
                          underline: Container(
                            height: 2,
                            color: Colors.blueAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              JobNature = newValue;
                            });
                          },
                          items: <String>[
                            'Select Job Nature',
                            'Part Time',
                            'Full Time',
                            'Contract',
                            'internship',
                            'Freelance',

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
                        Divider(),
                        DropdownButton<String>(
                          value: JobCat,
                          icon: Icon(FontAwesomeIcons.briefcase),
                          iconSize: 20,
                          elevation: 16,
                          style: TextStyle(color: Color(0xFF203354)),
                          underline: Container(
                            height: 2,
                            color: Colors.blueAccent,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              JobCat = newValue;
                            });
                          },
                          items: <String>[
                            'Select Job Categories',
                            'Accounting/Finance',
                            'Bank',
                            'Non-Bank Fin. Institution',
                            'Commercial/Supply Chain',
                            'Education/Training',
                            'Engineer/Architects',
                            'Garments/Textile',
                            'HR/Org. Development',
                            'Gen Mgt/Admin',
                            'Design/Creative',
                            'Production/Operation',
                            'Hospitality/Travel/Tourism',
                            'Beauty Care/Health & Fitness',
                            'Electrician/Construction/Repair',
                            'IT & Telecommunication',
                            'Marketing/Sales',
                            'Customer Support/Call Centre',
                            'Media/Ad./Event Mgt.',
                            'Medical/Pharma',
                            'Agro(Plant/Animal/Fisheries)',
                            'NGO/Development',
                            'Research/Consultancy',
                            'Secretary/Receptionist',
                            'Data Entry/Operator/BPO',
                            'Driving/Motor Technician',
                            'Security/Support Service',
                            'Law/Legal',
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
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: _InputDropdown(
                                labelText: "Dead Line",
                                valueText: _formatDate,
                                onPressed: () {
                                  selectDate(context);
                                },
                              ),
                            ),
                            SizedBox(width: 8.0),
                          ],
                        ),
                        Divider(),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                            validator: (val) =>
                                val.isEmpty ? 'Enter Job Vacancy' : null,
                            onChanged: (val) {
                              setState(() => jobvacancy = val);
                            },
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: "Vacancy Number",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Job Vacancy' : null,
                            onChanged: (val) {
                              setState(() => jobDescription = val);
                            },
                            maxLines: 10,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Job Description',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                        TextFormField(
                            validator: (val) =>
                                val.isEmpty ? 'Enter Job Requirements' : null,
                            onChanged: (val) {
                              setState(() => jobRequirements = val);
                            },
                            maxLines: 10,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.teal,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Job Requirements',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blueAccent, width: 32.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                            )),
                        Divider(),
                      ],
                    ),
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
            if (_formkeyNJ.currentState.validate()) {
              FirebaseUser user = await FirebaseAuth.instance.currentUser();
              firmId=user.uid;
              _jobOperation.addJob(JobsHot(
                  JobCat: JobCat,
                JobNature: JobNature,
                firmid: firmId,
                  companyName: firmName,
                  title: jobTitle,
                  image: urls,
                  deadline: _formatDate,
                  vacancies: jobvacancy,
                  salary: salary,
                  description: jobDescription,
                  requirement: jobRequirements,
                  location: city,
                  education: requiredEducation));
              Fluttertoast.showToast(
                  msg: "Job Added Succefully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FirmHomePage()));
            }
          }),
    );
  }
}

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.onPressed,
      this.onChanged})
      : super(key: key);

  final String labelText;
  final String valueText;
  final VoidCallback onPressed;
  final VoidCallback onChanged;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          labelText: labelText,
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText),
            new Icon(Icons.calendar_today,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}
