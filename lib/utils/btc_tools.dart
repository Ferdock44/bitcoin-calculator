import 'package:http/http.dart' as http;
import 'dart:convert';

class BitcoinAPI {
  static Future<double> getPrice(http.Client client) async {
    final response = await client
        .get("https://api.coindesk.com/v1/bpi/currentprice/usd.json");

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return json["bpi"]["USD"]["rate_float"];
    } else {
      throw Exception("Failed to load BTC price");
    }
  }
}

class BitcoinTools {
  static double usd_to_btc(double usd, double btcPrice) {
    if (usd < 0) {
      throw ArgumentError();
    }
    return usd * (1.0 / btcPrice);
  }

  static double btc_to_usd(double btc, double btcPrice) {
    if (btc < 0) {
      throw ArgumentError();
    }
    return btc * btcPrice;
  }
}
