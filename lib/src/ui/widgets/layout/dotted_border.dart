import 'package:path_drawing/path_drawing.dart';
//----------------------------------------------
import 'package:flutter/material.dart';
//-------------------------------------

/// Adds a dotted border around [child] widget. The [strokeWidth] property
/// defines the width of the dashed border and [color] determines the stroke
/// paint color. The [radius] property determines the border radius.
class DottedBorder extends StatelessWidget {
  final double strokeWidth;

  final Color color;

  final Radius radius;

  final Widget child;

  DottedBorder({
    required this.strokeWidth,
    this.color = Colors.black,
    this.radius = const Radius.circular(0.0),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: _DashPainter(
              strokeWidth: strokeWidth,
              radius: radius,
              color: color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(1.0),
          child: child,
        ),
      ],
    );
  }
}

class _DashPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final Radius radius;

  _DashPainter({
    required this.strokeWidth,
    required this.color,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Path _path = _getPath(size);
    canvas.drawPath(_path, paint);
  }

  /// Returns the path of dotted border.
  Path _getPath(Size size) {
    Path path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        this.radius,
      ),
    );
    return dashPath(path, dashArray: CircularIntervalList([8.0, 4.0]));
  }

  @override
  bool shouldRepaint(_DashPainter oldDelegate) => false;
}
