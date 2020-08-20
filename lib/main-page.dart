import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtubeclone/Models/textstyles.dart';
import 'package:youtubeclone/Views/channel_avatar.dart';
import 'package:youtubeclone/Views/suggestions_tab.dart';
import 'package:youtubeclone/Views/video_card.dart';
import 'package:youtubeclone/Models/colors.dart';
import 'package:youtubeclone/home-page.dart';
import 'package:youtubeclone/inbox-page.dart';
import 'package:youtubeclone/library-page.dart';
import 'Models/channel.dart';
import 'Models/video.dart';
import 'package:material_x/material_x.dart';
import 'central.dart';
import 'explore-page.dart';
import 'subscription-page.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/main-page';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: new Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 40,
                    child: Image(
                      image: AssetImage("assets/youtube_logo.png"),
                    ),
                  ),
                  Text(
                    "NewTube",
                    style: youtube,
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 100, bottom: 15),
                width: 260,
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      //Icon(Icons.cast),
                      Icon(Icons.video_call),
                      Icon(Icons.search),
                      InkWell(
                        child: Container(
                          height: 30,
                          width: 30,
                          child: CircleAvatar(
                              backgroundImage:
                                  Central().channel.profilePicture),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: backgroundColor,
                                  title: Text(
                                    "LOGOUT",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.red,
                                        fontStyle: FontStyle.normal),
                                  ),
                                  content: Text(
                                    "Are you sure ?",
                                    style: videoTitleStyle,
                                  ),
                                  actions: [
                                    FlatButton(
                                        onPressed: () async {
                                          SharedPreferences preferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          await preferences.clear();
                                          Navigator.of(context)
                                              .pushReplacementNamed('/');
                                        },
                                        child: Text("YES")),
                                    FlatButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text("NO")),
                                  ],
                                );
                              });
                        },
                      )
                    ],
                  ),
                )),
          ],
          backgroundColor: tabBarColor,
        ),
        body: TabBarView(
          children: [
            new Home(),
            new Explore(),
            new Subscription(),
            new Inbox(),
            new Library()
          ],
        ),
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * .07,
          padding: EdgeInsets.only(top: 10),
          child: new TabBar(
            labelStyle: tabTextStyle,
            tabs: tabList,
            labelColor: tabBarSelectedIconsColor,
            unselectedLabelColor: tabBarUnselectedIconsColor,
            indicatorColor: Colors.transparent,
          ),
        ),
        backgroundColor: tabBarColor,
      ),
    );
  }

  ///////////////////////////////////////////////////////////////

  List<Widget> tabList = [
    Tab(
      icon: new Icon(Icons.home),
      text: "Home",
    ),
    Tab(
      icon: new Icon(Icons.explore),
      text: "Explore",
    ),
    Tab(
      icon: new Icon(Icons.image),
      text: "Shorties",
    ),
    Tab(
      icon: new Icon(Icons.email),
      text: "Inbox",
    ),
    Tab(
      icon: new Icon(Icons.video_library),
      text: "Library",
    )
  ];
}
