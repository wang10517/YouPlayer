import 'package:flutter/material.dart';
import '../model/Video.dart';
import '../components/CustomExpansionTitle.dart';

class PersonalPage extends StatelessWidget {
  static const builtInAvatar = {
    "History": Icon(Icons.headset_mic),
    "Downloaded": Icon(Icons.cloud_download),
    "Watch Later": Icon(Icons.watch_later)
  };

  final Map<String, List<Video>> builtIn;
  final Map<String, List<Video>> personal;
  final Map<String, List<Video>> youtube;

  Widget _buildCollection(String title, List<Video> videos, Widget leading) {
    return ListTile(
      key: Key(title),
      leading: leading,
      title: Text(title),
      subtitle: Text("You have ${videos.length} in this collection"),
      trailing: Icon(Icons.more_vert),
    );
  }

  PersonalPage({this.builtIn, this.personal, this.youtube, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ...builtIn.keys
              .map((name) =>
                  _buildCollection(name, builtIn[name], builtInAvatar[name]))
              .toList(),
          CustomExpansionTile(
            title: "Personal Collection (${_userDefined.keys.length})",
            background: Theme.of(context).accentColor,
            background_exp: Theme.of(context).accentColor,
            header: Colors.black,
            header_exp: Colors.blue,
            children: <Widget>[
              ...personal.keys
                  .map((name) => _buildCollection(
                      name,
                      personal[name],
                      personal[name].length == 0
                          ? Icon(Icons.play_circle_filled)
                          : Image.network(
                              "http://img.youtube.com/vi/${_userDefined[name][_userDefined[name].length - 1].id}/mqdefault.jpg",
                              fit: BoxFit.fill,
                            )))
                  .toList()
            ],
          )
        ],
      ),
    );
  }
}
