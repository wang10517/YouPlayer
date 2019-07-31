import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../pages/Personal.dart';
import '../pages/Recommendation.dart';
import '../pages/Setting.dart';
import '../credentials/YoutubeAPI.dart' as Keys;
import '../model/Video.dart';

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
  List<Video> _recVideos = [];

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

  void fetchTrendingVideos() async {
    const String url =
        "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&chart=mostPopular&maxResults=10&regionCode=US&key=${Keys.ANDROID_PUBLIC}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final parsed_vid = jsonResponse['items']
          .map((vid) => Video.fromJSON(vid) as Video)
          .toList()
          .cast<Video>();
      setState(() {
        _recVideos = parsed_vid;
      });
    }
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
    fetchTrendingVideos();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      RecommendationPage(
        displayVideos: _recVideos,
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
            icon: Icon(Icons.search),
            title: Text('Search'),
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
