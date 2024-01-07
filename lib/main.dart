import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formkey = GlobalKey<FormState>();
  final _idController = TextEditingController(text: 'LiveStream');
  bool isHostButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Live Streaming'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
              ),
              Row(
                children: [
                  Text('Host Button: '),
                  Switch(
                    value: isHostButton,
                    onChanged: (val) {
                      setState(() {
                        isHostButton = !isHostButton;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Join'),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LivePage(
                liveID: _idController.text.toString(),
                isHost: isHostButton,
              ),
            ),
          );
        },
      ),
    );
  }
}

class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  const LivePage({Key? key, required this.liveID, this.isHost = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID:
            663447110, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
        appSign:
            "d1e15cc0cbfd9b170995a3a538d162ce78a7ee21cf29d23b698c8871c17232e9", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
        userID: 'user_id' + Random().nextInt(100).toString(),
        userName: 'user_name' + Random().nextInt(100).toString(),
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}
