import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Hybrid_Abdul_Shadaab/src/pages/profile.dart';

import 'home.dart';

class MyHomePage extends StatefulWidget {

  String email;
  MyHomePage({this.email});
  @override
  _MyHomePageState createState() => _MyHomePageState(email:email);
}

class _MyHomePageState extends State<MyHomePage> {

  String email;
  _MyHomePageState({this.email});

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {

    var deviceHeight =  MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    TabController tabController;
    return Scaffold(

      appBar: AppBar(
        title: Container(width:  size.width*0.1,
            child: Image.asset("assets/offersploxLogo.png",fit: BoxFit.contain,)),
        backgroundColor: Colors.black,
        actions: [
          Icon(Icons.search),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,

        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white,width: 3.0
                  ))),
                  child: TabBarView(
                    //controller: tabController,
                    children: [
                      Center(
                        child: new Container(
                          child: Home(),
                        ),
                      ),
                      new Container(
                        child: Center(child: Home()),
                      ),
                      new Container(
                        child: Center(child: Signout()),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: new Container(
            height: 60.0,
            child: Material(
              color: Colors.black,
              child: new TabBar(
                controller: tabController,
                tabs: [
                  Tab(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                              Icons.home_outlined
                          ),
                          Text(
                            "Home",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                              Icons.notifications_none_outlined
                          ),
                          Text(
                            "Notification",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                          // Image(
                          //   image: AssetImage('assets/Group 2724.png'),
                          //   height: 38,
                          //   // width: 200,
                          //   fit: BoxFit.fitWidth,
                          // )
                        ],
                      ),
                    ),                ),
                  Tab(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                              Icons.person_outline_outlined
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                          // Image(
                          //   image: AssetImage('assets/Group 2730.png'),
                          //   height: 38,
                          //   // width: 200,
                          //   fit: BoxFit.fitWidth,
                          // )
                        ],
                      ),
                    ),                  //text: new Text(curARRrUid),
                  ),
                ],
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorWeight: 3.0,
                indicatorColor: Colors.white,
              ),
            ),
          ),
          //backgroundColor: Colors.black,
        ),
      ),
    );
  }
}