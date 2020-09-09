import 'package:Workplicity/screens/Firm/FirmJobApplications.dart';
import 'package:Workplicity/screens/Firm/ViewJobApplicants.dart';
import 'package:Workplicity/services/JoobSeekerServicies.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Workplicity/screens/Firm/edit_jobs.dart';
import 'package:Workplicity/screens/Firm/firm_home_page.dart';
import 'package:Workplicity/screens/Firm/firm_profile_main.dart';
import 'package:Workplicity/screens/Firm/posted_Jobs.dart';
import 'package:Workplicity/screens/JobSeeker/profile_main.dart';
import 'package:Workplicity/screens/main_menu/navbar_builder.dart';
import 'package:Workplicity/utils/constants.dart';
import 'package:Workplicity/utils/constants2.dart';
import 'package:Workplicity/services/job.dart';
import 'package:Workplicity/screens/Firm/firm_profile_main.dart';


final _job=new Joboperation();
final _cv =new JobSeekerOperaations();
AppBar JobSeekerHeader(context, {String titleText}) {
  Icon customIcon = Icon(FontAwesomeIcons.search);
  Widget customSearchBar = Text(
    titleText,
    style: TextStyle(
      fontSize: 25.0,
      color: Colors.white,
    ),
  );
  return AppBar(
    automaticallyImplyLeading: false,
    title: customSearchBar,
    actions: <Widget>[
      IconButton(
        onPressed: () {
          showSearch(context: context, delegate: DataSearch());
        },
        icon: customIcon,
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(FontAwesomeIcons.bell),
      ),
      Hero(
        tag: 'profileImage',
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileMain()));
            },
            child: Icon(FontAwesomeIcons.user),
          ),
        ),
      ),
    ],
    elevation: 3,
  );
}

AppBar showprofileheader(context, {String titleText} ) {

  Widget customSearchBar = Text(
    titleText,
    style: TextStyle(
      fontSize: 25.0,
      color: Colors.white,
    ),
  );
  return AppBar(
    automaticallyImplyLeading: false,
    title: customSearchBar,
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FirmHomePage()));
        },
        icon: Icon(FontAwesomeIcons.home),
      ),

      Hero(
        tag: 'profileImage',
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FirmProfileMain()));
            },
            child: Icon(FontAwesomeIcons.user),
          ),
        ),
      ),
    ],
    elevation: 3,
  );
}

AppBar jobseekershowprofileheader(context, {String titleText} ) {

  Widget customSearchBar = Text(
    titleText,
    style: TextStyle(
      fontSize: 25.0,
      color: Colors.white,
    ),
  );
  return AppBar(
    automaticallyImplyLeading: false,
    title: customSearchBar,
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        },
        icon: Icon(FontAwesomeIcons.home),
      ),

      Hero(
        tag: 'profileImage',
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileMain()));
            },
            child: Icon(FontAwesomeIcons.user),
          ),
        ),
      ),
    ],
    elevation: 3,
  );
}


AppBar Advanced(context, {String titleText} ) {

  Widget customSearchBar = Text(
    titleText,
    style: TextStyle(
      fontSize: 25.0,
      color: Colors.white,
    ),
  );
  return AppBar(
    automaticallyImplyLeading: false,
    title: customSearchBar,

    elevation: 3,
  );
}


AppBar Firmheader(context, {String titleText}) {
  Widget customSearchBar = Text(
    titleText,
    style: TextStyle(
      fontSize: 25.0,
      color: Colors.white,
    ),
  );
  return AppBar(
    automaticallyImplyLeading: false,
    title: customSearchBar,
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FirmHomePage()));
        },
        icon: Icon(FontAwesomeIcons.home),
      ),
      IconButton(
        onPressed: () {},
        icon: Icon(FontAwesomeIcons.bell),
      ),
      Hero(
        tag: 'profileImage',
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FirmProfileMain()));
            },
            child: Icon(FontAwesomeIcons.user),
          ),
        ),
      ),
    ],
    elevation: 3,
  );
}

AppBar Editjobheader(context, {String titleText,String docid}) {
  Icon customIcon = Icon(FontAwesomeIcons.edit);
  Widget customSearchBar = Text(
    titleText,
    style: TextStyle(
      fontSize: 25.0,
      color: Colors.white,
    ),
  );
  return AppBar(
    automaticallyImplyLeading: false,
    title: customSearchBar,
    actions: <Widget>[
      IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditJob(jobid: docid,)));
        },
        icon: customIcon,
      ),
      IconButton(
        onPressed: () {
_job.deleteJob(docid);
Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => PostedJobFirm()));

        },
        icon: Icon(FontAwesomeIcons.trashAlt),
      ),

    ],
    elevation: 3,
  );
}
//header

AppBar header2(context, {bool isAppTitle=false, String titleText,  actions}) {

  return AppBar(
    leading: BackButtonPop2(),
    backgroundColor: Color(0xFF122F51),
    title:Text(isAppTitle? 'Job Portal': titleText,style: GoogleFonts.signika(
      textStyle: kH2WTextStyle,
    ),
      overflow: TextOverflow.ellipsis,
    ),
    actions: actions,
    centerTitle: true,
  );
}


/////// CV REVIEW HEADER ///////
AppBar CReview(context, {String titleText,String docid} ) {

  Widget customSearchBar = Text(
    titleText,
    style: TextStyle(
      fontSize: 25.0,
      color: Colors.white,
    ),
  );
  return AppBar(
    automaticallyImplyLeading: false,
    title: customSearchBar,
    actions: <Widget>[
      Hero(
        tag: 'profileImage',
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10.0),
        ),
      ),
      IconButton(
        onPressed: () {
          _cv.deletecv(docid);
          Fluttertoast.showToast(
              msg: "The Cv Deleted Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 20.0
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FirmJobApplications()));
        },
        icon: Icon(FontAwesomeIcons.trashAlt),
      ),

    ],
    elevation: 3,
  );
}

////// Hot JOBS FIRM HEADER //////

AppBar HotJobsHeaderFirm(context, {String titleText}) {

  return AppBar(
    automaticallyImplyLeading: false,
    actions: <Widget>[
      Hero(
        tag: 'profileImage',
        child: Padding(
          padding: const EdgeInsets.only(left:10.0,right: 10.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FirmProfileMain()));
            },
            child: Icon(FontAwesomeIcons.user),
          ),
        ),
      ),
    ],
    elevation: 3,
  );
}


class DataSearch extends SearchDelegate<String> {
  final jobs = [
    'Accounting/Finance',
    'Bank/ Non-Bank Fin. Institution',
    'Commercial/Supply Chain',
    'Education/Training',
    'Engineer/Architects',
    'Garments/Textile',
    'HR/Org. Development',
    'Gen Mgt/Admin',
    'Design/Creative',
    'Production/Operation',
    'Hospitality/ Travel/ Tourism',
    'Beauty Care/ Health & Fitness',
    'Electrician/ Construction/ Repair',
    'IT & Telecommunication',
    'Marketing/Sales',
    'Customer Support/Call Centre',
    'Media/Ad./Event Mgt.',
    'Medical/Pharma',
    'Agro (Plant/Animal/Fisheries)',
    'NGO/Development',
    'Research/Consultancy',
    'Secretary/Receptionist',
    'Data Entry/Operator/BPO',
    'Driving/Motor Technician',
    'Security/Support Service',
    'Law/Legal',
    'Others'
  ];

  final recentJobs = [
    'Accounting/Finance',
    'Bank/ Non-Bank Fin. Institution',
    'Commercial/Supply Chain',
    'Education/Training',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container(
      child: Text(query,style: TextStyle(fontSize: 25.0),),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final suggestionList = query.isEmpty
        ? recentJobs
        : jobs;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.local_atm),
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
}
