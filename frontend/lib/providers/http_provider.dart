import 'dart:convert';
import 'dart:io';

import 'package:beachu/constants.dart';
import 'package:beachu/functions.dart';
import 'package:beachu/models/bath_model.dart';
import 'package:beachu/providers/bath_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

class HttpProvider extends ChangeNotifier {
  HttpProvider(this._bathP);

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  final BathProvider? _bathP;

  bool _loading = false, _result = false;
  final _headersZip = {
    HttpHeaders.contentEncodingHeader: 'gzip',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $hashAuth',
  };
  final _header = {
    HttpHeaders.authorizationHeader: 'Bearer $hashAuth',
  };

  get loading => _loading;

  set loading(value) {
    _loading = value;
    notifyListeners();
  }

  // HANDLERS
  Future<bool> getHandler(http.Client client, String url) async {
    loading = true;
    _bathP!.message = 'loading'.tr();
    _result = false;
    try {
      final res = (_bathP!.userId == '')
          ? await client.get(Uri.parse(url))
          : await client.get(Uri.parse(url), headers: _header);
      if (res.statusCode == 200) {
        final resJson = jsonDecode(res.body);
        _bathP!.bath =
            resJson.map<Bath>((data) => Bath.fromJson(data)).toList();
        _result = true;
      } else {
        _bathP!.message = 'no_baths'.tr();
      }
    } catch (e) {
      _bathP!.message = 'no_baths'.tr();
      throw Exception(e);
    } finally {
      loading = false;
    }
    return _result;
  }

  Future<bool> patchHandler(http.Client client, int index, int newValue) async {
    loading = true;
    _result = false;
    final body = jsonEncode(<String, dynamic>{
      'av_umbrellas': newValue,
    });
    final compressedBody = GZipCodec().encode(body.codeUnits);

    try {
      final res = await client.patch(
        Uri.parse('$url${_bathP!.bath[index].bid!}'),
        headers: _headersZip,
        body: compressedBody,
      );

      if (res.statusCode == 200) {
        _bathP!.setUmbrellas(newValue, index);
        _result = true;
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      loading = false;
    }

    return _result;
  }

  Future<Bath> makeRequest(
    String name,
    int avUmbrellas,
    int totUmbrellas,
    String phone,
    String city,
    String province,
  ) async {
    Position position = await getPosition();
    return Bath(
      uid: _bathP!.userId,
      name: name,
      avUmbrellas: avUmbrellas,
      totUmbrellas: totUmbrellas,
      phone: phone,
      latitude: position.latitude,
      longitude: position.longitude,
      city: city,
      province: province,
      fav: false,
    );
  }
  // ---------------------------------------------------------

  // GET
  // coverage:ignore-start
  Future<bool> loadBaths() async {
    Position pos = await getPosition();
    return await getHandler(
        http.Client(), '${url}disp/coord/${pos.latitude}/${pos.longitude}');
  }

  Future<bool> loadBath(String bid) {
    return getHandler(http.Client(), '${url}bath/$bid');
  }

  Future<bool> loadManagerBaths() async {
    return await getHandler(http.Client(), '${url}gest/${_bathP!.userId}');
  }
  // coverage:ignore-end
  // ---------------------------------------------------------

  // CREATE
  Future<bool> postBath(http.Client client, Bath value) async {
    loading = true;
    _result = false;

    try {
      var compressedBody = GZipCodec().encode(jsonEncode(value).codeUnits);
      final res = await client.post(
        Uri.parse(url),
        headers: _headersZip,
        body: compressedBody,
      );

      if (res.statusCode == 201) {
        final resJson = jsonDecode(res.body);
        final singleBath = Bath.fromJson(resJson); // contiene solo 1 elemento
        _bathP!.addBathItem(singleBath);
        _result = true;
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      loading = false;
    }

    return _result;
  }
  // ---------------------------------------------------------

  // UPDATE

  Future<bool> putBath(http.Client client, Bath value, int index) async {
    loading = true;
    _result = false;

    final compressedBody =
        GZipCodec().encode(jsonEncode(_bathP!.bath).codeUnits);

    try {
      if (value.avUmbrellas <= value.totUmbrellas) {
        final res = await client.put(
          Uri.parse('$url${_bathP!.bath[index].bid}'),
          headers: _headersZip,
          body: compressedBody,
        );

        if (res.statusCode == 200) {
          _bathP!.editBathItem(value, index);
          _result = true;
        }
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      loading = false;
    }

    return _result;
  }

  Future<bool> increaseUmbrellas(int index) async {
    var bath = _bathP!.bath[index];
    if (bath.avUmbrellas < bath.totUmbrellas) {
      return await patchHandler(http.Client(), index, bath.avUmbrellas + 1);
    } else {
      return false;
    }
  }

  Future<bool> decreaseUmbrellas(int index) async {
    var bath = _bathP!.bath[index];
    if (bath.avUmbrellas > 0) {
      return await patchHandler(http.Client(), index, bath.avUmbrellas - 1);
    } else {
      return false;
    }
  }
  // ---------------------------------------------------------

  // DELETE
  Future<bool> deleteBath(http.Client client, int index) async {
    loading = true;
    _result = false;
    final bid = _bathP!.bath[index].bid;
    try {
      final res = await client.delete(
        Uri.parse('$url$bid'),
        headers: _header,
      );

      if (res.statusCode == 200) {
        _bathP!.removeBathItem(index);
        _result = true;
      }
    } catch (e) {
      // ...
    } finally {
      loading = false;
    }

    return _result;
  }
  // ---------------------------------------------------------
}
