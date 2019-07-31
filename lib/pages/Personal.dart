import 'package:flutter/material.dart';
import '../model/Video.dart';
import '../components/CustomExpansionTitle.dart';
import '../model/Entry.dart';

class PersonalPage extends StatelessWidget {
  final Map<String, List<Video>> builtIn;
  final Map<String, List<Video>> personal;
  final Map<String, List<Video>> youtube;

  PersonalPage({this.builtIn, this.personal, this.youtube, Key key})
      : super(key: key);

  Widget _buildCollection(String title, List<Video> videos) {
    return ListTile(
      key: Key(title),
      leading: Icon(Icons.file_download),
      title: Text(title),
      subtitle: Text("You have ${videos.length} in this collection"),
      trailing: Icon(Icons.more_vert),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CustomExpansionTile(
            title: "Built-in",
            background: Theme.of(context).accentColor,
            background_exp: Theme.of(context).accentColor,
            header: Colors.black,
            header_exp: Colors.blue,
            children: <Widget>[
              ...builtIn.keys
                  .map((name) => _buildCollection(name, builtIn[name]))
                  .toList(),
            ],
          )
        ],
      ),
    );
  }
}
