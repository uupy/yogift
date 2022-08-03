import 'package:yo_gift/router/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:yo_gift/widgets/empty_box.dart';

class FriendsPage extends StatelessWidget implements TabBarPage {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Expanded(child: EmptyBox()),
        SizedBox(height: 90),
      ],
    );
  }

  @override
  PreferredSizeWidget? get appBar {
    return AppBar(
      title: const Text('好友'),
    );
  }
}
