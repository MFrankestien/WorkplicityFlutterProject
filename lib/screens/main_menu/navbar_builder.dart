import 'package:Workplicity/screens/JobSeeker/home_search.dart';
import 'package:Workplicity/widgets/bottom_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Workplicity/screens/main_menu/hot_jobs.dart';
import 'package:Workplicity/screens/main_menu/more_settings.dart';
import 'package:Workplicity/screens/main_menu/AppliedJobs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController;
  int pageIndex = 0;
  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onItemSelected(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  SharedPreferences preferences;
  String urls;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => preferences = prefs);
      urls = preferences.getString("Url");
    });
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          HomeSearch(urls: urls),
          allJobs(),
          AppliedJobs(),
          MoreSettings(),
        ],
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavBar(
        onItemSelected: onItemSelected,
        items: [
          BottomNavBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
          ),
          BottomNavBarItem(
              icon: Icon(Icons.whatshot),
              title: Text('Hot Jobs'),
              activeColor: Colors.teal),
          BottomNavBarItem(
              icon: Icon(Icons.account_box),
              title: Text('Applied'),
              activeColor: Colors.blueAccent),
          BottomNavBarItem(
              icon: Icon(FontAwesomeIcons.ellipsisH),
              title: Text('More'),
              activeColor: Colors.blueGrey),
        ],
      ),
    );
  }
}
