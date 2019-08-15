import 'package:flutter/material.dart';
import '../model/Video.dart';
import 'package:intl/intl.dart';
import '../pages/VideoPlage.dart';

class CardCotnainer extends StatelessWidget {
  final Video curVid;

  CardCotnainer({this.curVid, key}) : super(key: key);
  
  void _playVideo(BuildContext context, String id, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoPlay(title: title, id: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String videoImage =
        "http://img.youtube.com/vi/${curVid.id}/mqdefault.jpg";
    String _printTitle =
        curVid.title.split(" ").map((piece) => piece.trim()).toList().join(" ");

    if (_printTitle.length > 30) {
      _printTitle = _printTitle.substring(0, 30) + "...";
    }

    return Card(
      key: Key(curVid.id),
      elevation: 10.0,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
        width: 100,
        height: 80,
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.only(right: 3.0, top: 0, bottom: 0, left: 0),
        child: GestureDetector(
            onTap: () => _playVideo(context, curVid.id, _printTitle),
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                    flex: 6,
                    fit: FlexFit.loose,
                    child: Image.network(
                      videoImage,
                      fit: BoxFit.fill,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: 50,
                        ),
                        child: Text(_printTitle,
                            style: Theme.of(context).textTheme.body1),
                      ),
                      Row(
                        children: <Widget>[
                          Text(curVid.channelTitle,
                              style: Theme.of(context).textTheme.body2),
                        ],
                      ),
                      Text(
                          "${NumberFormat.compact().format(int.parse(curVid.views))} Views",
                          style: Theme.of(context).textTheme.body2)
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
