import 'dart:math';

BigInt convertAmountToToken(String amount) {
  return BigInt.from(double.parse(amount) * pow(10, 6));
}

BigInt convertAmountToEtherToken(String amount) {
  return BigInt.from(double.parse(amount) * pow(10, 18));
}