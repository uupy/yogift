import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 取消焦点收起键盘
class FocusMonitoring extends StatefulWidget {
  final Widget child;

  const FocusMonitoring({Key? key, required this.child}) : super(key: key);

  @override
  State<FocusMonitoring> createState() => _FocusMonitoringState();
}

class _FocusMonitoringState extends State<FocusMonitoring>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      try {
        if (Platform.isIOS) {
          if (isKeyboardVisible) {
            Future.delayed(const Duration(milliseconds: 500), () {
              showOverlay(context);
            });
          } else {
            removeOverlay();
          }
        }

        return tapView(isKeyboardVisible);
      } catch (e) {
        return tapView(isKeyboardVisible);
      }
    });
  }

  tapView(bool isKeyboardVisible) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        hideKeyBoard();
      },
      child: Container(
        margin: EdgeInsets.only(
            bottom: (isKeyboardVisible && Platform.isIOS) ? 34.r.r : 0),
        child: widget.child,
      ),
    );
  }

  ///收起键盘
  hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  OverlayEntry? overlayEntry;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      reverseDuration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  showOverlay(BuildContext context) {
    if (overlayEntry != null) {
      removeOverlay();
    }
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (currentFocus.hasPrimaryFocus || currentFocus.focusedChild == null) {
      return;
    }
    OverlayState? overlayState = Overlay.of(context);

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          right: 0.0,
          left: 0.0,
          child: FadeTransition(
            opacity: controller,
            child: GestureDetector(
              onTap: () {
                hideKeyBoard();
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey,
                height: 34.r,
                child: const Text("收起鍵盤"),
              ),
            ),
          ));
    });
    overlayState?.insert(overlayEntry!);
    controller.forward();
  }

  removeOverlay() {
    controller.reverse();
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }
}
