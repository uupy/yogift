// import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'app_list_view.dart';

class AppListController<T> {
  int page = 1;
  int pageSize = 20;
  bool loading = false;
  bool isAllLoaded = false;
  bool isPullDown = false;
  bool hasPage = true;
  bool reverseData = false;
  List<T> list = [];
  RefreshController refreshController = RefreshController();
  FetchRequest<T>? fetch;
  Function(Function())? setState;
  Function(List<T> list)? onLoaded;

  /// 下拉刷新
  Future onRefresh() async {
    await onReload(pullDown: true);
  }

  /// 重新加載
  Future onReload({bool? pullDown, bool? clean}) async {
    if (loading) return;
    page = 1;
    pageSize = 20;
    isAllLoaded = false;
    isPullDown = pullDown == true;
    if (clean ?? false) {
      list.clear();
    }
    await onLoading();
  }

  /// 用於詳情頁返回刷新
  Future onBackRefresh() async {
    pageSize = list.length > 20 ? list.length : 20;
    page = 1;
    return await onLoading(true);
  }

  /// 加載數據
  Future onLoading([bool isBackRefresh = false]) async {
    if (loading || isAllLoaded || fetch == null) return;
    try {
      loading = true;
      update();
      final items = await fetch!({
        'pageindex': page,
        'pagesize': pageSize,
      });

      if (page == 1) {
        list.clear();
      }

      if (isBackRefresh) {
        pageSize = 20;
      }

      if (items.isNotEmpty) {
        if (reverseData) {
          list.insertAll(0, items.reversed);
        } else {
          list.addAll(items);
        }
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
      onLoaded?.call(list);
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
