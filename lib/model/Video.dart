class Video {
  final String id;
  final String categorId;
  final String title;
  final String description;
  final String channelId;
  final String channelTitle;
  final String publishTime;
  final String views;

  Video.fromJSON(Map<String, dynamic> jsonMap)
      : id = jsonMap['id'],
        categorId = jsonMap['snippet']['categoryId'],
        title = jsonMap['snippet']['title'],
        channelId = jsonMap['snippet']['channelId'],
        publishTime = jsonMap['snippet']['publishedAt'],
        channelTitle = jsonMap['snippet']['channelTitle'],
        description = jsonMap['snippet']['description'],
        views = jsonMap['statistics']['viewCount'];
}
