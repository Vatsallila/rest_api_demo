import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(child: Image(image: AssetImage('images/image10.png'),),),
          Container(child: Image.asset('images/image10.png'),),
        ],
      ),
    );
  }
}
