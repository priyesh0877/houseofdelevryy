import 'package:houseofdelevryy/data/api/api_client.dart';
import 'package:houseofdelevryy/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class WishListRepo {
  final ApiClient apiClient;
  WishListRepo({required this.apiClient});

  Future<Response> getWishList() async {
    return await apiClient.getData(AppConstants.WISH_LIST_GET_URI, query: {}, headers: {});
  }

  Future<Response> addWishList(int id, bool isRestaurant) async {
    return await apiClient.postData('${AppConstants.ADD_WISH_LIST_URI}${isRestaurant ? 'restaurant_id=' : 'food_id='}$id', null, headers: {}, query: {});
  }

  Future<Response> removeWishList(int id, bool isRestaurant) async {
    return await apiClient.deleteData('${AppConstants.REMOVE_WISH_LIST_URI}${isRestaurant ? 'restaurant_id=' : 'food_id='}$id', headers: {});
  }
}