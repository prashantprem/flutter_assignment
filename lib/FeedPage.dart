import 'package:flutter/material.dart';
import 'package:flutter_assignment/VideoList.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPage createState() => _FeedPage();
}

class _FeedPage extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8, right: 0, top: 8, bottom: 8),
          child: Image.asset(
            "assets/images/feed_play.png",
          ),
        ),
        title: const Text('Video Feed'),
        backgroundColor: const Color(0xff1f2c34),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/json/dataset.json'),
        builder: (context, snapshot) {
          return Container(
            color: const Color(0xff121b22),
            child: VideoList(snapshot.data),
          );
        },
      ),
    );
  }
}
