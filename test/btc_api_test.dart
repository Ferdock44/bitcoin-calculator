import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/utils/btc_tools.dart';

class MockClient extends Mock implements http.Client {}

main() {
  group('getPrice', () {
    test("returns a double if the http call completes successfully", () async {
      final client = MockClient();
      final fakeBtcPriceApiData =
          '{ "time": {"updated": "date string", "updatedISO": "ISO date string", "updateduk": "uk date string"}, "disclaimer": "mock disclaimer", "bpi": { "USD": { "code": "USD", "rate": "14,934.5833", "description": "United States Dollar", "rate_float": 14934.5833 } } }';

      when(client.get("https://api.coindesk.com/v1/bpi/currentprice/usd.json"))
          .thenAnswer((_) async => http.Response(fakeBtcPriceApiData, 200));

      double btcPrice = await BitcoinAPI.getPrice(client);

      expect(btcPrice, isA<double>());

      expect(btcPrice, 14934.5833);
    });
    test("throws an exception if the http call completes with an error", () {
      final client = MockClient();

      when(client.get("https://api.coindesk.com/v1/bpi/currentprice/usd.json"))
          .thenAnswer((_) async => http.Response("Not Found", 404));

      expect(BitcoinAPI.getPrice(client), throwsException);
    });
  });
}
