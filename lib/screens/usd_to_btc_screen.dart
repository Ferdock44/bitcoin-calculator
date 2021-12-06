import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_calculator/utils/btc_tools.dart';

class UsdToBtcScreen extends StatefulWidget {
  double btcPrice;
  UsdToBtcScreen(this.btcPrice);

  @override
  _UsdToBtcScreenState createState() => _UsdToBtcScreenState();
}

class _UsdToBtcScreenState extends State<UsdToBtcScreen> {
  TextEditingController usd_to_btc_TextEditingController =
      TextEditingController();
  bool convert_button_disabled = true;
  bool valid_input = true;
  bool convert_button_pressed = false;
  double rawNumber;
  double btc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'USD to BTC',
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
              convert_button_pressed ? "$btc Bitcoin" : "",
              key: Key("btc-text"),
              style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                key: Key("usd-to-btc-textfield"),
                controller: usd_to_btc_TextEditingController,
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
              key: Key('convert-usd-to-btc-button'),
              color: Colors.deepOrange,
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
                                usd_to_btc_TextEditingController.text) ==
                            null)
                          valid_input = false;
                        else {
                          double input_value = double.parse(
                              usd_to_btc_TextEditingController.text);
                          rawNumber = BitcoinTools.usd_to_btc(
                              input_value, widget.btcPrice);
                          btc = double.parse((rawNumber).toStringAsFixed(9));
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
