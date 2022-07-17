import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  final double height;
  final double width;
  final double radius;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;

  const Skeleton({
    Key? key,
    this.height = double.infinity,
    this.width = double.infinity,
    this.radius = 0,
    this.borderRadius,
    this.margin,
  }) : super(key: key);

  @override
  createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  Animation? gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });

    _controller?.repeat();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ??
            BorderRadius.all(
              Radius.circular(widget.radius),
            ),
        gradient: LinearGradient(
          begin: Alignment(gradientPosition?.value, 0),
          end: const Alignment(-1, 0),
          colors: const [
            Color.fromRGBO(0, 0, 0, 0.13),
            Color.fromRGBO(0, 0, 0, 0.08),
            Color.fromRGBO(0, 0, 0, 0.13),
          ],
        ),
      ),
    );
  }
}
