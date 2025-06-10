import 'package:covidapp/constant/responsive_config.dart';
import 'package:covidapp/controller/state_services_controller.dart';
import 'package:covidapp/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  final TextEditingController _controller = TextEditingController();
  final StateServicesController _servicesController =
      Get.find<StateServicesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive(context).width * 0.04,
            vertical: Responsive(context).height * 0.03,
          ),
          child: Column(
            children: [
              _buildSearchField(),
              const SizedBox(
                height: 20,
              ),
              _buildCountryList(),
            ],
          ),
        ));
  }

  /// 🔍 Search Field
  Widget _buildSearchField() {
    return TextFormField(
      controller: _controller,
      onChanged: (value) => setState(() {}),
      decoration: InputDecoration(
        hintText: 'Search with country name',
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  /// 📜 FutureBuilder to load country list
  Widget _buildCountryList() {
    return Expanded(
      child: FutureBuilder<List<dynamic>>(
        future: _servicesController.fetchCountries(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return _buildShimmer();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final country = snapshot.data![index];
                final countryName = country['country'] ?? '';
                final matchesSearch = _controller.text.isEmpty ||
                    countryName
                        .toLowerCase()
                        .contains(_controller.text.toLowerCase());

                return matchesSearch
                    ? _buildCountryTile(country)
                    : const SizedBox.shrink();
              },
            );
          }
        },
      ),
    );
  }

  /// 🇨🇺 Single country tile
  Widget _buildCountryTile(Map<String, dynamic> country) {
    return InkWell(
      onTap: () {
        Get.to(() => DetailScreen(
              image: country['countryInfo']['flag'],
              name: country['country'],
              totalCases: country['cases'],
              totalRecovered: country['recovered'],
              totalDeaths: country['deaths'],
              active: country['active'],
              test: country['tests'],
              todayRecovered: country['todayRecovered'],
              critical: country['critical'],
            ));
      },
      child: ListTile(
        title: Text(country['country']),
        subtitle: Text(country['cases'].toString()),
        leading: Image.network(
          country['countryInfo']['flag'],
          height: 50,
          width: 50,
        ),
      ),
    );
  }

  /// 💫 Shimmer loading widget
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => ListTile(
          leading: Container(width: 50, height: 50, color: Colors.white),
          title: Container(width: 80, height: 10, color: Colors.white),
          subtitle: Container(width: 80, height: 10, color: Colors.white),
        ),
      ),
    );
  }

  /// 🔼 AppBar
  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}
