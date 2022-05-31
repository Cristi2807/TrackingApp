import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class RealTimeQuery extends StatefulWidget {
  const RealTimeQuery({Key? key}) : super(key: key);
  @override
  State<RealTimeQuery> createState() => _RealTimeQueryState();
}



class _RealTimeQueryState extends State<RealTimeQuery> {

  Query query= FirebaseDatabase.instance.ref("activities").orderByChild('timestamp');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:FirebaseAnimatedList(
          query: query,
          itemBuilder: (BuildContext context, snapshot,
            Animation<double> animation, int index){
            return Card(
              child:Column(
                children:[
                  Row(children: [Text(snapshot.value.toString())])
                ],
              ),
            );
          }
        )
      ),
    );
  }
}

