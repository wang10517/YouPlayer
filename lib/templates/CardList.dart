import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../credentials/YoutubeAPI.dart' as Keys;
import '../model/Video.dart';
import './CardContainer.dart';

class CardList extends StatefulWidget {
  final List<Video> items;
  final String id;

  CardList({this.items, this.id, Key key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;
  int upperLimit = 10;
  List<Video> tabList;

  Widget _buildVideoTile(BuildContext context, int index) {
    if (index == tabList.length) {
      return _buildProgressIndicator();
    }

    Video curVid = tabList[index];

    return CardCotnainer(
      curVid: curVid,
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  void _fetchMoreTrendingVideos(String ceiling) async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });

      double edge = 50.0;
      double offsetFromBottom = _scrollController.position.maxScrollExtent -
          _scrollController.position.pixels;

      final String url =
          "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&chart=mostPopular&maxResults=${ceiling}&regionCode=US&videoCategoryId=${widget.id}&key=${Keys.ANDROID_PUBLIC}";
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        final parsed_vid = jsonResponse['items']
            .map((vid) => Video.fromJSON(vid) as Video)
            .toList()
            .cast<Video>()
            .sublist(upperLimit);
        if (parsed_vid.isEmpty) {
          if (offsetFromBottom < edge) {
            _scrollController.animateTo(
                _scrollController.offset - (edge - offsetFromBottom),
                duration: new Duration(milliseconds: 500),
                curve: Curves.easeOut);
          }
        }
        setState(() {
          tabList.addAll(parsed_vid);
          upperLimit = int.parse(ceiling);
          isPerformingRequest = false;
        });
      } else {
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: new Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
        setState(() {
          isPerformingRequest = false;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //       tabList = widget.items;
    // });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _fetchMoreTrendingVideos((upperLimit * 2).toString());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tabList = widget.items;
    return (tabList == null)
        ? Text("Loading...")
        : (tabList.length == 0
            ? Text('No Recommendation found, please try later')
            : Container(
                margin: EdgeInsets.all(7.0),
                padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 3.0),
                child: ListView.builder(
                  itemCount: tabList.length + 1,
                  itemBuilder: _buildVideoTile,
                  controller: _scrollController,
                ),
              ));
  }
}
