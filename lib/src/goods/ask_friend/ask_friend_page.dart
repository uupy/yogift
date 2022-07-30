import 'package:flutter/material.dart';
import 'package:yo_gift/widgets/header_background.dart';

class AskFriendPage extends StatefulWidget {
  const AskFriendPage({Key? key}) : super(key: key);

  @override
  _AskFriendPageState createState() => _AskFriendPageState();
}

class _AskFriendPageState extends State<AskFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('拜託贈送'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                HeaderBackground(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
