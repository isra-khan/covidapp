import 'dart:convert';
import 'package:covidapp/Model/casesmodel.dart';
import 'package:covidapp/constant/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class StateServicesController extends GetxController
    with SingleGetTickerProviderMixin {
  RxBool isLoading = true.obs;
  Rxn<CasesModel> casesModel = Rxn<CasesModel>(); // <-- NEW

  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  List<Color> chartColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  @override
  void onInit() {
    super.onInit();
    fetchWorkStateRecords(); // auto-fetch on init
  }

  Future<void> fetchWorkStateRecords() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(AppUrl.worldStateApi));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        casesModel.value = CasesModel.fromJson(data); // <-- set observable
      } else {
        throw Exception('Failed to fetch');
      }
    } catch (e) {
      // You can handle error or log it
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<dynamic>> fetchCountries() async {
    final response = await http.get(Uri.parse(AppUrl.worldCountries));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch countries');
    }
  }
}
