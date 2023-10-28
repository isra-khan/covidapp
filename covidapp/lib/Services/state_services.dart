import 'dart:convert';

import 'package:covidapp/Model/casesmodel.dart';
import 'package:covidapp/Services/Utilities/app_url.dart';
import 'package:covidapp/view/world_states.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<CasesModel> fetchWorkStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return CasesModel.fromJson(data);
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> fetchCountries() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.worldCountries));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('error');
    }
  }
}


//part19