import 'package:flutter/material.dart';
import 'package:youtubeclone/Models/textstyles.dart';
import 'package:youtubeclone/Views/channel_avatar.dart';
import 'package:youtubeclone/Views/suggestions_tab.dart';
import 'package:youtubeclone/Views/video_card.dart';
import 'package:youtubeclone/Models/colors.dart';
import 'package:youtubeclone/home-page.dart';
import 'package:youtubeclone/inbox-page.dart';
import 'Models/channel.dart';
import 'Models/video.dart';
import 'package:material_x/material_x.dart';
import 'central.dart';
import 'explore-page.dart';

class Subscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: backgroundColor,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  child: MxContainerGradient(
                    shadowColor: Colors.grey,
                    blurRadius: 15.0,
                    offset: Offset(0, 10),
                    onTap: () {},
                    rounded: 10.0,
                    height: MediaQuery.of(context).size.height * .8,
                    width: MediaQuery.of(context).size.width * .8,
                    child: "test"
                        .textMaterialColorWhite(fontsize: 25.0)
                        .toCenter(),
                    gradient: [backgroundColor, tabBarColor].mxLGClamp(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.7],
                    ),
                  ).mxap(value: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image(
                      image: AssetImage("assets/image1.jpg"),
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .9,
                      alignment: Alignment.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "The Video Hub",
                        style: videoTitleStyle,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "2 hrs ago",
                        style: videoInfoStyle,
                      )),
                )
              ],
            ),
          ),
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  child: MxContainerGradient(
                    shadowColor: Colors.grey,
                    blurRadius: 15.0,
                    offset: Offset(0, 10),
                    onTap: () {},
                    rounded: 10.0,
                    height: MediaQuery.of(context).size.height * .8,
                    width: MediaQuery.of(context).size.width * .8,
                    child: "test"
                        .textMaterialColorWhite(fontsize: 25.0)
                        .toCenter(),
                    gradient: [backgroundColor, tabBarColor].mxLGClamp(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.7],
                    ),
                  ).mxap(value: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image(
                      image: AssetImage("assets/image3.jpg"),
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .9,
                      alignment: Alignment.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "The Video Hub",
                        style: videoTitleStyle,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "2 hrs ago",
                        style: videoInfoStyle,
                      )),
                )
              ],
            ),
          ),
           Container(
            child: Stack(
              children: <Widget>[
                Container(
                  child: MxContainerGradient(
                    shadowColor: Colors.grey,
                    blurRadius: 15.0,
                    offset: Offset(0, 10),
                    onTap: () {},
                    rounded: 10.0,
                    height: MediaQuery.of(context).size.height * .8,
                    width: MediaQuery.of(context).size.width * .8,
                    child: "test"
                        .textMaterialColorWhite(fontsize: 25.0)
                        .toCenter(),
                    gradient: [backgroundColor, tabBarColor].mxLGClamp(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.7],
                    ),
                  ).mxap(value: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image(
                      image: AssetImage("assets/image2.jpg"),
                      width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .9,
                      alignment: Alignment.center),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "The Video Hub",
                        style: videoTitleStyle,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "2 hrs ago",
                        style: videoInfoStyle,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
