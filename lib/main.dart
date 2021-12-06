import 'package:flutter/material.dart';
import 'screens/btc_to_usd_screen.dart';
import 'screens/usd_to_btc_screen.dart';
import 'package:bitcoin_calculator/utils/btc_tools.dart';
import 'package:bitcoin_calculator/config/globals.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoConverter',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double btcPrice;

  @override
  void initState() {
    super.initState();
    BitcoinAPI.getPrice(httpClient).then((value) {
      btcPrice = value;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepOrange, title: Text('BTC Converter')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
                height: 55,
                child: RaisedButton(
                  key: Key("usd-to-btc-button"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.deepOrange[400],
                  child: Text('USD to BTC',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UsdToBtcScreen(btcPrice)),
                      );
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
                height: 55,
                child: RaisedButton(
                  key: Key("btc-to-usd-button"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.green,
                  child: Text('BTC to USD',
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BtcToUsdScreen(btcPrice)),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
