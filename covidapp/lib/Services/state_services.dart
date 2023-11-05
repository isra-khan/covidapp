import 'dart:convert';

import 'package:covidapp/Model/casesmodel.dart';
import 'package:covidapp/Services/Utilities/app_url.dart';
import 'package:covidapp/view/world_states.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class StateServicesController extends GetxController {
  Rx<bool> isLoading = true.obs;

  Future<CasesModel> fetchWorkStateRecords() async {
    isLoading = true.obs;
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      isLoading = false.obs;
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