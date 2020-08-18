import 'package:flutter/material.dart';
import 'package:youtubeclone/Models/textstyles.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        //_buildRecent(),
        _buildPersonal(context),
        _buildOffline(),
        _buildPlaylist(context),
      ],
    );
  }

  BoxDecoration _buildBottomBorder() => BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.grey),
        ),
      );

  Widget _buildPersonal(BuildContext context) {
    List<Map> items = [
      {
        "name": "History",
        "icon": Icon(
          Icons.history,
          color: Colors.white,
        )
      },
      {
        "name": "My Videos",
        "icon": Icon(Icons.video_library, color: Colors.white)
      },
      {
        "name": "Watch Later",
        "icon": Icon(Icons.watch_later, color: Colors.white),
        "extra": "25 unwatched videos"
      },
    ];

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: _buildBottomBorder(),
      child: Column(
        children: items
            .map((i) => ListTile(
                  leading: i["icon"],
                  title: i["extra"] == null
                      ? Text(
                          i["name"],
                          style: videoTitleStyle,
                        )
                      : Row(
                          children: <Widget>[
                            Text(i["name"], style: videoTitleStyle),
                            Container(
                              margin: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                i["extra"],
                                style: videoInfoStyle,
                              ),
                            ),
                          ],
                        ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildOffline() {
    return Container(
      decoration: _buildBottomBorder(),
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Available offline",style: videoTitleStyle),
          ListTile(
            leading: Icon(Icons.file_download,color: Colors.white,),
            title: Text("Downloads",style: videoTitleStyle),
            subtitle: Text("20 videos",style: videoTitleStyle),
            trailing: Icon(
              Icons.check_circle,
              color: Colors.blue[700],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlaylist(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Playlist", style: videoTitleStyle),
              DropdownButton(
                //style: Theme.of(context).textTheme.body1,
                items: [
                  DropdownMenuItem(child: Text("(Recently added)", style: videoTitleStyle)),
                  DropdownMenuItem(child: Text("(A - Z)", style: videoTitleStyle)),
                ],
                onChanged: null,
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.thumb_up,color: Colors.white,),
            title: Text("Liked videos", style: videoTitleStyle),
            subtitle: Text("248 videos", style: videoTitleStyle),
          ),
          ListTile(
            leading: Icon(Icons.account_circle,color: Colors.white),
            title: Text("ABC  Movie Scenes", style: videoTitleStyle),
            subtitle: Text("XY Pictures . 15 videos", style: videoTitleStyle),
          ),
        ],
      ),
    );
  }
}
