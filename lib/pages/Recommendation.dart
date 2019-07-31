import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../model/Video.dart';
import './VideoPlage.dart';

// Fetching the daily recommendation from youtube
// uncustomized for now

class RecommendationPage extends StatelessWidget {
  final List<Video> displayVideos;

  const RecommendationPage({Key key, this.displayVideos}) : super(key: key);

  void _playVideo(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoPlay(id: id)),
    );
  }

  Widget _buildVideoTile(BuildContext context, int index) {
    Video curVid = displayVideos[index];
    final String videoImage =
        "http://img.youtube.com/vi/${curVid.id}/mqdefault.jpg";
    String _printTitle = curVid.title;
    if (_printTitle.length > 50) {
      _printTitle = _printTitle.substring(0, 47) + "...";
    }

    return Card(
      key: Key(curVid.id),
      elevation: 10.0,
      child: Container(
        width: 100,
        height: 100,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.only(right: 3.0, top: 0, bottom: 0, left: 0),
        child: GestureDetector(
            onTap: () => _playVideo(context, curVid.id),
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Image.network(
                      videoImage,
                      fit: BoxFit.fitHeight,
                    )),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: Text(""),
                ),
                Flexible(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(_printTitle,
                          style: Theme.of(context).textTheme.title),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(curVid.channelTitle,
                              style: Theme.of(context).textTheme.body1),
                          Text(
                              "${NumberFormat.compact().format(int.parse(curVid.views))} Views",
                              style: Theme.of(context).textTheme.body1)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (displayVideos.length == 0) {
      return Text('No Recommended Videos found from Youtube API');
    } else {
      return Container(
        margin: EdgeInsets.all(7.0),
        padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0),
        child: ListView.builder(
          itemCount: displayVideos.length,
          itemBuilder: _buildVideoTile,
        ),
      );
    }
  }
}
