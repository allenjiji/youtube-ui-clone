import 'package:flutter/material.dart';
import 'package:material_x/material_x.dart';
import 'package:youtubeclone/Views/channel_avatar.dart';
import 'package:youtubeclone/Views/video_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/channel.dart';
import 'Models/colors.dart';
import 'Models/video.dart';
import 'Views/suggestions_tab.dart';

class GradientBlock extends StatelessWidget {
  String text;
  Color color1;
  Color color2;
  GradientBlock({this.text, this.color1, this.color2});
  @override
  Widget build(BuildContext context) {
    return MxCardListTileGradient(
            //trailing: "10min ago".textMaterialColorWhite(),
            blurRadius: 20,
            rounded: 10,
            //width: 500,
            //leading: Icons.ac_unit.mxListTileIcon(color: Colors.white),
            title: text.textMaterialColorWhite(),
            //subTitle: "Lorem Ipsum is simply ".textMaterialColorWhite(),
            onTap: () {},
            shadowColor: Colors.red,
            gradient: [
              color1,
              color2
            ].mxLGrepeated(begin: Alignment.topLeft, end: Alignment.topRight))
        .mxap(value: 5.0);
  }
}

class Central {
  List<Widget> getVideos(bool isSubscriptionPage, bool isExplorePage) {
    List<Video> videos = makeVideos();
    List<Widget> cards = [];
    if (isExplorePage) {
      cards.add(Container(
        color: Colors.black,
        height: 350,
        child: GridView.count(
          //physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 3,
          children: <Widget>[
            GradientBlock(
              text: "Gaming",
              color1: Colors.red,
              color2: Colors.yellow,
            ),
            GradientBlock(
              text: "Trending",
              color1: Colors.blue,
              color2: Colors.blue[100],
            ),
            GradientBlock(
              text: "Music",
              color1: Colors.green,
              color2: Colors.green[100],
            ),
            GradientBlock(
              text: "News",
              color1: Colors.black,
              color2: Colors.white,
            ),
            GradientBlock(
              text: "Fashion",
              color1: Colors.indigo,
              color2: Colors.indigo[100],
            ),
            GradientBlock(
              text: "Beauty",
              color1: Colors.green,
              color2: Colors.red[100],
            ),
            GradientBlock(
              text: "Learning",
              color1: Colors.brown,
              color2: Colors.brown[100],
            ),
            GradientBlock(
              text: "Movies",
              color1: Colors.deepOrange,
              color2: Colors.deepOrange[100],
            ),
            GradientBlock(
              text: "Live",
              color1: Colors.pinkAccent,
              color2: Colors.pink[100],
            ),
            GradientBlock(
              text: "Subscriptions",
              color1: Colors.blue,
              color2: Colors.red[100],
            ),
          ],
        ),
      ));
    } else if (isSubscriptionPage) {
      cards.add(Container(
        color: backgroundColor,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 5),
                child: ChannelAvatar(channel: channel),
              ),
            ]),
            Divider(
              color: tabBarUnselectedIconsColor,
            ),
            SuggestionsTab(),
            Divider(
              color: tabBarUnselectedIconsColor,
            ),
          ],
        ),
      ));
    } else {
      cards.add(Container(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        color: backgroundColor,
        height: 50,
        child: SuggestionsTab(),
      ));
    }
    for (Video video in videos) {
      cards.add(VideoCard(
        video: video,
      ));
    }
    return cards;
  }

  Channel channel =
      new Channel("ABC Channel", AssetImage("assets/profilepics/5.jpg"));

  List links = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
  ];

  List<Video> makeVideos() {
    List<Video> vids = [];
    for (int i = 0; i < 5; i++) {
      vids.add(new Video(
          AssetImage("assets/thumbnails/" + i.toString() + ".jpg"),
          120000,
          DateTime.now().subtract(new Duration(days: 400)),
          videoTitles[i],
          channel,
          links[i],
          2,
          5,
          true,
          false));
    }
    return vids;
  }

  List<String> videoTitles = [
    "Lorem Ipsum is simply dummy text ",
    "Of the printing and typesetting industry.",
    "Many desktop publishing packages and web page",
    "Editors now use Lorem Ipsum as their default model text,",
    "There are many variations of passages of Lorem Ipsum available"
  ];

storelogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isloggedIn', true);
}

setvideos()async{
  
}


}