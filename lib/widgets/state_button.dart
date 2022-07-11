import 'dart:async';

import 'package:flutter/material.dart';

class StateButton extends StatefulWidget {
  final double? width;
  final double? height;
  final double? radius;
  final Color? backgroundColor;
  final Color? backgroundFocusColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? boxShadow;
  final bool disabled;
  final Widget? child;
  final int continuousInterval;
  final VoidCallback? onPressed;
  final VoidCallback? onContinue;
  final Function(LongPressStartDetails)? onLongPressStart;
  final Function(LongPressEndDetails)? onLongPressEnd;

  const StateButton({
    Key? key,
    this.width,
    this.height,
    this.radius,
    this.backgroundColor,
    this.backgroundFocusColor,
    this.margin,
    this.padding,
    this.boxShadow,
    this.disabled = false,
    this.child,
    this.continuousInterval = 100,
    this.onPressed,
    this.onContinue,
    this.onLongPressStart,
    this.onLongPressEnd,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StateButton();
}

enum _State { none, down, up, cancel }

class _StateButton extends State<StateButton>
    with SingleTickerProviderStateMixin {
  var _state = _State.none;

  AnimationController? _controller;
  Animation<Color?>? _animation;

  /// 间隔时间
  late final _timeout = Duration(milliseconds: widget.continuousInterval);

  /// 定时器
  Timer? _timer;

  @override
  void initState() {
    final beginColor = widget.backgroundColor ?? Colors.white;
    final endColor = widget.backgroundFocusColor ?? beginColor;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );
    _animation = ColorTween(
      begin: beginColor,
      end: endColor,
    ).animate(_controller!);

    _controller?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 按下动画结束时，若已松开，则动画还原
        if (_state == _State.up) {
          _controller?.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        // 动画还原结束时，若非取消事件，则触发外部事件
        bool action = true;
        if (_state == _State.cancel) {
          action = false;
        }
        _state = _State.none;

        if (action) widget.onPressed?.call();
      }
    });

    _controller?.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _stopTimer();
    super.dispose();
  }

  void _onMouseDown() {
    if (_state != _State.none) return;
    _state = _State.down;

    _controller?.forward();
  }

  void _onMouseUp() {
    if (_state != _State.down) return;
    _state = _State.up;

    if (_controller?.isAnimating ?? false) return;
    _controller?.reverse();
  }

  void _onMouseCancel() {
    if (_state != _State.down) return;
    _state = _State.cancel;

    _controller?.reverse();
  }

  void _runTimer() {
    _stopTimer();
    _timer = Timer.periodic(_timeout, (timer) {
      widget.onContinue?.call();
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (t) {
        if (widget.disabled) return;
        _onMouseDown();
      },
      onTapUp: (t) {
        _onMouseUp();
      },
      onTapCancel: () {
        _onMouseCancel();
      },
      onLongPressStart: (data) {
        _runTimer();
        widget.onLongPressStart?.call(data);
      },
      onLongPressEnd: (data) {
        _stopTimer();
        widget.onLongPressEnd?.call(data);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        padding: widget.padding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _animation?.value,
          borderRadius: BorderRadius.circular(widget.radius ?? 0),
          boxShadow: widget.boxShadow,
        ),
        child: widget.child,
      ),
    );
  }
}
