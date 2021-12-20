import 'package:beachu/models/bath_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class BathProvider extends ChangeNotifier {
  List<Bath> _bathList = [];
  String _message = 'no_baths'.tr(), _uid = '';

  // VARS GETTERS
  get userId => _uid;
  get message => _message;
  get bathCount => _bathList.length;
  get bath => _bathList;
  // ---------------------------------------------------------

  // VARS SETTERS
  set userId(userId) {
    _uid = userId;
    notifyListeners();
  }

  set message(value) {
    _message = value;
    notifyListeners();
  }

  set bath(value) {
    _bathList = value;
    notifyListeners();
  }
  // ---------------------------------------------------------

  // LIST SETTERS
  addBathItem(Bath value) {
    _bathList.add(value);
    notifyListeners();
  }

  editBathItem(Bath value, int index) {
    _bathList[index] = value;
    notifyListeners();
  }

  removeBathItem(int index) {
    _bathList.removeAt(index);
    if (_bathList.isEmpty) _message = 'no_baths'.tr();
    notifyListeners();
  }

  setUmbrellas(int value, int index) {
    _bathList[index].avUmbrellas = value;
    notifyListeners();
  }

  // coverage:ignore-start
  callNumber(int index) async {
    await canLaunch('tel:${_bathList[index].phone}')
        ? launch('tel:${_bathList[index].phone}')
        : throw 'Could not launch';
  }

  openMap(int index) async {
    await MapsLauncher.launchCoordinates(
      _bathList[index].latitude,
      _bathList[index].longitude,
      _bathList[index].name,
    );
  }
  // coverage:ignore-end
  // ---------------------------------------------------------

}
