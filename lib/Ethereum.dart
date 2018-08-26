import 'package:flutter/material.dart';
import 'dart:math';


class Ethereum extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EthereumState();
  }
}

class EthereumState extends State<Ethereum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(Random.secure().nextDouble().toString())
    );
  }
}
