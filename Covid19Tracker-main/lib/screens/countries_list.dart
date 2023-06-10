import 'package:covid_19_tracker/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19_tracker/services/world_states_services.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  StatesServices statesServices = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                hintText: 'Search with country name',
                suffixIcon: searchController.text.isEmpty
                    ? const Icon(Icons.search)
                    : GestureDetector(
                        onTap: () {
                          searchController.text = "";
                          setState(() {});
                        },
                        child: const Icon(Icons.clear)),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: statesServices.fetchCountriesList(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  width: 100,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ));
                    });
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // ignore: non_constant_identifier_names
                    String CountryName = snapshot.data![index]["country"];
                    if (searchController.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            name: snapshot.data![index]
                                                ['country'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            totalRecovered: snapshot
                                                .data![index]['recovered'],
                                            totalDeaths: snapshot.data![index]
                                                ['deaths'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                          )));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  "Today's cases-: ${snapshot.data![index]['cases']}"),
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]['flag'])),
                            ),
                          )
                        ],
                      );
                    } else if (CountryName.toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                            image: snapshot.data![index]
                                                ['countryInfo']['flag'],
                                            name: snapshot.data![index]
                                                ['country'],
                                            totalCases: snapshot.data![index]
                                                ['cases'],
                                            totalRecovered: snapshot
                                                .data![index]['recovered'],
                                            totalDeaths: snapshot.data![index]
                                                ['deaths'],
                                            active: snapshot.data![index]
                                                ['active'],
                                            test: snapshot.data![index]
                                                ['tests'],
                                            todayRecovered: snapshot
                                                .data![index]['todayRecovered'],
                                            critical: snapshot.data![index]
                                                ['critical'],
                                          )));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  "Today's cases-: ${snapshot.data![index]['cases']}"),
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]['flag'])),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  });
            },
          )),
        ],
      )),
    );
  }
}
