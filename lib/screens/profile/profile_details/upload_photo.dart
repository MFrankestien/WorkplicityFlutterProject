import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Workplicity/utils/strings.dart';
import 'package:Workplicity/widgets/header.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {


  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    String fileName = basename(_image.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);

    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    String downlaodUrl = await taskSnapshot.ref.getDownloadURL();
    if(downlaodUrl!=null){
      urls=downlaodUrl;
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      Firestore.instance.collection('Users').document(user.uid).updateData({"ImageURL":downlaodUrl});
      SharedPreferences preferences=await SharedPreferences.getInstance();
      preferences.setString('Url', downlaodUrl);
      print(user.uid);

    }


  }
  SharedPreferences preferences;
  File _image;
  String urls;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => preferences = prefs);
      urls =preferences.getString("Url");
    });

  }



  @override
  Widget build(BuildContext context) {



// get image from gallery

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: header2(
      context,
      titleText: Strings.personalDetails,

    ),
      body:SingleChildScrollView(

              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Color(0xff476cfb),
                            child: ClipOval(
                              child: new SizedBox(
                                width: 180.0,
                                height: 180.0,
                                child: (_image!=null)?Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                ):(urls!=null)?Image.network(
                                  urls,
                                  fit: BoxFit.fill,
                                ):Image.network(
                                  'https://i.stack.imgur.com/l60Hf.png'
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 60.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 50.0,
                            ),
                            onPressed: () {
                              getImage();

                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Upload JPG,GIF, PNG or BMP',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        ' Max Size of Photo is 3 MB',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                    ),

                  ],
                ),
              ),

          ));



  }


}

