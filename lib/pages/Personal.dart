import 'package:flutter/material.dart';
import '../model/Video.dart';
import '../components/CustomExpansionTitle.dart';
import './singleCollectionAdderModal.dart';
import '../pages/PopUpMenu.dart';
import '../components/SearchBar.dart';
import '../components/confirmBar.dart';

class PersonalPage extends StatefulWidget {
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

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  bool _deleteMode = false;
  List<String> selected_collecs = [];

  void onCancel() {
    setState(() {
      _deleteMode = false;
    });
  }

  void onConfirm() {
    widget.deleteCollections(selected_collecs);
    setState(() {
      _deleteMode = false;
      selected_collecs = [];
    });
  }

  Widget _buildCollection(String title, List<Video> videos, Widget leading,
      {Widget trailing, bool deleteMode, bool selected}) {
    return GestureDetector(
        child: ListTile(
          key: Key(title),
          leading: deleteMode
              ? (selected
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.check_circle_outline,
                      color: Colors.grey,
                    ))
              : leading,
          title: Text(title),
          subtitle: Text("You have ${videos.length} in this collection"),
          trailing: trailing,
        ),
        onTap: deleteMode
            ? () {
                if (selected) {
                  setState(() {
                    selected_collecs.remove(title);
                  });
                } else {
                  setState(() {
                    selected_collecs.add(title);
                  });
                }
              }
            : null);
  }

  void onPressCollectionAdder(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return CollectionAdder(
            adder: widget.addCollection,
            existingNames: widget.personal.keys.toList(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Function> options = {
      "Delete Collections": () => setState(() {
            _deleteMode = true;
          })
    };

    var scrollView = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ...widget.builtIn.keys
              .map((name) => _buildCollection(
                  name, widget.builtIn[name], PersonalPage.builtInAvatar[name],
                  trailing: Icon(Icons.keyboard_arrow_right),
                  selected: false,
                  deleteMode: false))
              .toList(),
          CustomExpansionTile(
            title: "Personal Collection (${widget.personal.keys.length})",
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
                PopUpMenu(
                  options: options,
                )
              ],
            ),
            children: <Widget>[
              ...widget.personal.keys
                  .map((name) => _buildCollection(
                      name,
                      widget.personal[name],
                      widget.personal[name].length == 0
                          ? Icon(Icons.play_circle_filled)
                          : Image.network(
                              "http://img.youtube.com/vi/${widget.personal[name][widget.personal[name].length - 1].id}/mqdefault.jpg",
                              fit: BoxFit.fill,
                            ),
                      deleteMode: _deleteMode,
                      selected: selected_collecs.contains(name)))
                  .toList()
            ],
          ),
          CustomExpansionTile(
            title: "YouTube collections",
          )
        ],
      ),
    );

    return Scaffold(
      appBar: PreferredSize(
        child: _deleteMode
            ? ConfirmBar(
                onCancel: onCancel,
                onConfirm: onConfirm,
              )
            : SearchBar(),
        preferredSize: Size.fromHeight(50),
      ),
      body: scrollView,
    );
  }
}
