import 'package:houseofdelevryy/data/api/api_client.dart';
import 'package:houseofdelevryy/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CampaignRepo {
  final ApiClient apiClient;
  CampaignRepo({required this.apiClient});

  Future<Response> getBasicCampaignList() async {
    return await apiClient.getData(AppConstants.BASIC_CAMPAIGN_URI, query: {}, headers: {});
  }

  Future<Response> getCampaignDetails(String campaignID) async {
    return await apiClient.getData('${AppConstants.BASIC_CAMPAIGN_DETAILS_URI}$campaignID', query: {}, headers: {});
  }

  Future<Response> getItemCampaignList() async {
    return await apiClient.getData(AppConstants.ITEM_CAMPAIGN_URI, query: {}, headers: {});
  }

}