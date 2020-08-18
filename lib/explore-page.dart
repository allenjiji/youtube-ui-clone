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

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Container(
                //color: Colors.red,
                height: MediaQuery.of(context).size.height,
                child: ListView(
              children: Central().getVideos(false,true),
                //color: Colors.orange,
                ),
            )
          ],
        ),
      ),
    );
  }
}
