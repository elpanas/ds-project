import 'package:beachu/functions.dart' show validatorCallback;
import 'package:flutter_test/flutter_test.dart' show expect, isNull, test;
// import 'package:geolocator/geolocator.dart';

void main() {
  /*
  test('getPosition', () async {
    Position position = await getPosition();
    expect(position, isNotNull);
  });
  */
  test('Validation text', () async {
    final value = validatorCallback('prova');
    expect(value, isNull);
  });
}
