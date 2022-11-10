import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppDetailScrollView extends StatefulWidget {
  final Widget? backdrop;
  final double? backdropHeight;
  final double? expandedHeight;
  final double? titleOpacity;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final Widget? appBarTitle;
  final List<Widget>? appBarActions;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Color? backdropBackgroundColor;
  final Color? bodyBackgroundColor;
  final Widget? sliverAppBarBackground;
  final PreferredSizeWidget? sliverAppBarBottom;
  final ScrollController? controller;
  final Function(num scrollTop)? onScrolling;

  const AppDetailScrollView({
    Key? key,
    this.backdrop,
    this.backdropHeight,
    this.expandedHeight,
    this.titleOpacity,
    this.systemOverlayStyle,
    this.appBarTitle,
    this.appBarActions,
    this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.backdropBackgroundColor,
    this.bodyBackgroundColor,
    this.sliverAppBarBackground,
    this.sliverAppBarBottom,
    this.controller,
    this.onScrolling,
  }) : super(key: key);

  @override
  _AppDetailScrollView createState() => _AppDetailScrollView();
}

class _AppDetailScrollView extends State<AppDetailScrollView> {
  GlobalKey expandedKey = GlobalKey();
  ScrollController? _controller;
  double titleOpacity = 0;
  double filterBlur = 0;
  bool enable = true;

  Future _onScrolling() async {
    if (enable) {
      enable = false;
      await Future.delayed(const Duration(milliseconds: 100));
      enable = true;
      num scrollTop = _controller?.position.pixels ?? 0;
      RenderObject? obj = expandedKey.currentContext?.findRenderObject();
      double expandedHeight =
          widget.expandedHeight ?? obj?.semanticBounds.size.height ?? 1;
      double scale = expandedHeight == 0 ? 0 : scrollTop / expandedHeight;
      double opacity = expandedHeight == 0 ? 1 : scrollTop / expandedHeight;
      double maxBlur = 6;

      if (scale > 1) {
        scale = 1;
      }
      if (opacity > 1) {
        opacity = 1;
      }

      if (filterBlur != maxBlur * scale) {
        setState(() {
          filterBlur = maxBlur * scale;
        });
      }
      if (titleOpacity != opacity) {
        setState(() {
          titleOpacity = opacity;
        });
      }
      widget.onScrolling?.call(scrollTop);
    }
  }

  @override
  void initState() {
    titleOpacity = widget.titleOpacity ?? 0;
    _controller =
        widget.controller ?? ScrollController(initialScrollOffset: 0.0);
    _controller?.addListener(_onScrolling);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.removeListener(_onScrolling);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.backdrop != null)
          Container(
            width: double.infinity,
            height: widget.backdropHeight,
            color: widget.backdropBackgroundColor ?? Colors.transparent,
            child: widget.backdrop,
          ),
        if (widget.backdrop != null && filterBlur > 1)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: widget.backdropHeight,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: filterBlur,
                  sigmaY: filterBlur,
                ),
                child: Container(
                  color: const Color.fromRGBO(255, 255, 255, 0.05),
                ),
              ),
            ),
          ),
        Positioned(
          top: (widget.backdropHeight ?? 0) - 1,
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: widget.bodyBackgroundColor ?? Colors.white,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: leading(),
            backgroundColor: Colors.transparent,
            systemOverlayStyle:
                widget.systemOverlayStyle ?? SystemUiOverlayStyle.light,
            title: Opacity(
              opacity: titleOpacity,
              child: widget.appBarTitle,
            ),
            actions: widget.appBarActions,
          ),
          body: NestedScrollView(
            controller: _controller,
            headerSliverBuilder: (
              BuildContext context,
              bool innerBoxIsScrolled,
            ) {
              return <Widget>[
                SliverToBoxAdapter(
                  child: Opacity(
                    opacity: 1 - titleOpacity,
                    child: SizedBox(
                      key: expandedKey,
                      height: widget.expandedHeight,
                      child: widget.sliverAppBarBackground,
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: StickyDelegate(
                    child: widget.sliverAppBarBottom,
                  ),
                  pinned: true,
                ),
              ];
            },
            body: widget.body ?? Container(),
          ),
          bottomNavigationBar: widget.bottomNavigationBar,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: widget.floatingActionButtonLocation,
        ),
      ],
    );
  }

  Widget leading() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.all(
              Radius.circular(36.w),
            ),
          ),
          child: Stack(
            children: [
              if (Platform.isAndroid)
                Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: 24.sp,
                  ),
                ),
              if (Platform.isIOS)
                Positioned(
                  top: 6.w,
                  right: 2.w,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 24.sp,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class StickyDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget? child;

  StickyDelegate({this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child ?? Container();
  }

  @override
  double get maxExtent => child?.preferredSize.height ?? 0;

  @override
  double get minExtent => child?.preferredSize.height ?? 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
