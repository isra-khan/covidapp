import 'package:covidapp/Model/casesmodel.dart';
import 'package:covidapp/Services/state_services.dart';
import 'package:covidapp/view/countries_list_screen.dart';
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
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();
  List<Color> chartColors = [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];
  late final AnimationController _animationController =
      new AnimationController(vsync: this);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  StateServicesController _servicesController =
      Get.put(StateServicesController());

  @override
  Widget build(BuildContext context) {
    //  StateServices services = new StateServices();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          FutureBuilder(
              future: _servicesController.fetchWorkStateRecords(),
              builder: (context, AsyncSnapshot<CasesModel> snapshot) {
                if (_servicesController.isLoading.value) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total":
                              double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString())
                        },
                        animationDuration: const Duration(microseconds: 1200),
                        chartValuesOptions: ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        legendOptions:
                            LegendOptions(legendPosition: LegendPosition.left),
                        chartType: ChartType.ring,
                        chartRadius: MediaQuery.of(context).size.width / 3.2,
                        colorList: chartColors,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10, bottom: 5, right: 10, top: 10),
                          child: Column(children: [
                            ReusableRow(
                              title: "Total",
                              value: snapshot.data!.cases.toString(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            ReusableRow(
                              title: "Deaths",
                              value: snapshot.data!.deaths.toString(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            ReusableRow(
                              title: "Recovered",
                              value: snapshot.data!.recovered.toString(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            ReusableRow(
                              title: "Active",
                              value: snapshot.data!.active.toString(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            ReusableRow(
                              title: "Critical",
                              value: snapshot.data!.critical.toString(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            ReusableRow(
                              title: "Today Deaths",
                              value: snapshot.data!.todayDeaths.toString(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            ReusableRow(
                              title: "Today Recovered",
                              value: snapshot.data!.todayRecovered.toString(),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             CountriesListScreen()));
                          Get.to(CountriesListScreen());
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            "Track Countries",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
        ]),
      ),
    ));
  }
}

class ReusableRow extends StatelessWidget {
  String? title, value;
  ReusableRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title.toString()),
            Text(value.toString()),
          ],
        ),
      ],
    );
  }
}
