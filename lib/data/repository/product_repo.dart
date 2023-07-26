import 'package:houseofdelevryy/data/api/api_client.dart';
import 'package:houseofdelevryy/data/model/body/review_body.dart';
import 'package:houseofdelevryy/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductRepo extends GetxService {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});


  Future<Response> getPopularProductList(String type) async {
    return await apiClient.getData('${AppConstants.POPULAR_PRODUCT_URI}?type=$type', query: {}, headers: {});
  }

  Future<Response> getReviewedProductList(String type) async {
    return await apiClient.getData('${AppConstants.REVIEWED_PRODUCT_URI}?type=$type', query: {}, headers: {});
  }

  Future<Response> submitReview(ReviewBody reviewBody) async {
    return await apiClient.postData(AppConstants.REVIEW_URI, reviewBody.toJson(), query: {}, headers: {});
  }

  Future<Response> submitDeliveryManReview(ReviewBody reviewBody) async {
    return await apiClient.postData(AppConstants.DELIVER_MAN_REVIEW_URI, reviewBody.toJson(), query: {}, headers: {});
  }
}