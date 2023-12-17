// This file handles all API calls to the Spoonacular API
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:grabsmartly/src/features/pages/models/ingredient_card_model.dart';
import 'package:grabsmartly/src/features/pages/models/recipe_detail_model.dart';
import '../../features/pages/models/ingredient_detail_card_model.dart';
import '../../features/pages/models/recipe_card_model.dart';

class RecipeApiService {
  // The API service will be a singleton, therefore create a private constructor
  // ApiService._instantiate(), and a static instance variable
  RecipeApiService._instantiate();

  static final RecipeApiService instance = RecipeApiService._instantiate();

  // Add base URL for the Spoonacular API, endpoint, and API Key as a constant
  final String _recipeBaseURL = "api.spoonacular.com";
  static const String Recipe_API_KEY = "4c672eb2935348b781376dbe100e9953"; // Replace with your API key
  //API 01 = "4c672eb2935348b781376dbe100e9953"
  //API 02 = "1c4ce3e282624e76accec1a42b21b0a4"
  //API 03 = "707339a2362f4333b201d69c7e0d8fc2 "

  // The fetchRecipeByType method fetches recipes based on the specified type
  Future<List<RecipeCardModel>> fetchRecipeByType(String type) async {
    Map<String, String> parameters = {
      'type': type,
      'includeNutrition': 'false',
      'apiKey': Recipe_API_KEY,
    };

    // Construct the URI for the complex search endpoint
    Uri uri = Uri.https(
      _recipeBaseURL,
      '/recipes/complexSearch',
      parameters,
    );

    // Specify headers for the request
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Try making the API request and handling the response
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body)['results'];
        List<RecipeCardModel> recipeCardModels = dataList.map((data) =>
            RecipeCardModel.fromMap(data)).toList();
        return recipeCardModels;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (err) {
      throw Exception('Failed to parse data from API: $err');
    }
  }

  // The fetchRecipe method fetches details of a specific recipe based on its ID
  Future<RecipeDetailModel> fetchRecipeDetails(int id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': Recipe_API_KEY,
    };

    // Construct the URI for the recipe information endpoint
    Uri uri = Uri.https(
      _recipeBaseURL,
      '/recipes/$id/information',
      parameters,
    );

    // Specify headers for the request
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Try making the API request and handling the response
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        RecipeDetailModel recipe = RecipeDetailModel.fromMap(data);
        return recipe;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (err) {
      throw Exception('Failed to parse data from API: $err');
    }
  }

  Future<List<RecipeCardModel>> fetchRecipesWithQuery(String query) async {
    Map<String, String> parameters = {
      'query': query,
      'includeNutrition': 'false',
      'apiKey': Recipe_API_KEY,
    };

    // Construct the URI for the complex search endpoint
    Uri uri = Uri.https(
      _recipeBaseURL,
      '/recipes/complexSearch',
      parameters,
    );

    // Specify headers for the request
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Try making the API request and handling the response
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body)['results'];
        List<RecipeCardModel> recipeCardModels =
        dataList.map((data) => RecipeCardModel.fromMap(data)).toList();
        return recipeCardModels;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (err) {
      throw Exception('Failed to parse data from API: $err');
    }
  }

  Future<List<RecipeCardModel>> fetchRecipesWithDiet(String diet) async {
    Map<String, String> parameters = {
      'diet': diet,
      'includeNutrition': 'false',
      'apiKey': Recipe_API_KEY,
    };

    // Construct the URI for the complex search endpoint
    Uri uri = Uri.https(
      _recipeBaseURL,
      '/recipes/complexSearch',
      parameters,
    );

    // Specify headers for the request
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Try making the API request and handling the response
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body)['results'];
        List<RecipeCardModel> recipeCardModels =
        dataList.map((data) => RecipeCardModel.fromMap(data)).toList();
        return recipeCardModels;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (err) {
      throw Exception('Failed to parse data from API: $err');
    }
  }

  Future<List<RecipeCardModel>> fetchRecipesWithCuisines(String cuisine) async {
    Map<String, String> parameters = {
      'cuisine': cuisine,
      'includeNutrition': 'false',
      'apiKey': Recipe_API_KEY,
    };

    // Construct the URI for the complex search endpoint
    Uri uri = Uri.https(
      _recipeBaseURL,
      '/recipes/complexSearch',
      parameters,
    );

    // Specify headers for the request
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Try making the API request and handling the response
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body)['results'];
        List<RecipeCardModel> recipeCardModels =
        dataList.map((data) => RecipeCardModel.fromMap(data)).toList();
        return recipeCardModels;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (err) {
      throw Exception('Failed to parse data from API: $err');
    }
  }

  // The fetchIngredient method fetches details of a specific ingredient based on its name
  Future<List<IngredientCardModel>> fetchIngredient(String name) async {
    Map<String, String> parameters = {
      'query': name,
      'includeNutrition': 'false',
      'apiKey': Recipe_API_KEY,
    };

    // Construct the URI for the ingredient search endpoint
    Uri uri = Uri.https(
      _recipeBaseURL,
      '/food/ingredients/search',
      parameters,
    );

    // Specify headers for the request
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Try making the API request and handling the response
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        List<dynamic> dataList = json.decode(response.body)['results'];
        List<IngredientCardModel> ingredients = dataList.map((data) =>
            IngredientCardModel.fromMap(data)).toList();
        return ingredients;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (err) {
      throw Exception('Failed to parse data from API: $err');
    }
  }

  Future<IngredientDetailCardModel> fetchIngredientInformation(int id) async {
    Map<String, String> parameters = {
      'apiKey': Recipe_API_KEY,
      'amount': '1',
    };

    // Construct the URI for the ingredient search endpoint
    Uri uri = Uri.https(
      _recipeBaseURL,
      '/food/ingredients/$id/information',
      parameters,
    );

    // Specify headers for the request
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        // Print the raw response to understand its structure
        print('Raw API Response: ${response.body}');

        // Parse the response body
        Map<String, dynamic> responseData = json.decode(response.body);

        // Use the response data as a map
        IngredientDetailCardModel ingredient =
        IngredientDetailCardModel.fromMap(responseData);
        return ingredient;
      } else {
        throw Exception('Failed to fetch data from API');
      }
    } catch (err) {
      throw Exception('Error during API request: $err');
    }
  }

}