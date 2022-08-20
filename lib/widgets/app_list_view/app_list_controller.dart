import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app_list_view.dart';

class AppListController<T> {
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
  Function(List<T> list)? onLoaded;

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
        'pageindex': page,
        'pagesize': pageSize,
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
