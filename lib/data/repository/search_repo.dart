import 'package:houseofdelevryy/data/api/api_client.dart';
import 'package:houseofdelevryy/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getSearchData(String query, bool isRestaurant) async {
    return await apiClient.getData('${AppConstants.SEARCH_URI}${isRestaurant ? 'restaurants' : 'products'}/search?name=$query&offset=1&limit=50', query: {}, headers: {});
  }

  Future<Response> getSuggestedFoods() async {
    return await apiClient.getData(AppConstants.SUGGESTED_FOOD_URI, query: {}, headers: {});
  }

  Future<bool> saveSearchHistory(List<String> searchHistories) async {
    return await sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, searchHistories);
  }

  List<String> getSearchAddress() {
    return sharedPreferences.getStringList(AppConstants.SEARCH_HISTORY) ?? [];
  }

  Future<bool> clearSearchHistory() async {
    return sharedPreferences.setStringList(AppConstants.SEARCH_HISTORY, []);
  }
}