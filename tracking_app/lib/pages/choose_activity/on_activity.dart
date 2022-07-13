import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracking_app/pages/home/home.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:pedometer/pedometer.dart';

class OnActivity extends StatefulWidget {
  const OnActivity({Key? key}) : super(key: key);

  @override
  State<OnActivity> createState() => _OnActivityState();
}

class _OnActivityState extends State<OnActivity> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  int stepsOffset = -1;
  String _status = '?', _steps = '0', _distance = '0', _energy = '0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    if (stepsOffset == -1) stepsOffset = event.steps.toInt();
    setState(() {
      _steps = (event.steps - stepsOffset).toString();
      _distance = ((event.steps - stepsOffset) * 0.70104).toStringAsFixed(2);
      _energy = ((event.steps - stepsOffset) * 0.04).toInt().toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    setState(() {
      _status = 'Pedestrian Status not available';
    });
  }

  void onStepCountError(error) {
    setState(() {
      _steps = 'Error';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final db = FirebaseFirestore.instance;
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    return Scaffold(
        body: Center(
            child: Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.0,
        ),
        Icon(
          Icons.timer,
          size: 50,
          color: Colors.black87,
        ),
        SizedBox(
          height: 40.0,
        ),
        Text('Your activity has started',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        SizedBox(
          height: 10.0,
        ),
        StreamBuilder<int>(
            stream: _stopWatchTimer.rawTime,
            initialData: _stopWatchTimer.rawTime.value,
            builder: (context, snapshot) {
              final value = snapshot.data;
              final displayTime =
                  StopWatchTimer.getDisplayTime(value!, hours: _isHours);
              return Text(displayTime,
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ));
            }),
        SizedBox(
          height: 30.0,
        ),
        Text(
          'Steps',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Text(
          _steps,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.lightGreen),
        ),
        SizedBox(
          height: 25.0,
        ),
        Text(
          'Distance',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Text(
          "$_distance m",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w500, color: Colors.black38),
        ),
        SizedBox(
          height: 25.0,
        ),
        Text(
          'Energy',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Text(
          "$_energy kcal",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.redAccent),
        ),
        SizedBox(
          height: 25.0,
        ),
        Text(
          'Status',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Icon(
          _status == 'walking'
              ? Icons.directions_walk
              : _status == 'stopped'
                  ? Icons.accessibility_new
                  : Icons.error,
          size: 50,
        ),
        Text(
          _status,
          style: _status == 'walking' || _status == 'stopped'
              ? TextStyle(fontSize: 30)
              : TextStyle(fontSize: 20, color: Colors.red),
        ),
        SizedBox(
          height: 50.0,
        ),
        TextButton(
            child: Text('Stop'),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.red,
              onSurface: Colors.grey,
              elevation: 5,
              shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            ),
            onPressed: () async {
              await db
                  .collection('users')
                  .doc(auth.currentUser?.uid.toString())
                  .collection('unfinished')
                  .doc("1")
                  .get()
                  .then((DocumentSnapshot snapshot) async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid.toString())
                    .collection('activities')
                    .add({
                  'name': snapshot['name'],
                  'time_begin': snapshot['time_begin'],
                  'energy': _energy,
                  'steps': _steps,
                  'distance': _distance,
                  'time': DateTime.now()
                      .difference(snapshot['time_begin'].toDate())
                      .inMinutes,
                  'time_end': DateTime.now(),
                  'date': DateTime.now().day.toString() +
                      DateTime.now().month.toString() +
                      DateTime.now().year.toString(),
                });

                await FirebaseFirestore.instance.collection('activities').add({
                  'name': snapshot['name'],
                  'time_begin': snapshot['time_begin'],
                  'energy': _energy,
                  'steps': _steps,
                  'distance': _distance,
                  'time': DateTime.now()
                      .difference(snapshot['time_begin'].toDate())
                      .inMinutes,
                  'time_end': DateTime.now(),
                  'user': auth.currentUser?.uid.toString(),
                  'date': DateTime.now().day.toString() +
                      DateTime.now().month.toString() +
                      DateTime.now().year.toString(),
                });
              });

              await db
                  .collection('users')
                  .doc(auth.currentUser?.uid.toString())
                  .collection('unfinished')
                  .doc("1")
                  .delete();

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            }),
      ],
    )));
  }
}
