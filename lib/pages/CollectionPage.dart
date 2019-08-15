import 'package:flutter/material.dart';
import '../model/Video.dart';
import '../templates/CardContainer.dart';

class CollectionPage extends StatelessWidget {
  final Function deleteVideos;
  final List<Video> collection;
  final String name;
  CollectionPage({this.collection, this.name, this.deleteVideos, key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int idx) =>
            CardCotnainer(curVid: collection[idx]),
        itemCount: collection.length,
      ),
    );
  }
}
