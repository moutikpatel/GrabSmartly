import 'package:flutter/material.dart';
import 'package:grabsmartly/src/routing/api_service/service_walmart_api.dart';
import '../../../models/walmart_card_model.dart';

class GroceryStorePriceScreen extends StatefulWidget {
  final String productName;

  const GroceryStorePriceScreen({required this.productName});

  @override
  _GroceryStorePriceScreenState createState() =>
      _GroceryStorePriceScreenState();
}

class _GroceryStorePriceScreenState extends State<GroceryStorePriceScreen> {
  late List<WalmartProduct> walmartSearchResults;

  @override
  void initState() {
    super.initState();
    walmartSearchResults = [];
    fetchDataFromApi();
  }

  void fetchDataFromApi() async {
    try {
      var data = await WalmartApiService.instance.fetchData(widget.productName);
      // Print the entire data structure fetched from the API
      print('API Response Data: $data');

      if (data != null) {
        // Check if the response is an empty list
        if (data is List && data.isEmpty) {
          setState(() {
            walmartSearchResults = []; // Set to an empty list or handle as needed
          });
        } else {
          setState(() {
            walmartSearchResults = data;
          });
        }
      } else {
        print('API Data is null');
      }
    } catch (error) {
      print('Error fetching data from Walmart API: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Walmart',style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Walmart Pricing
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Walmart Pricing For ${widget.productName}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Divider(thickness: 3.0, color: Colors.black87),
            // Use a ListView for the scrollable content
            Expanded(
              child: walmartSearchResults != null
                  ? ListView.builder(
                itemCount: walmartSearchResults.length,
                itemBuilder: (context, index) {
                  WalmartProduct product = walmartSearchResults[index];

                  // Print the price to the terminal
                  print('Price for ${product.title}: \$${product.offers.price}');

                  return Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 440, // Set the width of the text columns
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  '\$${product.offers.price}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Container(
                            width: double.infinity, // Set the width of the image column
                            child: Column(
                              children: [
                                Image.network(
                                  product.mainImage,
                                  height: 200.0,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );


                },
              )
                  : Center(
                child: CircularProgressIndicator(),
              ),
            ),


          ],
        ),
      ),
    );
  }

}


