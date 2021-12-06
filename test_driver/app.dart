import 'package:flutter_driver/driver_extension.dart';
import 'package:bitcoin_calculator/main.dart' as app;
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:bitcoin_calculator/config/globals.dart' as globals;

class MockClient extends Mock implements http.Client {}

void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  final MockClient client = MockClient();

  final fakeBtcPriceApiData =
      '{ "time": {"updated": "date string", "updatedISO": "ISO date string", "updateduk": "uk date string"}, "disclaimer": "mock disclaimer", "bpi": { "USD": { "code": "USD", "rate": "14,934.5833", "description": "United States Dollar", "rate_float": 14934.5833 } } }';
  when(client.get("https://api.coindesk.com/v1/bpi/currentprice/usd.json"))
      .thenAnswer((_) async => http.Response(fakeBtcPriceApiData, 200));

  globals.httpClient = client;
  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
