import 'package:flutter/material.dart';
import 'package:grabsmartly/src/routing/api_service/service_walmart_api.dart';
import '../../../models/walmart_card_model.dart';

class GroceryStoreCostCoPriceScreen extends StatefulWidget {
  final String productName;

  const GroceryStoreCostCoPriceScreen({required this.productName});

  @override
  _GroceryStoreCostCoPriceScreenState createState() =>
      _GroceryStoreCostCoPriceScreenState();
}

class _GroceryStoreCostCoPriceScreenState extends State<GroceryStoreCostCoPriceScreen> {
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
      print('Response Body: $data');

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
      print('Error fetching data from CostCo API: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CostCo',style: Theme.of(context).textTheme.titleLarge,),
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
                'CostCo Pricing For ${widget.productName}',
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

                  return Card(
                    elevation: 4.0,
                    child: Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0)
                            ),
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


