import 'package:flutter/material.dart';
import 'package:Workplicity/utils/size_config.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Image companyLogo() {
  return Image(
    image: AssetImage('assets/images/Workplicity.png'),
    height: SizeConfig.blockSizeVertical * 30,
  );
}

var alertStyle = AlertStyle(
  animationType: AnimationType.fromBottom,
  animationDuration: Duration(milliseconds: 400),
  isCloseButton: false,
);

// ignore: missing_return
Alert onAlertWithCustomContentPressed(context) {
  Alert(
      context: context,
      title: "Manage Resume",
      style: alertStyle,
      content: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 50,
              child: FlatButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.border_color,
                      size: 35,
                      color: Colors.teal,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Edit Resume",
                          style: TextStyle(fontSize: 20.0, color: Colors.teal),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
                textColor: Colors.white,
                color: Colors.white,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 1.0,
                        color: Colors.black),
                    borderRadius: new BorderRadius.circular(15.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 50,
              child: FlatButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.visibility,
                      size: 35,
                      color: Colors.teal,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "View Resume",
                          style: TextStyle(fontSize: 20.0, color: Colors.teal),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
                textColor: Colors.teal,
                color: Colors.white,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 1.0,
                        color: Colors.black),
                    borderRadius: new BorderRadius.circular(15.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 50,
              child: FlatButton(
                child: Row(
                  children: [
                    Icon(
                      Icons.cloud_upload,
                      size: 35,
                      color: Colors.teal,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Upload Resume",
                          style: TextStyle(fontSize: 20.0, color: Colors.teal),
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
                textColor: Colors.white,
                color: Colors.white,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid,
                        width: 1.0,
                        color: Colors.black),
                    borderRadius: new BorderRadius.circular(15.0)),
              ),
            ),
          ),
        ],
      ),
      buttons: []).show();
}
