import 'package:houseofdelevryy/data/api/api_client.dart';
import 'package:houseofdelevryy/data/model/body/place_order_body.dart';
import 'package:houseofdelevryy/data/model/body/place_subscribe_body.dart';
import 'package:houseofdelevryy/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  OrderRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getRunningOrderList(int offset) async {
    return await apiClient.getData('${AppConstants.RUNNING_ORDER_LIST_URI}?offset=$offset&limit=10', query: {}, headers: {});
  }

  Future<Response> getHistoryOrderList(int offset) async {
    return await apiClient.getData('${AppConstants.HISTORY_ORDER_LIST_URI}?offset=$offset&limit=10', query: {}, headers: {});
  }

  Future<Response> getOrderDetails(String orderID) async {
    return await apiClient.getData('${AppConstants.ORDER_DETAILS_URI}$orderID', query: {}, headers: {});
  }

  Future<Response> cancelOrder(String orderID) async {
    return await apiClient.postData(AppConstants.ORDER_CANCEL_URI, {'_method': 'put', 'order_id': orderID}, query: {}, headers: {});
  }

  Future<Response> trackOrder(String orderID) async {
    return await apiClient.getData('${AppConstants.TRACK_URI}$orderID', query: {}, headers: {});
  }

  Future<Response> placeOrder(PlaceOrderBody orderBody) async {
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, orderBody.toJson(), query: {}, headers: {});
  }

  Future<Response> placeSubscribeOrder(PlaceSubscribeBody orderSubscribeBody) async {
    print('COMING---------------------');
    print(orderSubscribeBody.toJson());
    // print(AppConstants.PLACE_ORDER_SUBSCRIBE_URI);
    return await apiClient.postData(AppConstants.PLACE_ORDER_SUBSCRIBE_URI, orderSubscribeBody.toJson(), query: {}, headers: {});
  }

  Future<Response> getDeliveryManData(String orderID) async {
    return await apiClient.getData('${AppConstants.LAST_LOCATION_URI}$orderID', query: {}, headers: {});
  }

  Future<Response> switchToCOD(String orderID) async {
    return await apiClient.postData(AppConstants.COD_SWITCH_URL, {'_method': 'put', 'order_id': orderID}, query: {}, headers: {});
  }

  Future<Response> getDistanceInMeter(LatLng originLatLng, LatLng destinationLatLng) async {
    return await apiClient.getData('${AppConstants.DISTANCE_MATRIX_URI}'
        '?origin_lat=${originLatLng.latitude}&origin_lng=${originLatLng.longitude}'
        '&destination_lat=${destinationLatLng.latitude}&destination_lng=${destinationLatLng.longitude}', query: {}, headers: {});
  }

}