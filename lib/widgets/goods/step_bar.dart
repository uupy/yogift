import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepBar extends StatelessWidget {
  final List<String> steps;
  final double? padding;

  /// 当前步骤
  final int current;

  const StepBar({
    Key? key,
    required this.steps,
    this.current = 1,
    this.padding,
  }) : super(key: key);

  bool get isLastStep {
    return current == steps.length;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 70.w,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: -1.w,
            child: buildArc('left'),
          ),
          Positioned(
            top: 0,
            right: -1.w,
            child: buildArc('right', isLastStep ? 1 : 0.4),
          ),
          Positioned(
            top: -7.w,
            left: padding ?? 30.w,
            right: padding ?? 30.w,
            height: 62.w,
            child: Row(
              children: steps.asMap().keys.map((index) {
                final label = steps[index];

                return Expanded(
                  child: Opacity(
                    opacity: index <= current - 1 ? 1 : 0.4,
                    child: Stack(
                      children: [
                        const Center(
                          child: Divider(
                            color: Color(0xffff8d00),
                            thickness: 2,
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffff8d00),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.w),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 0.9),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color.fromRGBO(0, 0, 0, .9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArc(String side, [double? opacity]) {
    return Opacity(
      opacity: opacity ?? 1,
      child: ClipRect(
        child: SizedBox(
          width: 40.w,
          height: 24.w,
          child: CustomPaint(
            foregroundPainter: ArcLinePainter(
              side: side,
            ),
          ),
        ),
      ),
    );
  }
}

class ArcLinePainter extends CustomPainter {
  final String? side;
  final double? radius;

  ArcLinePainter({
    this.side,
    this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final _radius = radius ?? 20.w;
    final paint = Paint()
      ..color = const Color(0xffff8d00)
      ..strokeWidth = 2
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;
    final path = Path();

    if (side == 'left') {
      path.moveTo(0, 0);
      path.cubicTo(0, _radius, _radius, size.height, size.width, size.height);
    } else {
      path.moveTo(size.width, 0);
      path.cubicTo(size.width, _radius, size.width - _radius, size.height, 0,
          size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
