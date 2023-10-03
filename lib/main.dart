import 'package:country_api/data_layer/model/country_model.dart';
import 'package:flutter/material.dart';

import 'data_layer/data_sources/remote/api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Country Capitals',
      home: CountryList(),
    );
  }
}

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  final ApiService _apiService = ApiService();
  late Future<List<CountryModel>> _countries;

  @override
  void initState() {
    super.initState();
    _countries = _apiService.fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country Capitals'),
      ),
      body: FutureBuilder<List<CountryModel>>(
        future: _countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final countries = snapshot.data;
            return ListView.builder(
              itemCount: countries!.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return ListTile(
                  title: Text('Ccontry:${country.name}',style: const TextStyle(fontSize: 24)),
                  subtitle: Text('Capital: ${country.capital}',style: const TextStyle(fontSize: 18),),
                );
              },
            );
          }
        },
      ),
    );
  }
}
