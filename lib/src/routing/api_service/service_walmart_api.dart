import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/pages/models/walmart_card_model.dart';

class WalmartApiService {
  static const String baseUrl = 'https://api.bluecartapi.com';
  static const String apiKey = '269FFBEA98384667B0D2B99B274D112E';

  // Singleton pattern
  WalmartApiService._privateConstructor();
  static final WalmartApiService instance =
      WalmartApiService._privateConstructor();

  Future<List<WalmartProduct>> fetchData(String productName) async {
    try {
      var uri = Uri.https('api.bluecartapi.com', '/request', {
        'api_key': '775B5B90D62E48FCA2EE7CECAE895DC0',
        'search_term': productName,
        'type': 'search',
      });

      var response = await http.get(uri);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData is Map<String, dynamic>) {
          return parseData(jsonData);
        } else {
          print('Error parsing data: Unexpected data format');
          return [];
        }
      } else {
        print('Error: ${response.statusCode}');

        return [];
      }
    } catch (error) {
      print('Error fetching data from BlueCart API: $error');
      return [];
    }
  }

  List<WalmartProduct> parseData(Map<String, dynamic> jsonData) {
    List<WalmartProduct> data = [];

    try {
      if (jsonData.containsKey('search_results')) {
        var searchResults = jsonData['search_results'];

        if (searchResults is List) {
          data = searchResults
              .map((result) {
                if (result is Map<String, dynamic> &&
                    result.containsKey('product') &&
                    result.containsKey('offers')) {
                  // Extract 'product' and 'offers' data
                  var productData = result['product'];
                  var offersData = result['offers'];

                  // Parse WalmartProduct from productData and offersData
                  return WalmartProduct.fromJson(productData, offersData);
                } else {
                  print(
                      'Error parsing data: Unexpected data format for product or offers');
                  return null;
                }
              })
              .whereType<WalmartProduct>()
              .toList();
        } else {
          print(
              'Error parsing data: Unexpected data format for search_results');
        }
      } else {
        print('Error parsing data: search_results not found in response');
      }
    } catch (error) {
      print('Error parsing data: $error');
    }

    return data;
  }
}
