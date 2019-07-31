import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:youplayer/containers/Controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../credentials/YoutubeAPI.dart' as Keys;

class VideoPlay extends StatefulWidget {
  final String id;
  final String title;

  VideoPlay({this.id, this.title, Key key}) : super(key: key);

  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  YoutubePlayerController _controller = YoutubePlayerController();

  double _volume = 100;

  bool _muted = false;

  void listener() {
    if (_controller.value.playerState == PlayerState.ENDED) {
      //TODO END STATE
    }
  }

  @override
  void deactivate() {
    print('deactivate called');
    // This pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Widget youtubePlayer = YoutubePlayer(
      context: context,
      videoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        forceHideAnnotation: true,
        showVideoProgressIndicator: true,
        disableDragSeek: false,
      ),
      videoProgressIndicatorColor: Color(0xFFFF0000),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 20.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Text(widget.title,
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white)),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.white,
            size: 25.0,
          ),
          onPressed: () {},
        ),
      ],
      progressColors: ProgressColors(
        playedColor: Color(0xFFFF0000),
        handleColor: Color(0xFFFF4433),
      ),
      onPlayerInitialized: (controller) {
        _controller = controller;
        _controller.addListener(listener);
      },
    );

    Widget controllPanel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
          onPressed: () {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
            setState(() {
              //Refresh here
            });
          },
        ),
        IconButton(
          icon: Icon(_muted ? Icons.volume_off : Icons.volume_up),
          onPressed: () {
            _muted ? _controller.unMute() : _controller.mute();
            setState(() {
              _muted = !_muted;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.fullscreen),
          onPressed: () => _controller.enterFullScreen(),
        ),
      ],
    );

    return YoutubeScaffold(
      fullScreenOnOrientationChange: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              youtubePlayer,
              SizedBox(
                height: 10.0,
              ),
              controllPanel
            ],
          ),
        ),
      ),
    );
  }
}
