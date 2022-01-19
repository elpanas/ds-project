import 'dart:convert' show jsonEncode;
import 'dart:io' show GZipCodec, HttpHeaders;

import 'package:beachu/constants.dart' show hashAuth, url;
import 'package:beachu/models/bath_model.dart';
import 'package:beachu/models/hive_model.dart';
import 'package:beachu/providers/bath_provider.dart';
import 'package:beachu/providers/http_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart' show GenerateMocks;
import 'package:mockito/mockito.dart' show when;

import 'http_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: "../../.env");
  Hive.registerAdapter(LocalBathAdapter());
  await Hive.initFlutter();
  await Hive.deleteBoxFromDisk('favourites');
  await Hive.openBox('favourites');
  BathProvider bathP = BathProvider();
  HttpProvider httpP = HttpProvider(bathP);

  final client = MockClient();
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
  const String jsonBath = '''{
    "_id": "1",
    "uid": "1",
    "name": "Bagno Prova",
    "av_umbrellas": 150,
    "tot_umbrellas": 150,
    "phone": "3333333",
    "location": {
      "type": "Point",
      "coordinates": [15.333, 41.222]
    },
    "city": "Manfredonia",
    "province": "Foggia"
  }''';

  final headersZip = {
    HttpHeaders.contentEncodingHeader: 'gzip',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $hashAuth',
  };

  tearDownAll(() async => await Hive.deleteBoxFromDisk('favourites'));

  group('HTTP methods', () {
    tearDownAll(() => bathP.removeBathItem(0));
    test('POST request', () async {
      final compressedBody = GZipCodec().encode(jsonEncode(bath).codeUnits);

      when(client.post(
        Uri.parse(url),
        headers: headersZip,
        body: compressedBody,
      )).thenAnswer((_) async => http.Response(jsonBath, 201));

      expect(await httpP.postBath(client, bath), isTrue);
    });

    test('GET request', () async {
      when(client.get(Uri.parse('${url}disp/coord/41.222/15.333')))
          .thenAnswer((_) async => http.Response('[$jsonBath]', 200));

      expect(await httpP.getHandler(client, '${url}disp/coord/41.222/15.333'),
          isTrue);
    });

    test('PATCH request', () async {
      final body = jsonEncode(<String, dynamic>{
        'av_umbrellas': 148,
      });
      final compressedBody = GZipCodec().encode(body.codeUnits);

      when(client.patch(
        Uri.parse('${url}1'),
        headers: headersZip,
        body: compressedBody,
      )).thenAnswer((_) async => http.Response('{}', 200));

      expect(await httpP.patchHandler(client, 0, 148), isTrue);
    });

    test('DELETE request', () async {
      when(client.delete(
        Uri.parse('${url}1'),
        headers: {HttpHeaders.authorizationHeader: 'Bearer $hashAuth'},
      )).thenAnswer((_) async => http.Response('{}', 200));

      expect(await httpP.deleteBath(client, 0), isTrue);
    });

    test('PUT request', () async {
      bathP.addBathItem(bath);
      final body = jsonEncode(bath);
      final compressedBody = GZipCodec().encode(body.codeUnits);

      when(client.put(
        Uri.parse('${url}1'),
        headers: headersZip,
        body: compressedBody,
      )).thenAnswer((_) async => http.Response('{}', 200));

      expect(await httpP.putBath(client, bath, 0), isTrue);
    });
  });

  group('Setters & Getters', () {
    test('should set loading status', () {
      httpP.loading = true;
      expect(httpP.loading, true);
    });
  });
}
