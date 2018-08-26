import 'package:flutter/material.dart';
import 'dart:math';
import 'package:myapp/Ticker.dart';
import 'package:intl/intl.dart';


final cFormat = new NumberFormat("#,##0", "ko_KR");

class PLY extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PLYState();
}

class _PLYState extends State<PLY> {
  double _cobinhoodPlyBtc = 0.0;
  double _cobinhoodPlyEth = 0.0;
  double _bitzPlyBtc = 0.0;
  double _plyCount = 10000.0;
  final _plyController = new TextEditingController(text: '10000');
  final _krwController = new TextEditingController(text: '1000000');
  final _plyWishPriceController = new TextEditingController(text: '0.00002000');
  double _cobinhoodBtcUsdt = 0.0;
  double _cobinhoodEthUsdt = 0.0;
  double _bitzBtcUsdt = 0.0;
  double _bitzEthUsdt = 0.0;
  double _coinoneBtcKrw = 0.0;
  double _coinoneEthKrw = 0.0;
  TextField plyTextField;
  TextField krwTextField;
  TextField plyWishPriceTextField;
  double _cobinhoodKrwToBtcToPlyCount = 0.0;
  double _cobinhoodKrwToEthToPlyCount = 0.0;
  double _bitzKrwToBtcToPlyCount = 0.0;
  double _lbankPlyEth = 0.0;
  int _lbankPlyEthVolume = 0;
  int _bitzPlyBtcVolume = 0;
  int _cobinhoodPlyBtcVolume = 0;
  int _cobinhoodPlyEthVolume = 0;
  int _plyWishKRW = 0;


  @override
  void dispose() {
    _plyController.dispose();
    _krwController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Ticker ticker = Ticker();
    ticker.cobinhood('PLY-BTC').then((TickerModel m) {
      setState(() {
        _cobinhoodPlyBtc = m.last;
        _cobinhoodPlyBtcVolume = m.volume.floor();
      });
    });
    ticker.cobinhood('PLY-ETH').then((TickerModel m) {
      setState(() {
        _cobinhoodPlyEth = m.last;
        _cobinhoodPlyEthVolume = m.volume.floor();
      });
    });
    ticker.cobinhood('BTC-USDT').then((TickerModel m) {
      setState(() {
        _cobinhoodBtcUsdt = m.last;
      });
    });
    ticker.cobinhood('ETH-USDT').then((TickerModel m) {
      setState(() {
        _cobinhoodEthUsdt = m.last;
      });
    });
    ticker.bitz('ply_btc').then((TickerModel m) {
      setState(() {
        _bitzPlyBtc = m.last;
        _bitzPlyBtcVolume = m.volume.floor();
      });
    });
    ticker.bitz('btc_usdt').then((TickerModel m) {
      setState(() {
        _bitzBtcUsdt = m.last;
      });
    });
    ticker.bitz('eth_usdt').then((TickerModel m) {
      setState(() {
        _bitzEthUsdt = m.last;
      });
    });
    ticker.coinone('btc').then((double value) {
      setState(() {
        _coinoneBtcKrw = value;
      });
    });
    ticker.coinone('eth').then((double value) {
      setState(() {
        _coinoneEthKrw = value;
      });
    });
    ticker.lbank('ply_eth').then((TickerModel m) {
      setState(() {
        _lbankPlyEth = m.last;
        _lbankPlyEthVolume = m.volume.floor();
      });
    });

    plyTextField = TextField( keyboardType: TextInputType.number, controller: _plyController, textAlign: TextAlign.center,);
    _plyController.addListener(() {
      setState(() {
        calc();
      });
    });
    krwTextField = TextField( keyboardType: TextInputType.number, controller: _krwController, textAlign: TextAlign.center,);
    _krwController.addListener(() {
      setState(() {
        calc();
      });
    });
    plyWishPriceTextField = TextField( keyboardType: TextInputType.number, controller: _plyWishPriceController, textAlign: TextAlign.center,);
    _plyWishPriceController.addListener(() {
      setState(() {
        calc();
       });
    });
  }

  void calc() {
    _plyCount = double.parse(_plyController.text);
    double krw = double.parse(_krwController.text);
    _cobinhoodKrwToBtcToPlyCount = ( krw / _coinoneBtcKrw ) / _cobinhoodPlyBtc;
    _cobinhoodKrwToEthToPlyCount = ( krw / _coinoneEthKrw ) / _cobinhoodPlyEth;
    _bitzKrwToBtcToPlyCount = ( krw / _coinoneBtcKrw ) / _bitzPlyBtc;
    _plyWishKRW = (double.parse(_plyWishPriceController.text) * _plyCount * _coinoneBtcKrw).floor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Container(margin: EdgeInsets.only(top: 20.0),),
          Text('PLY 갯수를 입력해주세요: ', style: TextStyle(color: Colors.red) ,),
          Form(
            child: plyTextField,
          ),
          Text('PLY', style: TextStyle(color: Colors.red, fontSize: 15.0, fontWeight: FontWeight.bold)),
          _plyRowBuilder('Cobinhood', _cobinhoodPlyBtc, _cobinhoodPlyEth),
          _plyRowBuilder('Bitz', _bitzPlyBtc, 0.0),
          _plyRowBuilder('Lbank', 0.0, _lbankPlyEth),

          Container(margin: EdgeInsets.only(top: 20.0),),
          Text('USDT', style: TextStyle(color: Colors.red, fontSize: 15.0, fontWeight: FontWeight.bold)),
          _usdtRowBuilder('Cobinhood', _cobinhoodBtcUsdt, _cobinhoodEthUsdt),
          _usdtRowBuilder('Bitz', _bitzBtcUsdt, _bitzEthUsdt),
          Container(margin: EdgeInsets.only(top: 20.0),),
          Text('PLY -> KRW', style: TextStyle(color: Colors.red, fontSize: 15.0, fontWeight: FontWeight.bold)),
          _krwRowBuilder('Cobinhood', _coinoneBtcKrw, _coinoneEthKrw),
          Text('Result cobinhood', style: TextStyle(color: Colors.red, fontSize: 15.0, fontWeight: FontWeight.bold)),
          Text('PLY BTC KRW : ${cFormat.format((_cobinhoodPlyBtc  * _plyCount *_coinoneBtcKrw).floor())}'),
          Text('PLY ETH KRW : ${cFormat.format((_cobinhoodPlyEth  * _plyCount *_coinoneEthKrw).floor())}'),

          Container(margin: EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Text('PLY wish price: ', style: TextStyle(color: Colors.red, fontSize: 15.0, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Form(child: plyWishPriceTextField)
                ),
              ],
            ),
          ),
          Text('wish krw : ${cFormat.format(_plyWishKRW)}' ),

          Container(margin: EdgeInsets.only(top: 20.0),),
          Text('Volume', style: TextStyle(color: Colors.red, fontSize: 15.0, fontWeight: FontWeight.bold)),
          Text('cobinhood ply-btc volume: $_cobinhoodPlyBtcVolume'),
          Text('cobinhood ply-eth volume: $_cobinhoodPlyEthVolume'),
          Text('Bitz ply-eth volume: $_bitzPlyBtcVolume'),
          Text('Lbank ply-eth volume: $_lbankPlyEthVolume'),

          Container(margin: EdgeInsets.only(top: 20.0),),
          Text('KRW -> PLY', style: TextStyle(color: Colors.red)),
          Text('KRW를 입력해주세요: ', style: TextStyle(color: Colors.red) ,),
          Form(child: krwTextField),
          Text('Cobinhood: KRW-BTC-PLY: ${cFormat.format(_cobinhoodKrwToBtcToPlyCount)}'),
          Text('Cobinhood: KRW-ETH-PLY: ${cFormat.format(_cobinhoodKrwToEthToPlyCount)}'),
          Text('Bitz: KRW-BTC-PLY: ${cFormat.format(_bitzKrwToBtcToPlyCount)}'),
        ],
      )
    );
  }
}

Row _plyRowBuilder(String name, double _btc, _eth) {
  return new Row(
    children: [
      Icon(Icons.attach_money, ),
      SizedBox(
        width: 80.0,
        child: Text(name),
      ),
      SizedBox(
        width: 120.0,
        child: Text('${_btc == 0.0 ? '' : _btc.toStringAsFixed(8).toString() + "BTC"}')
      ),
      SizedBox(
        width: 120.0,
        child: Text('${_eth == 0.0 ? '' : _eth.toString() + "ETH"}')
      )
    ],
  );
}

Row _usdtRowBuilder(String name, double _btc, _eth) {
  return new Row(
    children: [
      Icon(Icons.attach_money, ),
      SizedBox(
        width: 80.0,
        child: Text(name),
      ),
      SizedBox(
          width: 120.0,
          child: Text('$_btc\$\/1BTC')
      ),
      SizedBox(
          width: 120.0,
          child: Text('$_eth \$\/1ETH')
      )
    ],
  );
}

Row _krwRowBuilder(String name, double _btc, _eth) {
  return new Row(
    children: [
      Icon(Icons.attach_money, ),
      SizedBox(
        width: 80.0,
        child: Text(name),
      ),
      SizedBox(
          width: 120.0,
          child: Text('${cFormat.format(_btc)} KRW\/1BTC'),
      ),
      SizedBox(
          width: 120.0,
          child: Text('${cFormat.format(_eth)} KRW\/1ETH')
      )
    ],
  );
}

