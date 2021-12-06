import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/utils/btc_tools.dart';

class BtcToUsdScreen extends StatefulWidget {
  double btcPrice;
  BtcToUsdScreen(this.btcPrice);

  @override
  _BtcToUsdScreenState createState() => _BtcToUsdScreenState();
}

class _BtcToUsdScreenState extends State<BtcToUsdScreen> {
  TextEditingController btc_to_usd_TextEditingController =
      TextEditingController();
  bool convert_button_disabled = true;
  bool valid_input = true;
  bool convert_button_pressed = false;
  double rawNumber;
  double usd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BTC to USD',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            key: Key("back-button"),
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            }),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              convert_button_pressed ? "$usd USD" : "",
              key: Key("usd-text"),
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                key: Key("btc-to-usd-textfield"),
                controller: btc_to_usd_TextEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  errorText: valid_input ? '' : 'invalid input',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {
                    convert_button_disabled = text.isEmpty;
                  });
                },
              ),
            ),
            RaisedButton(
              key: Key('convert-btc-to-usd-button'),
              color: Colors.green,
              disabledColor: Color(0xFFE2E2E2),
              child: Text(
                "Convert",
                style: TextStyle(
                    color: convert_button_disabled
                        ? Color(0xFF757474)
                        : Color(0xFFFFFFFF)),
              ),
              onPressed: convert_button_disabled
                  ? null
                  : () {
                      setState(() {
                        if (double.tryParse(
                                btc_to_usd_TextEditingController.text) ==
                            null)
                          valid_input = false;
                        else {
                          double input_value = double.parse(
                              btc_to_usd_TextEditingController.text);
                          rawNumber = BitcoinTools.btc_to_usd(
                              input_value, widget.btcPrice);
                          usd = double.parse((rawNumber).toStringAsFixed(9));
                          convert_button_pressed = true;
                          valid_input = true;
                        }
                      });
                    },
            ),
          ],
        )),
      ),
    );
  }
}
