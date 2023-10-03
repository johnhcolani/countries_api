import 'dart:convert';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../../core/constants/constants.dart';
import '../../model/country_model.dart';

class ApiService {
  final String baseUrl =
      "https://countriesnow.space/api/v0.1/countries/capital";

  Future<List<CountryModel>> fetchCountries() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> countryData = data['data'];

      return countryData.map((json) => CountryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}

class ApiProvider {
  final apikey = Constants.apiKey;
  final baseUrl = Constants.baseURL;
  final Dio _dio = Dio();
  Future<dynamic> getData() async {
    final response = await _dio.get('$baseUrl/3/movie/550', queryParameters: {
      'api_key': apikey,
    });
    print(response.data);
    return response;
  }
}
