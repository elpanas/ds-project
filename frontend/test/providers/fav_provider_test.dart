import 'package:beachu/models/bath_model.dart';
import 'package:beachu/models/hive_model.dart';
import 'package:beachu/providers/bath_provider.dart';
import 'package:beachu/providers/fav_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: "../../.env");
  Hive.registerAdapter(LocalBathAdapter());
  await Hive.initFlutter();
  await Hive.deleteBoxFromDisk('favourites');
  await Hive.openBox('favourites');
  BathProvider bathP = BathProvider();
  FavProvider favP = FavProvider(bathP);
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

  tearDownAll(() async => await Hive.deleteBoxFromDisk('favourites'));

  group('Fav methods', () {
    test('should add fav to the list', () {
      bath.bid = '1';
      bathP.addBathItem(bath);
      favP.addFav(0);
      expect(favP.favList.length, 1);
    });

    test('should load favs', () {
      favP.loadFavList();
      expect(favP.favList.length, 1);
    });

    test('should remove fav from the list', () {
      favP.delFav('1');
      expect(favP.favList.isEmpty, true);
    });
  });
}
