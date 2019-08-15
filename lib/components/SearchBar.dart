import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _filter = new TextEditingController();
  Icon _searchIcon = new Icon(Icons.search);
  String _searchText = "";
  Widget appBarTitle = Text("YouPlayer");

  _SearchBarState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
            hintText: 'Search...',
            hintStyle: Theme.of(context).textTheme.title,
            contentPadding: EdgeInsets.all(0),
          ),
          style: Theme.of(context).textTheme.title,
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        appBarTitle = new Text('YouPlayer');
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      title: appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }
}
