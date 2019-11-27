import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main(){
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BENI VIDEO PLAYER',
      home: videoExample(),
    );
  }
}
class videoExample extends StatefulWidget {
  @override
  _videoExampleState createState() => _videoExampleState();
}

class _videoExampleState extends State<videoExample> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.asset("assets/videos/demo.mp4")
      ..addListener(listener)
          ..setVolume(1.0)
          ..initialize();
      print("GETTING INITIALIZED");
    } else {
      if (playerController.value.isPlaying) {
        print("GETTING PAUSED");
        playerController.pause();
      } else {
        print("GETTING PLAYED AGAIN");
        playerController.initialize();
        playerController.play();
      }
    }
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Example'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            child: (playerController != null
            ? VideoPlayer(
              playerController,
            )
            :Container()),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          createVideo();
          playerController.play();

    },
          child: Icon(Icons.play_arrow),
    ),
      );
  }
}
