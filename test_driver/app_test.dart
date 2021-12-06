// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

// Mock BTC price from MockClient = 14934.5833
// Displayed number is rounded to 9 decimal places

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  group('Happy Paths', () {
    /*
      Given I am on the conversion selection screen
      When I tap USD to BTC
      And I enter "500"
      Then I should see "0.033479341 Bitcoin"
    */
    test("should give the amount of USD in BTC", () async {
      final findUsdToBtcButton = find.byValueKey("usd-to-btc-button");

      await driver.tap(findUsdToBtcButton);

      final findUsdToBtcTextfield = find.byValueKey("usd-to-btc-textfield");
      final findUsdToBtcText = find.byValueKey("btc-text");
      final findConvertBtcToUsdButton =
          find.byValueKey("convert-usd-to-btc-button");

      await driver.tap(findUsdToBtcTextfield);
      await driver.enterText("500");
      await driver.waitFor(find.text("500"));
      await driver.tap(findConvertBtcToUsdButton);
      expect(await driver.getText(findUsdToBtcText), "0.033479341 Bitcoin");

      final findBackButton = find.byValueKey("back-button");

      await driver.tap(findBackButton);
    });

    /*
      Given I am on the conversion selection screen
      When I tap BTC to USD
      And I enter "5"
      Then I should see "74672.9165 USD"
    */
    test("should give the amount of BTC in USD", () async {
      final findBtcToUsdButton = find.byValueKey("btc-to-usd-button");

      await driver.tap(findBtcToUsdButton);

      final findBtcToUsdTextfield = find.byValueKey("btc-to-usd-textfield");
      final findBtcToUsdText = find.byValueKey("usd-text");
      final findConvertBtcToUsdButton =
          find.byValueKey("convert-btc-to-usd-button");

      await driver.tap(findBtcToUsdTextfield);
      await driver.enterText("5");
      await driver.waitFor(find.text("5"));
      await driver.tap(findConvertBtcToUsdButton);
      expect(await driver.getText(findBtcToUsdText), "74672.9165 USD");

      final findBackButton = find.byValueKey("back-button");

      await driver.tap(findBackButton);
    });
  });

  group('Sad Paths', () {
    test("should give 'invalid input' when '1,000' is entered", () async {
      final findUsdToBtcButton = find.byValueKey("usd-to-btc-button");

      await driver.tap(findUsdToBtcButton);

      final findUsdToBtcTextfield = find.byValueKey("usd-to-btc-textfield");
      final findConvertUsdToBtcButton =
          find.byValueKey("convert-usd-to-btc-button");

      await driver.tap(findUsdToBtcTextfield);
      await driver.enterText("1,000");
      await driver.waitFor(find.text("1,000"));
      await driver.tap(findConvertUsdToBtcButton);

      final findInvalidInput = find.text('invalid input');
      expect(await driver.getText(findInvalidInput), "invalid input");

      final findBackButton = find.byValueKey("back-button");

      await driver.tap(findBackButton);
    });

    test("should give 'invalid input' when '1,000' is entered", () async {
      final findBtcToUsdButton = find.byValueKey("btc-to-usd-button");

      await driver.tap(findBtcToUsdButton);

      final findBtcToUsdTextfield = find.byValueKey("btc-to-usd-textfield");
      final findConvertBtcToUsdButton =
          find.byValueKey("convert-btc-to-usd-button");

      await driver.tap(findBtcToUsdTextfield);
      await driver.enterText("1,000");
      await driver.waitFor(find.text("1,000"));
      await driver.tap(findConvertBtcToUsdButton);

      final findInvalidInput = find.text('invalid input');
      expect(await driver.getText(findInvalidInput), "invalid input");

      final findBackButton = find.byValueKey("back-button");

      await driver.tap(findBackButton);
    });
  });
}
