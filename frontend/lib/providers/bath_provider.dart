import 'package:beachu/models/bath_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart' show ChangeNotifier;
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart' show canLaunchUrl, launchUrl;

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
    await canLaunchUrl(Uri.parse('tel:${_bathList[index].phone}'))
        ? launchUrl(Uri.parse('tel:${_bathList[index].phone}'))
        : throw 'Could not launch';
  }

  openMap(int index) async {
    final lat = _bathList[index].latitude;
    final lng = _bathList[index].longitude;
    final label = _bathList[index].name;
    final geoUrl =
        Uri.parse(Uri.encodeFull('geo:$lat,$lng?q=$lat,$lng($label)'));
    final fallbackUrl =
        Uri.parse(Uri.encodeFull('https://maps.google.com/?q=$lat,$lng'));

    if (await canLaunchUrl(geoUrl)) {
      await MapsLauncher.launchCoordinates(lat, lng, label);
    } else if (await canLaunchUrl(fallbackUrl)) {
      await launchUrl(fallbackUrl);
    } else {
      print('Nessuna app o browser disponibile per aprire la mappa.');
      // Qui puoi anche mostrare un messaggio all'utente con un dialog o snackbar
    }
  }
  // coverage:ignore-end
  // ---------------------------------------------------------
}
