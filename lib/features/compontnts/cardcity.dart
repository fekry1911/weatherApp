import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardCity extends StatelessWidget {
  CardCity({super.key, required this.width, required this.city});

  double width;
  String city;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .09,
      margin: EdgeInsets.all(5),
      width: width.clamp(250, 500),
      // Min 250px, Max 500px
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            city,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}
