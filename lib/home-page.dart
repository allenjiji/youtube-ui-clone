import 'package:flutter/material.dart';
import 'package:youtubeclone/Models/colors.dart';
import './main-page.dart';
import 'central.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: backgroundColor,
      child: ListView(
        children: Central().getVideos(false,false),
      ),
    );
  }
}
