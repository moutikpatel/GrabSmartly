class WalmartItemDetail {
  List<WalmartProduct> searchResults;

  WalmartItemDetail({
    required this.searchResults,
  });

  factory WalmartItemDetail.fromJson(Map<String, dynamic> json) {
    print("Raw JSON data: $json"); // Print the raw JSON data

    List<WalmartProduct> products = [];

    if (json.containsKey('search_results')) {
      var results = json['search_results'];

      if (results is List) {
        products = results.map((result) {
          if (result is Map<String, dynamic> &&
              result.containsKey('product') &&
              result.containsKey('offers')) {
            // Extract 'product' and 'offers' data
            var productData = result['product'];
            var offersData = result['offers'];

            // Parse WalmartProduct from productData and offersData
            return WalmartProduct.fromJson(productData, offersData);
          } else {
            print('Error parsing data: Unexpected data format for product or offers');
            return null;
          }
        }).whereType<WalmartProduct>().toList();
      }
    }

    return WalmartItemDetail(
      searchResults: products,
    );
  }
}

class WalmartProduct {
  String title;
  String mainImage;
  WalmartOffer offers;

  WalmartProduct({
    required this.title,
    required this.mainImage,
    required this.offers,
  });

  factory WalmartProduct.fromJson(Map<String, dynamic> productJson, Map<String, dynamic> offersJson) {
    print("Raw product JSON data: $productJson"); // Print the raw product JSON data

    return WalmartProduct(
      title: productJson['title'] ?? 'Unknown Title',
      mainImage: productJson['main_image'] ?? 'https://example.com/placeholder.jpg',
      offers: WalmartOffer.fromJson(offersJson),
    );
  }
}

class WalmartOffer {
  double price;
  String currencySymbol;
  String id;
  double listPrice;
  double savingsAmount;

  WalmartOffer({
    required this.price,
    required this.currencySymbol,
    required this.id,
    required this.listPrice,
    required this.savingsAmount,
  });

  factory WalmartOffer.fromJson(Map<String, dynamic> json) {
    print("Raw offer JSON data: $json"); // Print the raw offer JSON data

    var primaryOffer = json['primary'];

    // Extracting the price as a dynamic type
    dynamic priceValue = primaryOffer['price'];

    // Check if the price is a string and parse it if needed
    double price = (priceValue is String) ? double.tryParse(priceValue) ?? 0.0 : (priceValue ?? 0.0).toDouble();

    return WalmartOffer(
      price: price,
      currencySymbol: primaryOffer['currency_symbol'] ?? '',
      id: primaryOffer['id'] ?? '',
      listPrice: (primaryOffer['list_price'] ?? 0.0).toDouble(),
      savingsAmount: (primaryOffer['savings_amount'] ?? 0.0).toDouble(),
    );
  }
}
