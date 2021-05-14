import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:sync_biryani_web/location/model/loc.dart';

const _url = 'https://geolocation-db.com/json/';

class LocationAPI {
  LocationAPI();

  Future<String> fetchData() async {
    var _city = '';
    final resp = await http.get(_url);

    if (kIsWeb) {
      final _data = LocationModel.fromJson(json.decode(resp.body));

      _city = _data.city;
    }

    return _city;
  }
}
