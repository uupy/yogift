import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yo_gift/common/app_theme.dart';
import 'package:yo_gift/widgets/app_list_view/app_list_loading.dart';
import 'package:yo_gift/widgets/empty_box.dart';

import 'app_list_controller.dart';

typedef FetchRequest<T> = Future<List<T>> Function(Map<String, dynamic> params);

typedef ItemBuilder<T> = Widget Function(
    List<T> items, int index, List<T> list);

/// 实现上拉加载，下拉刷新
///
///
class AppListView<T> extends StatefulWidget {
  final FetchRequest<T>? fetch;
  final ItemBuilder<T>? itemBuilder;
  final bool immediate;
  final bool hasPage;
  final AppListController<T>? controller;
  final Widget? prefix;
  final Widget? empty;
  final Widget? firstTimeLoading;
  final double? footerHeight;
  final int colCount;

  const AppListView({
    Key? key,
    @required this.fetch,
    @required this.itemBuilder,
    this.immediate = true,
    this.hasPage = true,
    this.controller,
    this.prefix,
    this.empty,
    this.firstTimeLoading,
    this.footerHeight,
    this.colCount = 1,
  })  : assert(fetch != null && itemBuilder != null && colCount > 0),
        super(key: key);

  @override
  _AppListView<T> createState() => _AppListView<T>();
}

class _AppListView<T> extends State<AppListView<T>> {
  AppListController<T> _controller = AppListController<T>();
  bool firstEnter = true;

  @override
  void initState() {
    if (widget.controller != null) {
      _controller = widget.controller!;
    }
    _controller.setState = setState;
    _controller.hasPage = widget.hasPage;
    _controller.fetch = widget.fetch;
    if (widget.immediate && mounted) {
      _controller.onLoading();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = _controller.list;
    final len = list.length;
    int itemCount = (len / widget.colCount).ceil() + 1;

    if (widget.prefix != null) {
      itemCount += 1;
    }

    return SmartRefresher(
      enablePullUp: _controller.hasPage,
      controller: _controller.refreshController,
      onRefresh: _controller.onRefresh,
      onLoading: _controller.onLoading,
      header: const WaterDropHeader(
        waterDropColor: AppTheme.primaryColor,
        complete: Text("刷新成功", style: TextStyle(color: Colors.grey)),
        refresh: AppListLoading(),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, mode) {
          Widget child;
          TextStyle textStyle = const TextStyle(color: Colors.grey);
          if (mode == LoadStatus.idle) {
            child = Text("上拉加載", style: textStyle);
          } else if (mode == LoadStatus.loading && _controller.loading) {
            child = _buildProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            child = Text("加載失敗!", style: textStyle);
          } else if (mode == LoadStatus.canLoading) {
            child = Text("釋放加載更多", style: textStyle);
          } else {
            child = Text("已加載全部", style: textStyle);
          }
          return SizedBox(
            height: widget.footerHeight ?? 50,
            child: Center(
              child: child,
            ),
          );
        },
      ),
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (c, index) {
          final n = widget.prefix != null ? 1 : 0;
          int startIndex = (index - n) * widget.colCount;
          int endIndex = widget.colCount + startIndex;
          List<T> items = [];

          if (widget.prefix != null && index == 0) {
            return widget.prefix!;
          }
          if (list.isEmpty) {
            if (_controller.loading && !_controller.isPullDown) {
              return _buildProgressIndicator();
            }
            return widget.empty ?? const EmptyBox();
          }

          if (index == itemCount - 1) {
            return Container();
          }

          for (int i = startIndex; i < endIndex; i++) {
            if (i < len - 1) {
              items.add(list[i]);
            }
          }

          return widget.itemBuilder!(items, index, list);
        },
      ),
    );
  }

  /// 加载进度
  Widget _buildProgressIndicator() {
    if (widget.firstTimeLoading != null && _controller.page == 1) {
      return widget.firstTimeLoading!;
    }
    return const AppListLoading();
  }
}
