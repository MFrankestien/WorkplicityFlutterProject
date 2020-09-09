import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Workplicity/utils/size_config.dart';

// FLOATING BUTTON //////////////////////////////////////////////////////////////////
FloatingActionButton floatingActionButtonNext(
    BuildContext context, MaterialPageRoute pageRoute) {
  return FloatingActionButton(
    backgroundColor: Color(0xFFDE1E37),
    onPressed: () {
      Navigator.push(context, pageRoute);
    },
    child: Icon(
      Icons.arrow_forward,
      size: 30.0,
    ),
  );
}

// BACKGROUND //////////////////////////////////////////////////////////////////////
class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Image.asset('assets/images/bottombackground.png',
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
          color: Color.fromRGBO(255, 255, 255, 0.7),
          colorBlendMode: BlendMode.modulate),
    );
  }
}

// BACK BUTTON ///////////////////////////////////////////////////////////////////////////////
class BackButtonPop extends StatelessWidget {
  const BackButtonPop({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}

class BackButtonPop2 extends StatelessWidget {
  const BackButtonPop2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class PageTitle extends StatelessWidget {
  PageTitle({this.titleText, this.fontSize, this.colour});

  final String titleText;
  final fontSize;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Text(
              titleText,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}

// INPUT FORM ////////////////////////////////////////////////////////////////////
class CommonInputForm extends StatelessWidget {
  CommonInputForm({this.labelText, this.password});

  final String labelText;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            obscureText: password,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              labelText: labelText,
              labelStyle: TextStyle(fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileImageContainer extends StatelessWidget {
  ProfileImageContainer({this.height, this.width, this.backgroundImage});
  final double height;
  final double width;
  final ImageProvider backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 70.0,
        backgroundImage: backgroundImage,
      ),
    );
  }
}

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HomeClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

//Reuse all about Preferred Area;
class RowPreferredAreas extends StatelessWidget {
  RowPreferredAreas({this.label, this.icon});

  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(10.0)),
        icon,
        Text(label, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}

class PaddingPreferredAreas extends StatelessWidget {
  PaddingPreferredAreas({this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 45.0, top: 10.0),
      child: Container(
        child: Text(
          label,
          style: TextStyle(fontSize: 15),
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}

class ButtonPaddingPreferredAreas extends StatelessWidget {
  ButtonPaddingPreferredAreas({this.label, this.onPressed});
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 45.0, top: 10.0),
        child: Container(
          alignment: Alignment.centerLeft,
          child: RaisedButton(
            onPressed: onPressed,
            child: Text(
              label,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.lightBlue,
          ),
        ));
  }
}

class RowAreas extends StatelessWidget {
  RowAreas({this.label, this.onPressed});
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RaisedButton(
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.cancel),
              ),
            ],
          ),
          onPressed: onPressed,
          color: Colors.lightBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ],
    );
  }
}

class ContainerPreferredAreas extends StatelessWidget {
  ContainerPreferredAreas({this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(label, style: TextStyle(color: Colors.black38)),
      ),
    );
  }
}

class PaddingEditAreas extends StatelessWidget {
  PaddingEditAreas({this.label, this.onPressed, this.icon});
  final String label;
  final Function onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30.0),
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(icon, color: Colors.black), onPressed: onPressed),
          Text(label)
        ],
      ),
    );
  }
}

//Reuse all about career & application;
class ContainerCareer extends StatelessWidget {
  ContainerCareer({this.initValue});
  final String initValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 40.0),
      child: Container(
        height: 120,
        child: TextFormField(
          initialValue: initValue,
          readOnly: true,
          autofocus: false,
          maxLines: 5,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

class ProfileInputField extends StatelessWidget {
  ProfileInputField({this.initValue});
  final String initValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 45.0),
      child: TextFormField(
        textDirection: TextDirection.ltr,
        initialValue: initValue,
        readOnly: true,
        autofocus: false,
        maxLines: 2,
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TextEditingCareer extends StatelessWidget {
  TextEditingCareer({this.label, this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          icon,
          color: Colors.blueAccent,
        ),
        hintText: label,
      ),
    );
  }
}

class TextFormFieldEdit extends StatelessWidget {
  TextFormFieldEdit({this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        labelText: label,
      ),
    );
  }
}

class ReuseExpanded extends StatelessWidget {
  ReuseExpanded({this.label, this.colour, this.onPressed, this.colours});
  final String label;
  final Color colour;
  final Color colours;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RaisedButton(
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(color: colour, fontWeight: FontWeight.bold),
            ),
            color: colours,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )));
  }
}

//Reuse all about Contact details;
class ContainerContact extends StatelessWidget {
  ContainerContact({this.hintText, this.icon});
  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          hintText: hintText,
        ),
      ),
    );
  }
}

class ContainerEdit extends StatelessWidget {
  ContainerEdit({this.labelText, this.icon, this.onPressed});
  final String labelText;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      width: 200,
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                labelText,
                style: TextStyle(fontSize: 15.0),
              ),
              Icon(icon, size: 20, color: Colors.blueAccent),
            ],
          ),
          onPressed: onPressed,
          color: Colors.white,
          shape: OutlineInputBorder(
              borderSide: BorderSide(
                  style: BorderStyle.solid, width: 1.0, color: Colors.black54),
              borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
    );
  }
}

//Reuse all about PersonalDetails;
class ExpandedPersonal extends StatelessWidget {
  ExpandedPersonal({this.labelText, this.colour, this.colours});
  final String labelText;
  final Color colour;
  final Color colours;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RaisedButton(
      onPressed: () {},
      child: Text(
        labelText,
        style: TextStyle(color: colour, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: colours,
    ));
  }
}

class ReExpanded extends StatelessWidget {
  ReExpanded({this.hint, this.icon});
  final String hint;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(icon, color: Colors.lightBlue),
          hintText: "National Id No",
        ),
      ),
    );
  }
}

class FieldTitleWithIcon extends StatelessWidget {
  FieldTitleWithIcon({this.title, this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: Theme.of(context).primaryColor),
        SizedBox(
          width: 1.0,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 13.0),
        ),
      ],
    );
  }
}
