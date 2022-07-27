import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yo_gift/src/goods/detail/detail_controller.dart';

class GoodsDetailPage extends StatefulWidget {
  const GoodsDetailPage({Key? key}) : super(key: key);

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState();
}

class _GoodsDetailPageState extends State<GoodsDetailPage> {
  final controller = Get.put(GoodsDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('禮物詳情'),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
