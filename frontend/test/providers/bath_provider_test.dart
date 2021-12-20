import 'package:beachu/models/bath_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beachu/providers/bath_provider.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: "../../.env");
  BathProvider bathP = BathProvider();

  Bath bath = Bath(
    uid: '1',
    name: 'Bagno Prova 2',
    avUmbrellas: 148,
    totUmbrellas: 148,
    phone: '3333333',
    latitude: 41.222,
    longitude: 15.333,
    city: 'Manfredonia',
    province: 'Foggia',
    fav: false,
  );

  group('List methods', () {
    test('number of elements should be 0', () {
      expect(bathP.bathCount, 0);
    });

    test('item should be added', () {
      bathP.addBathItem(bath);
      expect(bathP.bathCount, 1);
    });

    test('umbrellas number should be 148', () {
      expect(bathP.bath[0].avUmbrellas, 148);
    });

    test('umbrellas number should be decreased of 1', () {
      bathP.setUmbrellas(149, 0);
      expect(bathP.bath[0].avUmbrellas, 149);
    });

    test('item should be edited', () {
      bathP.editBathItem(bath, 0);
      expect(bathP.bath[0].totUmbrellas, 148);
    });

    test('item should be removed', () {
      bathP.removeBathItem(0);
      expect(bathP.bath, isEmpty);
    });
  });

  group('Setters & Getters', () {
    test('should set the uid', () {
      bathP.userId = '1';
      expect(bathP.userId, '1');
      expect(bathP.userId = '1', isNot(throwsException));
    });

    test('should set message', () {
      const message = 'This is a trial message';
      bathP.message = message;
      expect(bathP.message, message);
      expect(bathP.message = message, isNot(throwsException));
    });

    test('should return a bath', () {
      expect(bathP.bath, isA<List<Bath>>());
    });
  });
}
