import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../credentials/YoutubeAPI.dart' as Keys;
import '../model/Video.dart';
import '../templates/CardList.dart';

class RecommendationPage extends StatefulWidget {
  final LinkedHashMap<String, String> categoryId;

  RecommendationPage({Key key, this.categoryId}) : super(key: key);

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  Map<String, List<Video>> videos = {};

  @override
  void initState() {
    super.initState();
    print("Recommendation page rebuilt");
    widget.categoryId.keys.forEach((key) {
      fetchTrendingVideos(key);
    });
  }

  void fetchTrendingVideos(String id) async {
    print('fetching started for ${id}');
    final String url =
        "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&chart=mostPopular&maxResults=10&regionCode=US&videoCategoryId=${id}&key=${Keys.ANDROID_PUBLIC}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('response is 200 for ${id}');
      final jsonResponse = convert.jsonDecode(response.body);
      final parsed_vid = jsonResponse['items']
          .map((vid) => Video.fromJSON(vid) as Video)
          .toList()
          .cast<Video>();
      setState(() {
        print('success setstate for ${id}');
        print('${parsed_vid.length} given back');
        videos[id] = parsed_vid;
      });
    } else {
      print('response is ${response.statusCode} for ${id}');
      if (!videos.containsKey(id)) {
        print('failure setstate for ${id}');
        setState(() {
          videos[id] = [];
        });
      }
    }
  }

  List<Tab> parseTabs(context) {
    return widget.categoryId.values
        .map((cat) => Tab(
                child: Text(
              cat,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Theme.of(context).primaryColor),
            )))
        .toList();
  }

  List<Widget> parseTabView() {
    return widget.categoryId.keys
        .map((key) => CardList(
              items: videos[key],
              id: key,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categoryId.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).accentColor,
          bottom: PreferredSize(
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Theme.of(context).accentColor,
              indicatorColor: Theme.of(context).primaryColor,
              tabs: parseTabs(context),
            ),
            preferredSize: Size.fromHeight(0),
          ),
        ),
        body: TabBarView(
          children: parseTabView(),
        ),
      ),
    );
  }
}
