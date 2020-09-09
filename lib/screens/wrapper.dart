
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Workplicity/Authenticate/authenticate.dart';
import 'package:Workplicity/model/user.dart';
import 'package:Workplicity/screens/main_menu/navbar_builder.dart';
import 'package:Workplicity/screens/Firm/firm_home_page.dart';


class Wrapper extends StatelessWidget {

var id,UserType;

Wrapper({this.id, this.UserType});

@override
  Widget build(BuildContext context) {
  final user = Provider.of<User>(context);
  print(user);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    }
    else {
      if (UserType == 'Jobseeker') {
        print('hi jobs');

        return HomePage();
      }
      if(UserType=='Firm'){
        print('hi Firm');

        return FirmHomePage();
      }

    }
  return CircularProgressIndicator();

  }
}
