import 'package:houseofdelevryy/data/api/api_client.dart';
import 'package:houseofdelevryy/data/model/response/address_model.dart';
import 'package:houseofdelevryy/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI,query: {}, headers: {});
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng',query: {}, headers: {});
  }

  Future<Response> removeAddressByID(int id) async {
    return await apiClient.postData('${AppConstants.REMOVE_ADDRESS_URI}$id',query: {}, headers: {}, {"_method": "delete"});
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(AppConstants.ADD_ADDRESS_URI, addressModel.toJson(), headers: {}, query: {});
  }

  Future<Response> updateAddress(AddressModel addressModel, int addressId) async {
    return await apiClient.putData('${AppConstants.UPDATE_ADDRESS_URI}$addressId', addressModel.toJson(), headers: {});
  }

  Future<bool> saveUserAddress(String address, List<int> zoneIDs) async {
    apiClient.updateHeader(
      sharedPreferences.getString(AppConstants.TOKEN), zoneIDs,
      sharedPreferences.getString(AppConstants.LANGUAGE_CODE),
    );
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  Future<Response> getAddressFromGeocode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}?lat=${latLng.latitude}&lng=${latLng.longitude}', query: {}, headers: {});
  }

  String? getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS);
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient.getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text', query: {}, headers: {});
  }

  Future<Response> getPlaceDetails(String placeID) async {
    return await apiClient.getData('${AppConstants.PLACE_DETAILS_URI}?placeid=$placeID', query: {}, headers: {});
  }

}