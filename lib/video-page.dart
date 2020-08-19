import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtubeclone/Models/colors.dart';
import 'package:youtubeclone/Models/textstyles.dart';

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

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  _videoInfo(),
                  _channelInfo(),
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

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key key, this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
      ],
    );
  }
}

Widget _videoInfo() {
  return Column(
    children: <Widget>[
      ListTile(
        title: Text(
          "widget.detail.title",
          style: videoTitleStyle,
        ),
        subtitle: Text(
          "1235",
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
            _buildButtonColumn(Icons.thumb_up, "5"),
            _buildButtonColumn(Icons.thumb_down, "4"),
            _buildButtonColumn(Icons.share, "Share"),
            _buildButtonColumn(Icons.cloud_download, "Download"),
            _buildButtonColumn(Icons.playlist_add, "Save"),
          ],
        ),
      )
    ],
  );
}

Widget _buildButtonColumn(IconData icon, String text) {
  return Column(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Icon(
          icon,
          color: Colors.grey[700],
        ),
      ),
      Text(
        text,
        style: TextStyle(color: Colors.grey[700]),
      ),
    ],
  );
}

Widget _channelInfo() {
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
              backgroundImage: NetworkImage("widget.detail.channelAvatar"),
            ),
            title: Text(
              "widget.detail.channelTitle",
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
