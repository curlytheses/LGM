import 'dart:convert';

import 'package:covid_19_tracker/models/world_states_model.dart';
import 'package:covid_19_tracker/services/utils/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices {
  Future<WorldStatesModel> fetchWorldStatesRecords() async {
    final resp = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (resp.statusCode == 200) {
      var data = jsonDecode(resp.body.toString());
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> fetchCountriesList() async {
    final resp = await http.get(Uri.parse(AppUrl.countriesList));
    if (resp.statusCode == 200) {
      var data = jsonDecode(resp.body.toString());
      return data;
    } else {
      throw Exception("Error");
    }
  }
}
