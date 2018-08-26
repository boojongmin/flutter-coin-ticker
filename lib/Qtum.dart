import 'package:flutter/material.dart';
import 'dart:math';


class Qtum extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QtumState();
  }
}

class QtumState extends State<Qtum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(Random.secure().nextDouble().toString())
    );
  }
}
