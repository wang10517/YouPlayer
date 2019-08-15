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
  // Search Bar related fields
  int _curIndex = 0;

  // Recommendation related fields
  LinkedHashMap<String, String> categoryId = LinkedHashMap.of(
      {"10": "Music", "23": "Comdey", "24": "Entertainment", "28": "Science"});

  // Personal library related fields
  Map<String, List<Video>> builtIn = {
    "History": [],
    "Downloaded": [],
    "Watch Later": []
  };

  Map<String, List<Video>> _userDefined = {};

  void _addCollection(String name) {
    setState(() {
      print('propagating back');
      _userDefined[name] = [];
    });
  }

  void _deleteCollections(List<String> names) {
    setState(() {
      names.forEach((name) => _userDefined.remove(name));
    });
  }

  void _addVideosToExistingCollection(String name, List<Video> vid) {
    setState(() {
      _userDefined[name].addAll(vid);
    });
  }

  void _addVideosToNewCollection(String name, List<Video> vid) {
    setState(() {
      _userDefined[name] = vid;
    });
  }

  // General lifecylce
  void onTabTapped(int index) {
    setState(() {
      _curIndex = index;
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
      PersonalPage(
        builtIn: builtIn,
        personal: _userDefined,
        addCollection: _addCollection,
        addVideosToExistingCollection: _addVideosToExistingCollection,
        addVideosToNewCollections: _addVideosToNewCollection,
        deleteCollections: _deleteCollections,
      ),
      SettingsPage(),
    ];

    return Scaffold(
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
