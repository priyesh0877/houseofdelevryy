import 'package:houseofdelevryy/data/api/api_client.dart';
import 'package:houseofdelevryy/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<Response> getCategoryList() async {
    return await apiClient.getData(AppConstants.CATEGORY_URI, query: {},headers: {});
  }

  Future<Response> getSubCategoryList(String parentID) async {
    return await apiClient.getData('${AppConstants.SUB_CATEGORY_URI}$parentID', query: {}, headers: {});
  }

  Future<Response> getCategoryProductList(String categoryID, int offset, String type) async {
    return await apiClient.getData('${AppConstants.CATEGORY_PRODUCT_URI}$categoryID?limit=10&offset=$offset&type=$type', query: {}, headers: {});
  }

  Future<Response> getCategoryRestaurantList(String categoryID, int offset, String type) async {
    return await apiClient.getData('${AppConstants.CATEGORY_RESTAURANT_URI}$categoryID?limit=10&offset=$offset&type=$type',query: {}, headers: {});
  }

  Future<Response> getSearchData(String query, String categoryID, bool isRestaurant, String type) async {
    return await apiClient.getData(
      '${AppConstants.SEARCH_URI}${isRestaurant ? 'restaurants' : 'products'}/search?name=$query&category_id=$categoryID&type=$type&offset=1&limit=50', query: {}, headers: {},
    );
  }

  Future<Response> saveUserInterests(List<int> interests) async {
    return await apiClient.postData(AppConstants.INTEREST_URI, {"interest": interests}, headers: {}, query: {});
  }

}