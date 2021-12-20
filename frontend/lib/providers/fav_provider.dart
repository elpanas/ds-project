import 'package:beachu/models/hive_model.dart';
import 'package:beachu/providers/bath_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class FavProvider extends ChangeNotifier {
  FavProvider(this._bathP);

  final BathProvider? _bathP;
  List<dynamic> _favList = [];

  get favList => _favList;
  get favCount => _favList.length;

  loadFavList() {
    var box = Hive.box('favourites');
    _favList = box.values.toList();
    if (_favList.isEmpty) _bathP!.message = 'no_baths'.tr();
    notifyListeners();
  }

  addFav(int index) {
    var box = Hive.box('favourites');
    LocalBath singleBath = LocalBath(
      bid: _bathP!.bath[index].bid!,
      name: _bathP!.bath[index].name,
      city: _bathP!.bath[index].city,
    );
    box.add(singleBath);
    _bathP!.bath[index].fav = true;
    _favList = box.values.toList();
    notifyListeners();
  }

  delFav(String? bid) {
    var box = Hive.box('favourites');

    box.values.firstWhere((element) => element.bid == bid).delete();
    // _bathP!.bath[index].fav = false;

    _bathP!.bath.firstWhere((element) => element.bid == bid).fav = false;
    _favList = box.values.toList();
    if (_favList.isEmpty) _bathP!.message = 'no_baths'.tr();
    notifyListeners();
  }
}
