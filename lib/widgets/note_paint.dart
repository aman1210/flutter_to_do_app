import 'package:flutter/material.dart';

class Pp extends StatelessWidget {
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      child: Stack(children: [
        CustomPaint(
          size: Size(mediaQuery.size.width, mediaQuery.size.height),
          painter: MyPaint(),
        ),
      ]),
    );
  }
}

class MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final p1 = Offset(0, 60);
    final p2 = Offset(width, 60);
    final p3 = Offset(0, 62);
    final p4 = Offset(width, 62);
    final linePaint = Paint()
      ..color = Colors.red[400]
      ..strokeWidth = 1;
    final linePaint2 = Paint()
      ..color = Colors.red[300]
      ..strokeWidth = 1;
    Paint paint = Paint();

    Path main = Path();
    main.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Colors.yellow[200];
    canvas.drawPath(main, paint);
    canvas.drawLine(p1, p2, linePaint);
    canvas.drawLine(p3, p4, linePaint2);

    for (var i = 98; i < height.floor(); i += 23) {
      var vp1 = Offset(0, i.floorToDouble());
      var vp2 = Offset(width, i.floorToDouble());
      var varlinePaint = Paint()
        ..color = Colors.black
        ..strokeWidth = 1;
      canvas.drawLine(vp1, vp2, varlinePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return old != this;
  }
}
