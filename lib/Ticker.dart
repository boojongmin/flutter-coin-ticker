import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TickerModel {
    double last;
    double volume;

    TickerModel(this.last, this.volume);
}

class Ticker {
    Future<TickerModel> cobinhood(String code) async {
        final response =
            await http.get('https://api.cobinhood.com/v1/market/tickers/$code');
        if (response.statusCode == 200) {
            double last = double.parse(json.decode(response.body)['result']['ticker']['last_trade_price']);
            double volume = double.parse(json.decode(response.body)['result']['ticker']['24h_volume']);
            return new TickerModel(last, volume);
        } else {
            throw Exception('Failed to load post');
        }
    }

    Future<TickerModel> bitz(String code) async {
        final response =
            await http.get('https://api.bit-z.com/api_v1/ticker?coin=$code');
        if (response.statusCode == 200) {
            double last = double.parse(json.decode(response.body)['data']['last']);
            double volume = double.parse(json.decode(response.body)['data']['vol']);
            return new TickerModel(last, volume);
        } else {
            throw Exception('Failed to load post');
        }
    }

    Future<double> coinone(String code) async {
        final response =
            await http.get('https://api.coinone.co.kr/ticker/?currency=$code');
        if (response.statusCode == 200) {
            return double.parse(json.decode(response.body)['last']);
        } else {
            throw Exception('Failed to load post');
        }
    }

    Future<TickerModel> lbank(String code) async {
      final response =
      await http.get('http://api.lbank.info/v1/ticker.do?symbol=$code');
      if (response.statusCode == 200) {
          double last = json.decode(response.body)['ticker']['latest'];
          double volume = json.decode(response.body)['ticker']['vol'];
          return TickerModel(last, volume);
//        return double.parse(json.decode(response.body)['ticker']['latest']);
      } else {
        throw Exception('Failed to load post');
      }
    }
}

