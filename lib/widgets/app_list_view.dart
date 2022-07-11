import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef FetchRequest<T> = Future<List<T>> Function(Map<String, dynamic> params);

typedef ItemBuilder<T> = Widget Function(T item, int index, List<T> list);

/// 实现上拉加载，下拉刷新
///
///
class AppListView<T> extends StatefulWidget {
  final FetchRequest<T>? fetch;
  final ItemBuilder<T>? itemBuilder;
  final bool immediate;
  final bool hasPage;
  final AppListViewController<T>? controller;
  final Widget? empty;
  final Widget? firstTimeLoading;

  const AppListView({
    Key? key,
    @required this.fetch,
    @required this.itemBuilder,
    this.immediate = true,
    this.hasPage = true,
    this.controller,
    this.empty,
    this.firstTimeLoading,
  })  : assert(fetch != null && itemBuilder != null),
        super(key: key);

  @override
  _AppListView<T> createState() => _AppListView<T>();
}

class _AppListView<T> extends State<AppListView<T>> {
  AppListViewController<T> _controller = AppListViewController<T>();
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
    return SmartRefresher(
      enablePullUp: _controller.hasPage,
      controller: _controller.refreshController,
      onRefresh: _controller.onRefresh,
      onLoading: _controller.onLoading,
      header: const WaterDropHeader(
        complete: Text("刷新成功", style: TextStyle(color: Colors.grey)),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, mode) {
          Widget child;
          TextStyle textStyle = const TextStyle(color: Colors.grey);
          if (mode == LoadStatus.idle) {
            child = Text("上拉加载", style: textStyle);
          } else if (mode == LoadStatus.loading && _controller.loading) {
            child = _buildProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            child = Text("加载失败!", style: textStyle);
          } else if (mode == LoadStatus.canLoading) {
            child = Text("释放加载更多", style: textStyle);
          } else {
            child = Text("已加载全部", style: textStyle);
          }
          return SizedBox(
            height: 50,
            child: Center(
              child: child,
            ),
          );
        },
      ),
      child: ListView.builder(
        itemCount: _controller.list.length + 1,
        itemBuilder: (c, i) {
          if (_controller.list.isEmpty) {
            if (_controller.loading && !_controller.isPullDown) {
              return _buildProgressIndicator();
            }
            return widget.empty ??
                const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      '暂无数据',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
          }
          if (i == _controller.list.length) {
            return Container();
          }
          final item = _controller.list[i];
          return widget.itemBuilder!(item, i, _controller.list);
        },
      ),
    );
  }

  /// 加载进度
  Widget _buildProgressIndicator() {
    if (widget.firstTimeLoading != null && _controller.page == 1) {
      return widget.firstTimeLoading!;
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.grey,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              'loading',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppListViewController<T> {
  int page = 1;
  int pageSize = 20;
  bool loading = false;
  bool isAllLoaded = false;
  bool isPullDown = false;
  bool hasPage = true;
  List<T> list = [];
  RefreshController refreshController = RefreshController();
  FetchRequest<T>? fetch;
  Function(Function())? setState;

  Future onRefresh() async {
    await onReload(pullDown: true);
  }

  Future onReload({bool? pullDown}) async {
    if (loading) return;
    page = 1;
    isAllLoaded = false;
    isPullDown = pullDown == true;
    await onLoading();
  }

  Future onLoading() async {
    if (loading || isAllLoaded || fetch == null) return;
    try {
      loading = true;
      update();
      final items = await fetch!({
        'current': page,
        'pageSize': pageSize,
      });

      if (page == 1) {
        list.clear();
      }

      if (items.isNotEmpty) {
        list.addAll(items);
        page++;
      } else {
        refreshController.loadNoData();
        isAllLoaded = page != 1;
      }
      if (!hasPage) {
        refreshController.loadNoData();
        isAllLoaded = true;
      }
    } catch (e) {
      refreshController.refreshFailed();
      refreshController.loadFailed();
      rethrow;
    } finally {
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      loading = false;
      isPullDown = false;
      update();
    }
  }

  void update() {
    setState?.call(() {});
  }

  void dispose() {
    list.clear();
    page = 1;
    isAllLoaded = false;
    isPullDown = false;
    fetch = null;
    setState = null;
    // 不需要手动销毁
    // refreshController.dispose();
  }
}
