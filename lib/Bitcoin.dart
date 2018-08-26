import 'package:flutter/material.dart';
import 'dart:math';


class Bitcoin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BitcoinState();
  }
}

class BitcoinState extends State<Bitcoin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(Random.secure().nextDouble().toString())
    );
  }
}
