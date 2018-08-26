import 'package:flutter/material.dart';
import './Sample.dart';
import './PLY.dart';
import './Bitcoin.dart';
//import './Ethereum.dart';
//import './Qtum.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: 'PLY'),
                  Tab(text: 'Sample'),
                  Tab(text: 'Bitcoin'),
//                  Tab(text: 'Ethereum'),
//                  Tab(text: 'Qtum'),
                ]
              ),
              title: Text('Wallets Demo'),
            ),
            body: TabBarView(
              children: [
                PLY(),
                Sample(),
                Bitcoin(),
//                Ethereum(),
//                Qtum(),
//                RandomWords(),
              ]
            )
          )),
    );
  }
}
