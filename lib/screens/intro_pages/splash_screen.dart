import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:Workplicity/Animations/FadeAnimation.dart';
import 'package:Workplicity/model/user.dart';
import 'package:Workplicity/screens/intro_pages/sign_in_page.dart';
import 'package:Workplicity/screens/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{





  @override
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;


  var id,UserType;
  getsaved() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("User");
    UserType = preferences.getString("UserType");


  }
  @override
  void initState() {
    getsaved();
    // TODO: implement initState
    super.initState();





    // get user type map it to type variable


    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    );

    _scaleAnimation = Tween<double>(
        begin: 1.0, end: 0.8
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _widthController.forward();
      }
    });

    _widthController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 900)
    );

    _widthAnimation = Tween<double>(
        begin: 80.0,
        end: 300.0
    ).animate(_widthController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _positionController.forward();
      }
    });

    _positionController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000)
    );

    _positionAnimation = Tween<double>(
        begin: 0.0,
        end: 215.0
    ).animate(_positionController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          hideIcon = true;
        });
        _scale2Controller.forward();
      }
    });

    _scale2Controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    );

    _scale2Animation = Tween<double>(
        begin: 1.0,
        end: 32.0
    ).animate(_scale2Controller)..addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if(UserType==null&&id==null){
          print('no data');
          Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SignInPage()));
        }
        else{print(UserType);
        print(id);
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Wrapper(id:id,UserType:UserType)));}

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 40, 1),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[

            Positioned(
              top: -50,
              left: 0,
              child: FadeAnimation(2, Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/one.png'),
                        fit: BoxFit.cover
                    )
                ),
              )),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: FadeAnimation(2.3, Container(
                width: width,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/one.png'),
                        fit: BoxFit.cover
                    )
                ),
              )),
            ),
            Positioned(
              top: -150,
              left: 0,
              child: FadeAnimation(2.6, Container(
                width: width,
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/one.png'),
                        fit: BoxFit.cover
                    )
                ),
              )),
            ),
            Positioned(
              top: 50,
              left: 0,
              child: FadeAnimation(1, Container(
                width: width,
                height: 220,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/Work1.png'),
                        fit: BoxFit.cover
                    )
                ),
              )),
            ),
            Container(
              padding: EdgeInsets.only(top: 200,left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text("Welcome",
                    style: TextStyle(color: Colors.white, fontSize: 50),)),
                  SizedBox(height: 15,),
                  FadeAnimation(1.3, Text("We promise you the most fuss-free time.",
                    style: TextStyle(color: Colors.white.withOpacity(.7), height: 1.4, fontSize: 20),)),
                  SizedBox(height: 100,),
                  FadeAnimation(1.6, AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _widthController,
                            builder: (context, child) => Container(
                              width: _widthAnimation.value,
                              height: 80,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue.withOpacity(.4)
                              ),
                              child: InkWell(
                                onTap: () {
                                  _scaleController.forward();
                                },
                                child: Stack(
                                    children: <Widget> [
                                      AnimatedBuilder(
                                        animation: _positionController,
                                        builder: (context, child) => Positioned(
                                          left: _positionAnimation.value,
                                          child: AnimatedBuilder(
                                            animation: _scale2Controller,
                                            builder: (context, child) => Transform.scale(
                                                scale: _scale2Animation.value,
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.blue
                                                  ),
                                                  child: hideIcon == false ? Icon(Icons.arrow_forward, color: Colors.white,) : SizedBox(height: 10,width: 10,)
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ),
                        )),
                  )),
                  SizedBox(height: 60,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  }


