import 'package:covidapp/Model/casesmodel.dart';
import 'package:covidapp/constant/responsive_config.dart';
import 'package:covidapp/controller/state_services_controller.dart';
import 'package:covidapp/view/routes/routes.dart';
import 'package:covidapp/view/widgets/resuablerow_widget.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class WorldStateScreen extends StatefulWidget {
  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  final serviceController = Get.find<StateServicesController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive(context).width * 0.04,
              vertical: Responsive(context).height * 0.03,
            ),
            child: Obx(() {
              if (serviceController.isLoading.value) {
                return _buildLoadingIndicator();
              } else if (serviceController.casesModel.value == null) {
                return const Center(child: Text("No data"));
              } else {
                return ListView(
                  children: [
                    _buildDataContent(serviceController.casesModel.value!),
                  ],
                );
              }
            }),
          )),
    );
  }

  /// Loading Spinner Widget
  Widget _buildLoadingIndicator() {
    return Center(
      child: SpinKitFadingCircle(
        color: Colors.green,
        size: 50,
        controller: serviceController.controller,
      ),
    );
  }

  /// Main Content Widget
  Widget _buildDataContent(CasesModel data) {
    return Column(
      children: [
        _buildPieChart(data),
        SizedBox(height: Responsive(context).height * 0.05),
        _buildStatsCard(data),
        SizedBox(height: Responsive(context).height * 0.05),
        _buildTrackButton(),
      ],
    );
  }

  /// Pie Chart Widget
  Widget _buildPieChart(CasesModel data) {
    return PieChart(
      dataMap: {
        "Total": double.parse(data.cases.toString()),
        "Recovered": double.parse(data.recovered.toString()),
        "Deaths": double.parse(data.deaths.toString()),
      },
      animationDuration: const Duration(milliseconds: 1200),
      chartValuesOptions: const ChartValuesOptions(
        showChartValuesInPercentage: true,
      ),
      legendOptions: const LegendOptions(
        legendPosition: LegendPosition.left,
      ),
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: serviceController.chartColors,
    );
  }

  /// Statistics Card Widget
  Widget _buildStatsCard(CasesModel data) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive(context).width * 0.01,
          vertical: Responsive(context).height * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ReusableRow(title: "Total", value: data.cases.toString()),
            ReusableRow(title: "Deaths", value: data.deaths.toString()),
            ReusableRow(title: "Recovered", value: data.recovered.toString()),
            ReusableRow(title: "Active", value: data.active.toString()),
            ReusableRow(title: "Critical", value: data.critical.toString()),
            ReusableRow(
                title: "Today Deaths", value: data.todayDeaths.toString()),
            ReusableRow(
                title: "Today Recovered",
                value: data.todayRecovered.toString()),
          ],
        ),
      ),
    );
  }

  /// Navigation Button Widget
  Widget _buildTrackButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
        onPressed: () {
          Get.toNamed(Routes.contactList);
        },
        child: const Text(
          "Track Countries",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
