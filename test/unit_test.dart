import 'package:test/test.dart';
import 'package:bitcoin_calculator/utils/btc_tools.dart';

void main() {
  group("usd_to_btc", () {
    test("calculates 100 usd to btc with a btc price of 59024", () {
      var btc = BitcoinTools.usd_to_btc(100, 59024);
      expect(btc, closeTo(0.001694226078, .000001));
    });
    test("calculates 555.5 usd to btc with a btc price of 59024", () {
      var btc = BitcoinTools.usd_to_btc(555.5, 59024);
      expect(btc, closeTo(0.009411425861, .000001));
    });
    test("calculates 100 usd to btc with a btc price of 934.5833", () {
      var btc = BitcoinTools.usd_to_btc(100, 934.5833);
      expect(btc, closeTo(0.106999558, .000001));
    });
    test("calculates 555.5 usd to btc with a btc price of 934.5833", () {
      var btc = BitcoinTools.usd_to_btc(555.5, 934.5833);
      expect(btc, closeTo(0.5943825446, .000001));
    });
    test("throws argument error on negative number", () {
      expect(() => BitcoinTools.usd_to_btc(-1, 1), throwsArgumentError);
    });
  });

  group("btc_to_usd", () {
    test("calculates 1 BTC to USD with a btc price of 59024", () {
      var usd = BitcoinTools.btc_to_usd(1, 59024);
      expect(usd, 59024);
    });
    test("calculates 5.5 BTC to USD with a btc price of 59024", () {
      var usd = BitcoinTools.btc_to_usd(5.5, 59024);
      expect(usd, 324632);
    });
    test("calculates 1 BTC to USD with a btc price of 934.5833", () {
      var usd = BitcoinTools.btc_to_usd(1, 934.5833);
      expect(usd, 934.5833);
    });
    test("calculates 5.5 BTC to USD with a btc price of 934.5833", () {
      var usd = BitcoinTools.btc_to_usd(5.5, 934.5833);
      expect(usd, 5140.20815);
    });
    test("Throws ArgumentError for Negative btc", () {
      expect(() => BitcoinTools.btc_to_usd(-1, 1), throwsArgumentError);
    });
  });
}
