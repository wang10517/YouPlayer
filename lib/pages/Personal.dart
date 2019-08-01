import 'package:flutter/material.dart';
import '../model/Video.dart';
import '../components/CustomExpansionTitle.dart';
import './singleCollectionAdderModal.dart';

class PersonalPage extends StatelessWidget {
  static const builtInAvatar = {
    "History": Icon(Icons.headset_mic),
    "Downloaded": Icon(Icons.cloud_download),
    "Watch Later": Icon(Icons.watch_later)
  };

  final Map<String, List<Video>> builtIn;
  final Map<String, List<Video>> personal;
  final Map<String, List<Video>> youtube;
  final Function addCollection;
  final Function deleteCollections;
  final Function addVideosToExistingCollection;
  final Function addVideosToNewCollections;

  PersonalPage(
      {this.builtIn,
      this.personal,
      this.youtube,
      this.addCollection,
      this.addVideosToExistingCollection,
      this.addVideosToNewCollections,
      this.deleteCollections,
      Key key})
      : super(key: key);

  Widget _buildCollection(String title, List<Video> videos, Widget leading,
      {Widget trailing}) {
    return ListTile(
      key: Key(title),
      leading: leading,
      title: Text(title),
      subtitle: Text("You have ${videos.length} in this collection"),
      trailing: trailing,
    );
  }

  void onPressCollectionAdder(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CollectionAdder(
            adder: addCollection,
            existingNames: personal.keys.toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ...builtIn.keys
              .map((name) => _buildCollection(
                  name, builtIn[name], builtInAvatar[name],
                  trailing: Icon(Icons.keyboard_arrow_right)))
              .toList(),
          CustomExpansionTile(
            title: "Personal Collection (${personal.keys.length})",
            background: Theme.of(context).accentColor,
            background_exp: Theme.of(context).accentColor,
            header: Colors.black,
            header_exp: Colors.blue,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onTap: () => onPressCollectionAdder(context)),
                GestureDetector(
                    child: Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ))
              ],
            ),
            children: <Widget>[
              ...personal.keys
                  .map((name) => _buildCollection(
                      name,
                      personal[name],
                      personal[name].length == 0
                          ? Icon(Icons.play_circle_filled)
                          : Image.network(
                              "http://img.youtube.com/vi/${personal[name][personal[name].length - 1].id}/mqdefault.jpg",
                              fit: BoxFit.fill,
                            )))
                  .toList()
            ],
          ),
          CustomExpansionTile(
            title: "YouTube collections",
          )
        ],
      ),
    );
  }
}
