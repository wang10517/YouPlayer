import 'dart:collection';

import 'package:flutter/material.dart';
import '../pages/Personal.dart';
import '../pages/Recommendation.dart';
import '../pages/Setting.dart';
import '../model/Video.dart';
import '../model/CategoryIdMapping.dart' as CID;

class Controller extends StatefulWidget {
  Controller({Key key}) : super(key: key);

  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text('YouPlayer');
  int _curIndex = 0;
  LinkedHashMap<String, String> categoryId = LinkedHashMap.of(
      {"10": "Music", "27": "Education", "35": "Documentary", "28": "Science"});

  AppBar _buildAppBar(BuildContext context) {
    return new AppBar(
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
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
        this._appBarTitle = new Text('YouPlayer');
        _filter.clear();
      }
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _curIndex = index;
    });
  }

  _ControllerState() {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      RecommendationPage(
        categoryId: categoryId,
      ),
      PersonalPage(),
      SettingsPage(),
    ];

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _children[_curIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _curIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            title: Text('Trending'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Personal Library'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text('Setting'))
        ],
      ),
    );
  }
}
