import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yo_gift/common/app_theme.dart';

class AnimatedButton extends StatefulWidget {
  final Color? color;
  final Color? borderColor;
  final String? text;
  final TextStyle? style;
  final Widget? child;
  final double? width;
  final double? height;
  final bool round;
  final bool disabled;
  final double? fontSize;
  final List<BoxShadow>? boxShadow;
  final Function()? onPressed;

  const AnimatedButton({
    Key? key,
    this.color = AppTheme.primaryColor,
    this.borderColor = AppTheme.primaryColor,
    this.text,
    this.child,
    this.boxShadow,
    this.width,
    this.height,
    this.round = true,
    this.disabled = false,
    this.onPressed,
    this.style,
    this.fontSize,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller?.forward();
  }

  void _onTapUp(TapUpDetails details) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _controller?.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - (_controller?.value ?? 0);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: () {
        if (widget.disabled) return;
        widget.onPressed?.call();
      },
      behavior: HitTestBehavior.opaque,
      child: Transform.scale(
        scale: _scale,
        child: buildButton(),
      ),
    );
  }

  Widget buildButton() {
    final _height = widget.height ?? 44.w;
    double _radius = 4.r;
    Color? _background = widget.color;
    Color? _borderColor = widget.borderColor;
    Color? _textColor = const Color.fromRGBO(0, 0, 0, 0.9);

    if (widget.round) {
      _radius = _height;
    }

    if (widget.disabled) {
      _background = const Color(0xffe6e6e6);
      _borderColor = const Color(0xffe6e6e6);
      _textColor = const Color.fromRGBO(0, 0, 0, 0.26);
    }

    return Container(
      width: widget.width,
      height: widget.height ?? 40.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_radius),
        boxShadow: widget.boxShadow,
        color: _background,
        border: Border.all(
          color: _borderColor ?? Colors.transparent,
        ),
      ),
      child: Center(
        child: widget.child ??
            Text(
              widget.text ?? 'button',
              style: widget.style ??
                  TextStyle(
                    fontSize: widget.fontSize ?? 14.sp,
                    color: _textColor,
                  ),
            ),
      ),
    );
  }
}
