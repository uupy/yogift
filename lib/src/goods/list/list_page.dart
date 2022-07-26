import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/filter_bar.dart';
import 'widgets/search_input.dart';

class GoodsListPage extends StatefulWidget {
  const GoodsListPage({Key? key}) : super(key: key);

  @override
  _GoodsListPageState createState() => _GoodsListPageState();
}

class _GoodsListPageState extends State<GoodsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchInput(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(36.w),
          child: const FilterBar(),
        ),
      ),
    );
  }
}
