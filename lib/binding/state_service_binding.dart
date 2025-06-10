import 'package:covidapp/controller/state_services_controller.dart';
import 'package:get/get.dart';

class StateServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StateServicesController>(() => StateServicesController());
  }
}
