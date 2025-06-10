import 'package:covidapp/binding/splash_binding.dart';
import 'package:covidapp/binding/state_service_binding.dart';
import 'package:covidapp/view/routes/routes.dart';
import 'package:covidapp/view/countries_list_screen.dart';
import 'package:covidapp/view/splash_screen.dart';
import 'package:get/get.dart';


class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.contactList,
      page: () => const CountriesListScreen(),
      binding: StateServicesBinding(),
    ),
  ];
}
