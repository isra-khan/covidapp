import 'package:covidapp/Services/state_services.dart';
import 'package:covidapp/view/detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController _controller = new TextEditingController();
  StateServices _services = new StateServices();
  String? name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: _controller,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: 'Search with country name',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
              child: FutureBuilder(
                  future: _services.fetchCountries(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return Shimmer.fromColors(
                          child: ListView.builder(
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                        title: Container(
                                          width: 80,
                                          height: 10,
                                          color: Colors.white,
                                        ),
                                        subtitle: Container(
                                          width: 80,
                                          height: 10,
                                          color: Colors.white,
                                        ),
                                        leading: Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.white,
                                        )),
                                  ],
                                );
                              }),
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100);
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];

                            if (_controller.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                  )));
                                    },
                                    child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag']),
                                        )),
                                  ),
                                ],
                              );
                            }
                            if (name
                                .toLowerCase()
                                .contains(_controller.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCases: snapshot
                                                        .data![index]['cases'],
                                                    totalRecovered:
                                                        snapshot.data![index]
                                                            ['recovered'],
                                                    totalDeaths: snapshot
                                                        .data![index]['deaths'],
                                                    active: snapshot
                                                        .data![index]['active'],
                                                    test: snapshot.data![index]
                                                        ['tests'],
                                                    todayRecovered:
                                                        snapshot.data![index]
                                                            ['todayRecovered'],
                                                    critical:
                                                        snapshot.data![index]
                                                            ['critical'],
                                                  )));
                                    },
                                    child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        title: Text(
                                            snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]
                                                ['cases']
                                            .toString()),
                                        leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag']),
                                        )),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  })),
        ]),
      ),
    );
  }
}
