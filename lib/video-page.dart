import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:video_player/video_player.dart';
import 'package:youtubeclone/Models/colors.dart';
import 'package:youtubeclone/Models/textstyles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Models/video.dart';

class VideoPage extends StatefulWidget {
  static const routeName = '/video-page';
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
    getdetails();
    super.initState();
  }

  @override
  void dispose() {
    setdetails();
    _controller.dispose();

    super.dispose();
  }

  setdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('like', like);
    prefs.setInt('dislike', dislike);
    prefs.setBool('isdislike', isdislike);
    prefs.setBool('islike', islike);
  }

  int like;
  int dislike;
  bool isdislike;
  bool islike;
  getdetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    like = prefs.getInt('like');
    dislike = prefs.getInt('dislike');
    isdislike = prefs.getBool('isdislike');
    islike = prefs.getBool('islike');
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final Video video = routeArgs['video'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the VideoPlayerController has finished initialization, use
                        // the data it provides to limit the aspect ratio of the VideoPlayer.
                        return Container(
                          height: MediaQuery.of(context).size.height * .27,
                          child: Stack(
                            children: <Widget>[
                              AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                // Use the VideoPlayer widget to display the video.
                                child: InkWell(
                                  child: VideoPlayer(_controller),
                                  onTap: () {
                                    setState(() {
                                      // If the video is playing, pause it.
                                      if (_controller.value.isPlaying) {
                                        _controller.pause();
                                      } else {
                                        // If the video is paused, play it.
                                        _controller.play();
                                      }
                                    });
                                  },
                                ),
                              ),
                              Align(
                                child: VideoProgressIndicator(_controller,
                                    allowScrubbing: true),
                                alignment: Alignment.bottomCenter,
                              )
                            ],
                          ),
                        );
                      } else {
                        // If the VideoPlayerController is still initializing, show a
                        // loading spinner.
                        return Container(
                            height: MediaQuery.of(context).size.height * .27,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  ),
                  Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          video.videoTitle,
                          style: videoTitleStyle,
                        ),
                        subtitle: Text(
                          '',
                          style: videoInfoStyle,
                        ),
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.thumb_up,
                                      color: video.isliked
                                          ? Colors.blue
                                          : Colors.grey[700],
                                    ),
                                    onTap: () {
                                      if (!video.isdisliked) {
                                        setState(() {
                                          video.isliked = !video.isliked;
                                          video.isliked
                                              ? video.likes += 1
                                              : video.likes -= 1;
                                        });
                                      } else {
                                        setState(() {
                                          video.isdisliked = !video.isdisliked;
                                          video.dislikes -= 1;
                                          video.isliked = !video.isliked;
                                          video.isliked
                                              ? video.likes += 1
                                              : video.likes -= 1;
                                        });
                                      }
                                      isdislike = video.isdisliked;
                                      islike = video.isliked;
                                      like = video.likes;
                                      dislike = video.dislikes;
                                    },
                                  ),
                                ),
                                Text(
                                  video.likes.toString(),
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.thumb_down,
                                      color: video.isdisliked
                                          ? Colors.blue
                                          : Colors.grey[700],
                                    ),
                                    onTap: () {
                                      if (!video.isliked) {
                                        setState(() {
                                          video.isdisliked = !video.isdisliked;
                                          video.isdisliked
                                              ? video.dislikes += 1
                                              : video.dislikes -= 1;
                                        });
                                      } else {
                                        setState(() {
                                          video.isliked = !video.isliked;
                                          video.likes -= 1;
                                          video.isdisliked = !video.isdisliked;
                                          video.isdisliked
                                              ? video.dislikes += 1
                                              : video.dislikes -= 1;
                                        });
                                      }
                                      isdislike = video.isdisliked;
                                      islike = video.isliked;
                                      like = video.likes;
                                      dislike = video.dislikes;
                                    },
                                  ),
                                ),
                                Text(
                                  video.dislikes.toString(),
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.share,
                                      color: false
                                          ? Colors.blue
                                          : Colors.grey[700],
                                    ),
                                    onTap: () {
                                      Share.share(
                                          'Check out the video from NewTube "www.flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4"');
                                    },
                                  ),
                                ),
                                Text(
                                  "Share",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.cloud_download,
                                      color: false
                                          ? Colors.blue
                                          : Colors.grey[700],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Download",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: InkWell(
                                    child: Icon(
                                      Icons.playlist_add,
                                      color: false
                                          ? Colors.blue
                                          : Colors.grey[700],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Save",
                                  style: TextStyle(color: Colors.grey[700]),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  _channelInfo(video),
                  MoreInfo(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 30,
                  ),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/* Widget _videoInfo(Video video) {
  return Column(
    children: <Widget>[
      ListTile(
        title: Text(
          video.videoTitle,
          style: videoTitleStyle,
        ),
        subtitle: Text(
          '',
          style: videoInfoStyle,
        ),
        trailing: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
      ),
      Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildButtonColumn(
                Icons.thumb_up, video.likes.toString(), video.isliked),
            _buildButtonColumn(
                Icons.thumb_down, video.dislikes.toString(), video.isdisliked),
            _buildButtonColumn(Icons.share, "Share", false),
            _buildButtonColumn(Icons.cloud_download, "Download", false),
            _buildButtonColumn(Icons.playlist_add, "Save", false),
          ],
        ),
      )
    ],
  );
} */

Widget _buildButtonColumn(IconData icon, String text, bool isis) {
  return Column(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: InkWell(
          child: Icon(
            icon,
            color: isis ? Colors.blue : Colors.grey[700],
          ),
        ),
      ),
      Text(
        text,
        style: TextStyle(color: Colors.grey[700]),
      ),
    ],
  );
}

Widget _channelInfo(Video video) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.grey, width: 0.5),
        bottom: BorderSide(color: Colors.grey, width: 0.5),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: video.channel.profilePicture,
            ),
            title: Text(
              video.channel.channelName,
              style: videoTitleStyle,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "15,000 subscribers",
              style: videoInfoStyle,
            ),
          ),
        ),
        FlatButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.play_circle_filled,
              color: Colors.red,
            ),
            label: Text(
              "SUBSCRIBE",
              style: TextStyle(color: Colors.red),
            ))
      ],
    ),
  );
}

class MoreInfo extends StatefulWidget {
  @override
  _MoreInfoState createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  bool ison = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
              child: Text(
            "Up next",
            style: videoTitleStyle,
          )),
          Text(
            "Autoplay",
            style: videoInfoStyle,
          ),
          Switch(
            onChanged: (c) {
              setState(() {
                ison = !ison;
              });
            },
            value: ison,
          ),
        ],
      ),
    );
  }
}
