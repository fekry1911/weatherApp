import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hours extends StatelessWidget {
  Hours({super.key, required this.degree, required this.time, required this.icon});

  double? degree;
  String? time;
  String? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          Text("${degree}", style: TextStyle(color: Colors.white)),
          Spacer(),
          Flexible(
              flex: 4,
              child: Image.network("https:${icon!}",fit: BoxFit.fill,)),
          Spacer(),
          Text(time!, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
