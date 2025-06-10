import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:covidapp/controller/state_services_controller.dart';
import 'package:covidapp/view/world_states_screen.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 5), () {
      Get.put(StateServicesController());
      Get.off(() => WorldStateScreen());
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
