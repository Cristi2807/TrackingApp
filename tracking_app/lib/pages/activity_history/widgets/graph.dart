import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Graph extends StatelessWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: GraphArea(),
      ),
    );
  }
}

class GraphArea extends StatefulWidget {
  const GraphArea({Key? key}) : super(key: key);

  @override
  State<GraphArea> createState() => _GraphAreaState();
}

class _GraphAreaState extends State<GraphArea>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int steps1 = 0, steps2 = 0, steps3 = 0, steps4 = 0, steps5 = 0;

  List<DataPoint> data = [
    DataPoint(day: 1, steps: 1),
    DataPoint(day: 2, steps: 1),
    DataPoint(day: 3, steps: 1),
    DataPoint(day: 4, steps: 1),
    DataPoint(day: 5, steps: 1),
    DataPoint(day: 6, steps: 1),
    DataPoint(day: 7, steps: 1),
    DataPoint(day: 8, steps: 1),
    DataPoint(day: 9, steps: 1),
  ];

  @override
  void initState() {
    getData();
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  getData() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String day1 = DateTime.now().subtract(Duration(days: 4)).day.toString() +
        DateTime.now().subtract(Duration(days: 4)).month.toString() +
        DateTime.now().subtract(Duration(days: 4)).year.toString();

    String day2 = DateTime.now().subtract(Duration(days: 3)).day.toString() +
        DateTime.now().subtract(Duration(days: 3)).month.toString() +
        DateTime.now().subtract(Duration(days: 3)).year.toString();

    String day3 = DateTime.now().subtract(Duration(days: 2)).day.toString() +
        DateTime.now().subtract(Duration(days: 2)).month.toString() +
        DateTime.now().subtract(Duration(days: 2)).year.toString();

    String day4 = DateTime.now().subtract(Duration(days: 1)).day.toString() +
        DateTime.now().subtract(Duration(days: 1)).month.toString() +
        DateTime.now().subtract(Duration(days: 1)).year.toString();

    String day5 = DateTime.now().day.toString() +
        DateTime.now().month.toString() +
        DateTime.now().year.toString();

    final querySnapshot1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid.toString())
        .collection('activities')
        .where('date', isEqualTo: day1)
        .get();

    final querySnapshot2 = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid.toString())
        .collection('activities')
        .where('date', isEqualTo: day2)
        .get();

    final querySnapshot3 = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid.toString())
        .collection('activities')
        .where('date', isEqualTo: day3)
        .get();

    final querySnapshot4 = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid.toString())
        .collection('activities')
        .where('date', isEqualTo: day4)
        .get();

    final querySnapshot5 = await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid.toString())
        .collection('activities')
        .where('date', isEqualTo: day5)
        .get();

    for (var doc in querySnapshot1.docs) {
      setState(() {
        if (doc.get('steps') != 'Error') {
          steps1 += int.parse(doc.get('steps'));
        }
      });
    }

    for (var doc in querySnapshot2.docs) {
      setState(() {
        if (doc.get('steps') != 'Error') {
          steps2 += int.parse(doc.get('steps'));
        }
      });
    }

    for (var doc in querySnapshot3.docs) {
      setState(() {
        if (doc.get('steps') != 'Error') {
          steps3 += int.parse(doc.get('steps'));
        }
      });
    }

    for (var doc in querySnapshot4.docs) {
      setState(() {
        if (doc.get('steps') != 'Error') {
          steps4 += int.parse(doc.get('steps'));
        }
      });
    }

    for (var doc in querySnapshot5.docs) {
      setState(() {
        if (doc.get('steps') != 'Error') {
          steps5 += int.parse(doc.get('steps'));
        }
      });
    }

    setState(() {
      data = [
        DataPoint(day: 1, steps: steps1),
        DataPoint(day: 2, steps: steps2),
        DataPoint(day: 3, steps: steps3),
        DataPoint(day: 4, steps: steps4),
        DataPoint(day: 5, steps: steps5),
        DataPoint(day: 6, steps: steps5),
        DataPoint(day: 7, steps: steps5),
        DataPoint(day: 8, steps: steps5),
        DataPoint(day: 9, steps: steps5),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animationController.forward(from: 0.0);
      },
      child: CustomPaint(
        painter: GraphPainter(
          _animationController.view,
          data: data,
        ),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<DataPoint> data;
  final Animation<double> _size;
  final Animation<double> _dotSize;

  GraphPainter(Animation<double> animation, {required this.data})
      : _size = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
          parent: animation,
          curve: Interval(0.0, 0.75, curve: Curves.easeInOutCubicEmphasized),
        )),
        _dotSize = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(
              0.75,
              1,
              curve: Curves.easeInOutCubicEmphasized,
            ),
          ),
        ),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    var xSpacing = size.width / (data.length - 1);

    var maxSteps = data
        .fold<DataPoint>(data[0], (p, c) => p.steps > c.steps ? p : c)
        .steps;

    // print(xSpacing);
    // print(maxSteps);

    var yRatio = size.height / maxSteps;
    var curveOffset = xSpacing * 0.3;

    List<Offset> offsets = [];

    var cx = 0.0;
    for (int i = 0; i < data.length; i++) {
      var y = size.height - (data[i].steps * yRatio * _size.value);

      offsets.add(Offset(cx, y));
      cx += xSpacing;
    }

    Paint linePaint = Paint()
      ..color = Colors.indigoAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Paint shadowPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..maskFilter = ui.MaskFilter.blur(ui.BlurStyle.solid, 3)
      ..strokeWidth = 3.0;

    Paint fillPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height),
        [
          Colors.indigoAccent,
          Colors.white,
        ],
      )
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Paint dotOutlinePaint = Paint()
      ..color = Colors.white.withAlpha(200)
      ..strokeWidth = 8;

    Paint dotCenter = Paint()
      ..color = Colors.indigoAccent
      ..strokeWidth = 8;

    Path linePath = Path();

    Offset cOffset = offsets[0];

    linePath.moveTo(cOffset.dx, cOffset.dy);

    for (int i = 1; i < offsets.length; i++) {
      var x = offsets[i].dx;
      var y = offsets[i].dy;
      var c1x = cOffset.dx + curveOffset;
      var c1y = cOffset.dy;
      var c2x = x - curveOffset;
      var c2y = y;

      linePath.cubicTo(c1x, c1y, c2x, c2y, x, y);
      cOffset = offsets[i];
    }

    Path fillPath = Path.from(linePath);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(fillPath, shadowPaint);
    canvas.drawPath(linePath, linePaint);

    canvas.drawCircle(offsets[4], 15 * _dotSize.value, dotOutlinePaint);
    canvas.drawCircle(offsets[4], 6 * _dotSize.value, dotCenter);
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return data != oldDelegate.data;
  }
}

class DataPoint {
  final int day;
  final int steps;

  DataPoint({
    required this.day,
    required this.steps,
  });
}
